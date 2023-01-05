

import 'package:dwarikesh/controller/reqest_list_controller.dart';
import 'package:get/get.dart';

class RequestListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RequestListController());
  }
}
