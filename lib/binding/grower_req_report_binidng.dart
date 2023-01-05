


import 'package:dwarikesh/controller/grower_list_controller.dart';
import 'package:dwarikesh/controller/grower_request_report.dart';
import 'package:get/get.dart';


class GrowerReqReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GrowerRequestReportctrl());
  }
}
