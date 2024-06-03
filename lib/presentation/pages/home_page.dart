import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/core/constants/constants.dart';
import 'package:gemini_app/data/models/message_model.dart';
import 'package:gemini_app/data/repository/gemini_talk_repository_impl.dart';
import 'package:gemini_app/domain/repositories/gemini_talk_repository.dart';
import 'package:gemini_app/domain/usecases/gemini_only_text_usecase.dart';
import 'package:gemini_app/presentation/widgets/item_f_gemini_message.dart';
import 'package:gemini_app/presentation/widgets/item_of_user_message.dart';

import '../../core/services/log_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MessageModel> messages = [
    MessageModel(
        isMine: true, message: "How to learn Flutter", base64Image: IMAGE),
    MessageModel(
        isMine: false, message: "How to googny Flutter", base64Image: IMAGE),
    MessageModel(
        isMine: true,
        message: "Check flutter engineering course plan",
        base64Image: IMAGE),
    MessageModel(
        isMine: false,
        message:
            "Ok nice SBfjHBDfkjhDkjSKJbhSDJvbJSHvbJBDvjHBvdjhBSDVjh DbvJHvbdjhBsdvjHBSDvjhb DSjbhSJVbhEWBHJHBRJV DSVBsdjvBKADBV LAKJBFLKjefleiuwbf vbdvjhsvbajsvd dvjHBDVJHVBDjd",
        base64Image: IMAGE),
    MessageModel(
        isMine: true,
        message:
            "Check flutter engineering course plan turayev shahriyor nextgen flutter kali",
        base64Image: IMAGE),
  ];

  TextEditingController textController = TextEditingController();
  GeminiTextOnlyUseCase textOnlyUseCase =
      GeminiTextOnlyUseCase(GeminiTalkRepositoryImpl());

  apiTextOnly() async {
    var text = "What is the best way to learn Flutter development?";
    var either = await textOnlyUseCase.call(text);
    either.fold((l) {
      LogService.d(l);
    }, (r) async {
      LogService.d(r);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Container(
          child: Image.asset(
            height: 50,
            "assets/images/gemini_logo.png",

          ),
          margin: EdgeInsets.only(bottom: 10),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  var message = messages[index];
                  return message.isMine!
                      ? itemOfUserMessage(message)
                      : itemOfGeminiMessage(message);
                },
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(width: 2, color: Colors.grey.shade600)),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      onSubmitted: (text) {
                        textController.clear();
                      },
                      maxLines: null,
                      textInputAction: TextInputAction.send,
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Message",
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.attach_file,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.mic,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
