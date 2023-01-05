
import 'package:dwarikesh/controller/yard_controller.dart';
import 'package:get/get.dart';
class YardStatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => YardStatusController());
  }
}