

import 'package:dwarikesh/controller/finance_list_controller.dart';
import 'package:get/get.dart';


class FinanceListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FinanceListController());
  }
}
