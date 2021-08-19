import 'package:get/get.dart';
import 'package:internet_speed_test/callbacks_enum.dart';
import 'package:internet_speed_test/internet_speed_test.dart';

class SpeedController extends GetxController {
  final internetSpeedTest = InternetSpeedTest();

  RxDouble downloadRate = 0.0.obs;
  RxString startBtn = "Start".obs;
  String downloadProgress = '0';

  String unitText = 'Mb/s';

  @override
  void onInit() {
    super.onInit();
  }

  // download speed test

  void downloadSpeedRate() {
    internetSpeedTest.startDownloadTesting(
      onDone: (double transferRate, SpeedUnit unit) {
        print('the download rate $transferRate');
        print("Completed");

        setSpeedRate(transferRate, unit, 100);
        Get.snackbar(
          "Progress",
          "Completed",
          snackPosition: SnackPosition.BOTTOM,
        );
        startBtn.value = "Start";
      },
      onProgress: (double percent, double transferRate, SpeedUnit unit) {
        
        setSpeedRate(
          transferRate,
          unit,
          percent,
        );
      },
      onError: (String errorMessage, String speedTestError) {
        print(
            'the errorMessage $errorMessage, the speedTestError $speedTestError');
        
      },
      fileSize: 20000000,
    );
  }

  // seeting download rate value

  void setSpeedRate(
    double transferRate,
    SpeedUnit unit,
    double percent,
  ) {
    downloadRate.value = transferRate;
    downloadProgress = percent.toInt().toString();
    startBtn.value = downloadProgress + " %";

    unitText = unit == SpeedUnit.Kbps ? 'Kb/s' : 'Mb/s';
  }

  

}
