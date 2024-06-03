import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../data/models/message_model.dart';

Widget itemOfGeminiMessage(MessageModel message) {
  return Container(
    margin: EdgeInsets.only(top: 20),
    padding: EdgeInsets.all(16),
    width: double.infinity,
    child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  CupertinoIcons.gear,
                  color: Colors.grey,
                ),
                Icon(
                  CupertinoIcons.volume_up,
                  color: Colors.grey,
                )
              ]),
          Container(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                message.message!,
                style: TextStyle(color: Colors.grey),
              )),
        ],
      ),
    ),
  );
}
