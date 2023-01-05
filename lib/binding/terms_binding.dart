
import 'package:dwarikesh/controller/terms_controller.dart';
import 'package:get/get.dart';
class TermsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TermsController());
  }
}
