import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gemini_app/core/services/utils_service.dart';
import 'package:gemini_app/data/repository/hive_repository_impl.dart';
import 'package:gemini_app/domain/usecases/gemini_text_and_image_usecase.dart';
import 'package:gemini_app/domain/usecases/get_messages_db_use_case.dart';
import 'package:gemini_app/domain/usecases/save_message_db_uscase.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../core/services/log_service.dart';
import '../../data/models/message_model.dart';
import '../../data/repository/gemini_talk_repository_impl.dart';
import '../../domain/usecases/gemini_only_text_usecase.dart';

class HomeController extends GetxController {
  List<MessageModel> messages = [];

  TextEditingController textController = TextEditingController();
  GeminiTextOnlyUseCase textOnlyUseCase =
      GeminiTextOnlyUseCase(GeminiTalkRepositoryImpl());

  GeminiTextAndImageUseCase textAndImageUseCase =
      GeminiTextAndImageUseCase(GeminiTalkRepositoryImpl());

  String? image;

  apiTextOnly(String text) async {
    var either = await textOnlyUseCase.call(text);
    either.fold((l) {
      LogService.d(l);
      var messageModel = MessageModel(message: l, isMine: false);
      messages.add(messageModel);
      update();
      saveMessages(messageModel);
    }, (r) async {
      LogService.d(r);
      var messageModel = MessageModel(message: r, isMine: false);
      messages.add(messageModel);
      update();
      saveMessages(messageModel);
    });
  }

  onSendPressed(String text) {
    var myMessage =
        MessageModel(message: text, isMine: true, base64Image: image);
    messages.add(myMessage);
    update();
    saveMessages(myMessage);

    if (image == null) {
      apiTextOnly(text);
    } else {
      apiTextAndImage(text, image!);
      image = null;
      update();
    }

    textController.clear();
  }

  onSelectImage() async {
    var base64 = await Utils.pickAndConvertImage();
    if (base64.trim().isNotEmpty) {
      image = base64;
      update();
    }
  }

  updateMessages(MessageModel messageModel) {
    messages.add(messageModel);
    update();
  }

  apiTextAndImage(String text, String imageBase64) async {
    var either =
        await textAndImageUseCase.call(textController.text, imageBase64);
    either.fold((l) {
      LogService.d(l);
      var messageModel = MessageModel(message: l, isMine: false);
      messages.add(messageModel);
      saveMessages(messageModel);
    }, (r) async {
      LogService.d(r);
      var messageModel = MessageModel(message: r, isMine: false);
      updateMessages(messageModel);
      saveMessages(messageModel);
    });
  }

  onRemoveImage() {
    image = null;
    update();
  }

  /// speech to text
  ///
  ///
  ///
  SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  Color microphoneColor = Colors.white;
  String _lastWords = '';

  void initSpeech() async {
    speechEnabled = await speechToText.initialize();
  }

  void startListening() async {
    await speechToText.listen(onResult: _onSpeechResult);
    microphoneColor = Colors.red;
    update();
  }

  void stopListening() async {
    await speechToText.stop();
    microphoneColor = Colors.white;
    update();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    _lastWords = result.recognizedWords;

    if (result.finalResult) {
      microphoneColor = Colors.white;

      onSendPressed(_lastWords);
      update();
    }
  }

  onStartListening() {
    speechToText.isNotListening ? startListening() : stopListening();
  }

  //local database
  GetMessagesDbUseCase databaseUseCase =
      GetMessagesDbUseCase(HiveRepositoryImplementation());

  SaveMessageUseCase saveMessageUseCase =
      SaveMessageUseCase(HiveRepositoryImplementation());

  getMessages() async {
    var either = await databaseUseCase.call();
    either.fold((l) {
      update();
    }, (r) async {
      messages.addAll(r);
      update();
    });
  }

  saveMessages(MessageModel messageModel) async {
    await saveMessageUseCase.call(messageModel);
  }

  //tts
  FlutterTts flutterTts = FlutterTts();

  String? language;
  String? engine;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;
  bool isCurrentLanguageInstalled = false;

  Color speekerColor = Colors.white;

  bool get isAndroid => !kIsWeb && Platform.isAndroid;

  bool get isIOS => !kIsWeb && Platform.isIOS;



  speak(String? text) async {
    speekerColor = Colors.white;
    update();
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (text != null) {
      if (text.isNotEmpty) {
        await flutterTts.speak(text);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }
}
