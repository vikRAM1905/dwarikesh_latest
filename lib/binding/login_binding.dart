
import 'package:dwarikesh/controller/emp_login_controller.dart';
import 'package:dwarikesh/controller/grower_login_controller.dart';
import 'package:dwarikesh/controller/localization_controller.dart';
import 'package:dwarikesh/controller/login_controller.dart';
import 'package:get/get.dart';


class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => GrowerLoginController());
    Get.lazyPut(() => EmployeeLoginController());
    Get.lazyPut(() =>AppLanguage());

  }
}
