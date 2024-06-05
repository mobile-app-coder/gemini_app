import 'package:flutter/material.dart';
import 'package:gemini_app/core/services/log_service.dart';
import 'package:gemini_app/core/services/utils_service.dart';
import 'package:gemini_app/presentation/controllers/home_controller.dart';
import 'package:gemini_app/presentation/widgets/base64_image.dart';
import 'package:get/get.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  String image = 'text';

  choose() async {
    var result = await Utils.pickAndConvertImage();
    LogService.i(image);
    setState(() {
      image = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (_){
      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {
                choose();
              },
              child: Text("Pick an image"),
              color: Colors.blue,
            ),
            Expanded(
              child: Text(image),
            ),
            Base64Image(image)
          ],
        ),
      );
    });
  }
}
