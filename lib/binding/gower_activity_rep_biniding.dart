


import 'package:dwarikesh/controller/grower_activity_rep_controller.dart';
import 'package:dwarikesh/controller/grower_list_controller.dart';
import 'package:get/get.dart';


class GrowerActivityRepBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GrowerActivityRepCtrl());
  }
}
