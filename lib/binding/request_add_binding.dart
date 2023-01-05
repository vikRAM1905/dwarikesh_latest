
import 'package:dwarikesh/controller/request_add_controller.dart';
import 'package:get/get.dart';

class RequestAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RequestAddController());
  }
}
