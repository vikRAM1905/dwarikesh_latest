
import 'package:dwarikesh/controller/village_list_controller.dart';
import 'package:get/get.dart';
class VillagewiseListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VillageWiseListController());
  }
}
