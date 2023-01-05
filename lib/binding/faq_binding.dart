
import 'package:dwarikesh/controller/faq_controller.dart';
import 'package:get/get.dart';

class FAQsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FAQsController());
  }
}