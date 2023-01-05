import 'package:dwarikesh/controller/finance_list_controller.dart';
import 'package:get/get.dart';

import '../controller/form_view_controller.dart';

class FormViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FormViewController());
  }
}
