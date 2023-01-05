
import 'package:dwarikesh/controller/weather_controller.dart';
import 'package:get/get.dart';
class WeatherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WeatherController());
  }
}