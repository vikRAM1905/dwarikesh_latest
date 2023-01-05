import 'package:dwarikesh/controller/harvesting_controller.dart';
import 'package:get/get.dart';

class HarvestingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HarvestingController());
  }
}
