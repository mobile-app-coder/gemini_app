import 'dart:convert';

import 'package:flutter/material.dart';

class Base64Image extends StatelessWidget {
  final String base64String;

  const Base64Image(this.base64String, {super.key});

  @override
  Widget build(BuildContext context) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.cover,
    );
  }
}
