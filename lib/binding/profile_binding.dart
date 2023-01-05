
import 'package:dwarikesh/controller/login_controller.dart';
import 'package:dwarikesh/controller/profile_controller.dart';
import 'package:get/get.dart';


class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}
