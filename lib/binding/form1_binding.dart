import 'package:get/get.dart';

import '../controller/form1_controller.dart';

class Form1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FormController());
  }
}
