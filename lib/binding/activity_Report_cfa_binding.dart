

import 'package:dwarikesh/controller/activity_report_cfa_controller.dart';
import 'package:get/get.dart';

class ActivityReportCfaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ActivityReportCfaController());
  }
}