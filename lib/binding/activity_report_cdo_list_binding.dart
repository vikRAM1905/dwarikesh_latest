
import 'package:dwarikesh/controller/activity_report_cdo_list_controller.dart';
import 'package:get/get.dart';


class ActivityReportCdoListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ActivityReportCdoListController());
  }
}