

import 'package:dwarikesh/controller/activity_list_grower_controller.dart';
import 'package:get/get.dart';

class ActivityListGrowerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ActivityListGrowerController());
  }
}