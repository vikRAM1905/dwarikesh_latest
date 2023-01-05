
import 'package:dwarikesh/controller/activity_list_grower_controller.dart';
import 'package:dwarikesh/controller/activity_or_village_cfa_report_controller.dart';
import 'package:get/get.dart';

class ActivityorVillageCFAReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ActivityorVillageCFAReportController());
  }
}