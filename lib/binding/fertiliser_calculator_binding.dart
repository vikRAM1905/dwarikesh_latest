import 'package:dwarikesh/controller/activity_list_cfa_controller.dart';
import 'package:dwarikesh/controller/fertiliser_calculator_controller.dart';
import 'package:get/get.dart';

class FertiliserCalculatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FertiliserCalculatorController());
  }
}