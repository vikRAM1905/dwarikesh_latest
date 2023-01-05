import 'package:get/get.dart';

import '../controller/form2_controller.dart';

class Form2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Form2Controller());
  }
}
