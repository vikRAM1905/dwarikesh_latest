

import 'package:dwarikesh/controller/transaction_list_controller.dart';
import 'package:get/get.dart';

class TransactionListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionListController());
  }
}
