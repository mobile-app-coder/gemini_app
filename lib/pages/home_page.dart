import 'package:flutter/material.dart';

import '../services/https_service.dart';
import '../services/log_service.dart';
import '../services/utils_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  apiTextOnly() async {
    var text = "What is the best way to learn Flutter development?";
    var response = await Network.POST(
        Network.API_GEMINI_TALK, Network.paramsTextOnly(text));
    var result = Network.parseGeminiTalk(response!);
    LogService.i(result.candidates[0].content.parts[0].text);
  }

  apiTextAndImage() async {
    var text = "What is this image?";
    var base64Image = await Utils.pickAndConvertImage();
    LogService.i(base64Image);

    var response = await Network.POST(
        Network.API_GEMINI_TALK, Network.paramsTextAndImage(text, base64Image));
    var result = Network.parseGeminiTalk(response!);
    LogService.i(result.candidates[0].content.parts[0].text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Gemini"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              color: Colors.blue,
              onPressed: () {
                apiTextOnly();
              },
              child: const Text("Text Only Input"),
            ),
            MaterialButton(
              color: Colors.blue,
              onPressed: () {
                apiTextAndImage();
              },
              child: const Text("Text And Image Input"),
            ),
          ],
        ),
      ),
    );
  }
}
