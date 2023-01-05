

import 'package:dwarikesh/controller/grower_list_controller.dart';
import 'package:get/get.dart';


class GrowerListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GrowerListController());
  }
}
