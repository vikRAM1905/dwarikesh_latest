import 'package:dwarikesh/controller/grower_noApp_list_controller.dart';
import 'package:get/get.dart';

class GrowerNoAppListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GrowerNoAppListController());
  }
}
