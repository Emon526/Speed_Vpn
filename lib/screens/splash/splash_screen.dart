import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:lottie/lottie.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:speed_vpn/controllers/splash/splash_controller.dart';

class SpalshScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashController>(
        builder: (controller) => Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  child: Lottie.asset('assets/lottie/splash.json'),
                ),
              ),
              SizedBox(
                height: 150,
              ),
              LoadingFlipping.square(
                backgroundColor: Colors.blue,
                borderColor: Colors.blue,
                size: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
