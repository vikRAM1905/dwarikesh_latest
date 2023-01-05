import 'package:dwarikesh/controller/formList_controller.dart';
import 'package:get/get.dart';

class FormListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FormListController());
  }
}
