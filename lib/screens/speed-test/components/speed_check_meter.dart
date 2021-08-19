import 'package:flutter/material.dart';
import 'package:flutter_speedometer/flutter_speedometer.dart';

class SpeedCheckMeter extends StatelessWidget {
  final int currentValue;
  SpeedCheckMeter({@required this.currentValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      // child: SleekCircularSlider(
      //   initialValue: controller.value,
      //   min: 0.0,
      //   max: 100,
      //   appearance: CircularSliderAppearance(
      //     // spinnerMode: true,

      //     infoProperties: InfoProperties(
      //       bottomLabelText: "mpbs",
      //       topLabelText: "something",
      //       modifier: (double value) {
      //         print("Got value: $value");
      //         return "$value";
      //       },
      //     ),
      //   ),
      //   onChange: (double value) {
      //     print("val = $value");
      //     value = 10;
      //     // controller.changeValue();
      //     controller.changeValue(value);
      //   },
      //   onChangeEnd: (double value) {
      //     print("End value: $value");
      //   },
      //   onChangeStart: (double value) {
      //     print("On start: $value");
      //     // controller.changeValue();
      //   },

      child: Speedometer(
        displayNumericStyle: TextStyle(
          fontSize: 40.0,
          fontWeight: FontWeight.bold,
        ),
        displayTextStyle: TextStyle(
          fontSize: 22.0,
        ),
        size: 300,
        minValue: 0,
        maxValue: 10,
        currentValue: currentValue,
        warningValue: 9,
        displayText: 'mb/s',
        backgroundColor: Colors.white,
        meterColor: Colors.orange,
        kimColor: Colors.black,
      ),
    );
  }
}
