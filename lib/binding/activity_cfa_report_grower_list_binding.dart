
import 'package:dwarikesh/controller/activity_cfa_report_gower_list_controller.dart';

import 'package:get/get.dart';
class ActivityCFAReportGowerListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ActivityCFAReportGowerListController());
  }
}