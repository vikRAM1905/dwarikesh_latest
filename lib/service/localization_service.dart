import 'dart:collection';

import 'package:dwarikesh/languages/en_us.dart';
import 'package:dwarikesh/languages/hi_in.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constant.dart';

class LocalizationService extends Translations {
// locale sẽ được get mỗi khi mới mở app (phụ thuộc vào locale hệ thống hoặc bạn có thể cache lại locale mà người dùng đã setting và set nó ở đây)
  static final locale = _getLocaleFromLanguage();

// fallbackLocale là locale default nếu locale được set không nằm trong những Locale support
  static final fallbackLocale = Locale('hi', 'IN');

// language code của những locale được support
  static final langCodes = [
    'en',
    'hi',
  ];

// các Locale được support
  static final locales = [
    Locale('en', 'US'),
    Locale('hi', 'IN'),
  ];

// cái này là Map các language được support đi kèm với mã code của lang đó: cái này dùng để đổ data vào Dropdownbutton và set language mà không cần quan tâm tới language của hệ thống
  static final langs = LinkedHashMap.from({
    'en': 'English',
    'hi': 'Hindi',
  });

// function change language nếu bạn không muốn phụ thuộc vào ngôn ngữ hệ thống
  static void changeLocale(String langCode) {
    print('CHANGE LOCALE  ${langCode}');
    final locale = _getLocaleFromLanguage(langCode: langCode);
    Get.updateLocale(locale);
    Get.forceAppUpdate();
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'hi_IN': hiIN,
      };

  static Locale _getLocaleFromLanguage({String? langCode}) {
    var lang = langCode ?? Prefs.getString(SAVE_LANG, 'hi');
    print('GET LOCAL FROM LANGUAGE ${lang}');
    for (int i = 0; i < langCodes.length; i++) {
      if (lang == langCodes[i]) {
        Prefs.setString(SAVE_LANG, langCodes[i]);
        return locales[i];
      }
    }
    return Get.locale!;
  }
}
