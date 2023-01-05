


import 'package:dwarikesh/controller/agri_implements_controller.dart';
import 'package:get/get.dart';


class AgriImplementsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AgriImplementsController());
  }
}