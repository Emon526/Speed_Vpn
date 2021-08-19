import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speed_vpn/controllers/speed-controller/speed_controller.dart';
import 'package:speed_vpn/screens/speed-test/components/speed_check_meter.dart';

class SpeedTestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SpeedController controller = Get.put(SpeedController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Speed Test",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Obx(
                () => SpeedCheckMeter(
                  currentValue: controller.downloadRate.value.toInt(),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Center(
                  child: ElevatedButton(
                    child: Obx(
                      () => Text(
                        controller.startBtn.value,
                      ),
                    ),
                    onPressed: () {
                      controller.downloadSpeedRate();
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.2,
                          vertical: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromRGBO(65, 27, 126, 1),
                      ),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
          ],
        ),
       
      ),
    );
  }
}
