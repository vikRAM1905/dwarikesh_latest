
import 'package:dwarikesh/controller/activity_or_village_cdo_report_controller.dart';
import 'package:get/get.dart';

class ActivityorVillageCDOReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ActivityorVillageCDOReportController());
  }
}