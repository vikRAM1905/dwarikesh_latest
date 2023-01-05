
import 'package:dwarikesh/languages/en_us.dart';
import 'package:dwarikesh/languages/hi_in.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';

class LocalizationService extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'en': enUS,
    'hi': hiIN,
  };
}