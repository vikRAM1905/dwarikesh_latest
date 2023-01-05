
import 'package:dwarikesh/controller/request_detail_controller.dart';
import 'package:get/get.dart';

class RequestDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RequestDetailController());
  }
}
