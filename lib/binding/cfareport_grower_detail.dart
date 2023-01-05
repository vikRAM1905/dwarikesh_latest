
import 'package:dwarikesh/controller/cfareport_grower_details.dart';
import 'package:get/get.dart';

class CfaReportGowerDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CFaReportGrowerDetail());
  }
}