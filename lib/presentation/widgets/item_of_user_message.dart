import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/models/message_model.dart';

Widget itemOfUserMessage(MessageModel message) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            constraints: const BoxConstraints(maxWidth: 300),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(38, 39, 41, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(30),
                  topRight: Radius.circular(5)
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message.message!,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                ),
                message.base64Image != null ? Container(
                  height: 300,
                  padding: const EdgeInsets.only(top: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.memory(
                      base64Decode(message.base64Image!),
                      fit: BoxFit.fill,
                    ),
                  ),
                ):SizedBox()
              ],
            ),
          ),
        ],
      ),
    ],
  );
}
