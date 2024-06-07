import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/presentation/controllers/home_controller.dart';

import '../../data/models/message_model.dart';

Widget itemOfGeminiMessage(MessageModel message, HomeController controller) {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    padding: const EdgeInsets.all(16),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Icon(
            CupertinoIcons.gear,
            color: Colors.grey,
          ),
          GestureDetector(
            onTap: () {
              controller.speak(message.message);
            },
            child: const Icon(
              CupertinoIcons.volume_up,
              color: Colors.grey,
            ),
          )
        ]),
        Container(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              message.message!,
              style: const TextStyle(color: Colors.grey),
            )),
      ],
    ),
  );
}
