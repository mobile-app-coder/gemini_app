import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:gemini_app/core/services/utils_service.dart';
import 'package:gemini_app/domain/usecases/gemini_text_and_image_usecase.dart';
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
    var either = await textOnlyUseCase.call(textController.text);
    either.fold((l) {
      LogService.d(l);
      var messageModel = MessageModel(message: l, isMine: false);
      messages.add(messageModel);
    }, (r) async {
      LogService.d(r);
      var messageModel = MessageModel(message: r, isMine: false);
      messages.add(messageModel);
      update();
    });
  }

  onSendPressed(String text) {
    var myMessage =
        MessageModel(message: text, isMine: true, base64Image: image);
    messages.add(myMessage);
    update();

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
    }, (r) async {
      LogService.d(r);
      var messageModel = MessageModel(message: r, isMine: false);
      updateMessages(messageModel);
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
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
  }

  void startListening() async {
    _speechEnabled = true;
    await _speechToText.listen(onResult: _onSpeechResult);

  }

  void stopListening() async {
    _speechEnabled = false;
    await _speechToText.stop();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    _lastWords = result.recognizedWords;
    onSendPressed(_lastWords);
  }

  onStartListening() {
    _speechToText.isNotListening ? startListening() : stopListening();
  }
}
