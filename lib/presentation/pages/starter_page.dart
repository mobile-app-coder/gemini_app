import 'package:flutter/material.dart';
import 'package:gemini_app/presentation/controllers/home_controller.dart';
import 'package:gemini_app/presentation/controllers/starter_controller.dart';
import 'package:gemini_app/presentation/pages/home_page.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class StarterPage extends StatefulWidget {
  const StarterPage({super.key});

  @override
  State<StarterPage> createState() => _StarterPageState();
}

class _StarterPageState extends State<StarterPage> {
  StarterController starterController = Get.find<StarterController>();

  @override
  void initState() {
    super.initState();
    starterController.initVideoPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    starterController.onDispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(top: 60),
            height: 60,
            child: Image.asset(
              "assets/images/gemini_logo.png",
              height: 60,
            ),
          ),
          Expanded(
            child: starterController.controller.value.isInitialized
                ? VideoPlayer(starterController.controller)
                : Container(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white, width: 2)),
                child: MaterialButton(
                    onPressed: () {
                      Get.to(const HomePage());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Chat with gemini'.toUpperCase(),
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )
                      ],
                    )),
              ),
            ],
          )
        ]),
      ),
    );
  }

  Route _rout() {
    return PageRouteBuilder(
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          alignment: Alignment.center,
          scale: Tween<double>(begin: 0.1, end: 1).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.bounceIn,
            ),
          ),
          child: child,
        );
      },
      transitionDuration: Duration(seconds: 2),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return HomePage();
      },
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          final offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        });
  }
}
