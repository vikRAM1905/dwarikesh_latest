

import 'package:dwarikesh/controller/instant_diagnosis_controller.dart';
import 'package:get/get.dart';

class InstantDiagnosisListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() =>InstantDiagnosisListController());
  }
}
