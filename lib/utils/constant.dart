import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:package_info/package_info.dart';
import 'common_method.dart';

const String AppName = 'Dwarikesh';
const String AppsubName = 'Sugar Industry Limited';
const String slash = '/';

/*THEME*/
const UserThemeData = 'UserThemeData';
/*LANUGAE */
const String SAVE_LANG = 'SAVELANG';

/*PAGE ROUTER*/
const ROUTE_SPLASH = slash + "splash";
const ROUTE_LOGIN = slash + "login";
const ROUTE_LOCATION = slash + "location";

const ROUTE_HOME = slash + "home";
const ROUTE_OTP = slash + "otp";
const ROUTE_PROFILE = slash + "profile";
const ROUTE_REQUEST_LIST = slash + "requestList";
const ROUTE_REQUEST_ADD = slash + "requestAdd";
const ROUTE_OTP_MSG = slash + "otpmsg";
const ROUTE_OTP_TITLE = slash + "otptitle";
const ROUTE_REQUEST_SUCCESS = slash + "requestSuccess";
const ROUTE_REQUEST_DETAIL = slash + "requestDetail";
const ROUTE_ACTIVITY_LIST_GROWER = slash + "activityListGrower";
const ROUTE_ACTIVITY_DETAIL_GROWER = slash + "activityDetailGrower";
const ROUTE_ACTIVITY_COMPLETED_GOWERWISE_CDO =
    slash + "activityCompletedGrowerListCDO";
const ROUTE_ACTIVITY_COMPLETED_GOWERWISE =
    slash + "activityCompletedGrowerList";
const ROUTE_ACTIVITY_CFA_GROWER = slash + "activityListCfa";
const ROUTE_ACTIVITY_CFA_REPORT = slash + "activityreportCfa";
const ROUTE_ACTIVITY_OR_VILLAGE_CFA_REPORT =
    slash + "activityorvillagereportCfa";
const ROUTE_ACTIVITY_CFA_REPORT_GROWER_LIST =
    slash + "activitycfareportGowerlist";
const ROUTE_ACTIVITY_CDO_REPORT_LIST = slash + "ActivityReportCdoList";
const ROUTE_ACTIVITY_CFA_GRAPH = slash + "activityGraphCfa";
const ROUTE_ACTIVITY_OR_VILLAGE_CDO_REPORT =
    slash + "activityorvillagereportCdo";
const ROUTE_ACTIVITY_CFA_CDO_REPORT = slash + "activitycfareportCdo";
const ROUTE_ACTIVITY_CDO_REPORT_GOWER_LIST =
    slash + "activitycfareportCdogrowerList";
const ROUTE_ACTIVITY_CDO_GROWER = slash + "activityListCdo";
const ROUTE_ACTIVITY_CDO_GRAPH = slash + "activityGraphCdo";
const ROUTE_LANGUAGE = slash + "language";
const ROUTE_FERTILISER_CALC = slash + "fertiliser";
const ROUTE_FERTILISER_RESULT = slash + "fertiliserResult";
const ROUTE_AGRI_IMPLEMENTS_LIST = slash + "agriImplementList";
const ROUTE_AGRI_IMPLEMENTS_DETAIL = slash + "agriImplementDetail";
const ROUTE_ANNOUNCEMENTS_LIST = slash + "announcementList";
const ROUTE_ANNOUNCEMENTS_DETAIL = slash + "announcementDetail";
const ROUTE_FINANCE_List = slash + "financeList";
const ROUTE_EXPENSE_ADD = slash + "expenseAdd";
const ROUTE_FINANCE_SUCCESS = slash + "finance_success";
const ROUTE_VILLAGE_LIST = slash + "villageList";
const ROUTE_GROWER_LIST = slash + "growerList";
const ROUTE_GROWER_NO_APP_LIST = slash + "growerNoAppList";
const ROUTE_TRANSACTION_LIST = slash + "transactionList";
const ROUTE_SUPPLY_TICKET_DETAIL = slash + "supplyTicketDetail";
const ROUTE_MILL_PURCHY_DETAIL = slash + "millPurchyDetail";
const ROUTE_PAYMENTS_DETAIL = slash + "paymentDetail";
const ROUTE_PLOT_DETAIL = slash + "plotDetail";
const ROUTE_WEATHER = slash + "weather";
const ROUTE_SETTING = slash + "setting";
const ROUTE_FAQ = slash + "faq";
const ROUTE_FAQ_DETAIL = slash + "faqDetail";
const ROUTE_TERMS_AND_CONDITION = slash + "termsAndCondition";
const ROUTE_ABOUTS_US = slash + "Abouts";
const ROUTE_INFO_CENTER_LIST = slash + "infoCenter";
const ROUTE_INFO_CENTER_DETAIL = slash + "infoCenterDetail";
const ROUTE_INSTANT_DIAGNOSIS = slash + "instant_diagnosis";
const ROUTE_WEB_VIEW = slash + "webview";
const ROUTE_ACCOUNT_LIST = slash + "accountList";
const ROUTE_IMAGE_VIEW = slash + "PreviewImage";
const ROUTE_CFA_REPORT_GROWER_DETAIL = slash + "cfaReportGrowerDetail";
const ROUTE_CFA_REPORT_GROWER_PLOT = slash + "cfaReportGrowerPlotDetail";
const ROUTE_CFA_REPORT_GROWER_REQ = slash + "cfaReportGrowerReqDetail";
const ROUTE_CFA_REPORT_GROWER_ACTIVIY = slash + "cfaReportGrowerActivityDetail";
const ROUTE_YARD_ACTIVIY = slash + "YardStatus";
const ROUTE_FORM_LIST = slash + "FormList";
const ROUTE_FORM_1 = slash + "Form1";
const ROUTE_FORM_2 = slash + "Form2";
const ROUTE_FORM_VIEW = slash + "FormView";

/* PREF DATA */
const String AUTH_CODE = 'AUTH_CODE';
const String OTP_CODE = 'OTP_CODE';
const String STATUS = 'STATUS';
const String LOGIN_MODEL = 'LOGIN_MODEL';
const String TOKEN = 'TOKEN';
const String ROLE_ID = 'ROLE_ID';
const String USER_ID = 'USER_ID';
const String MOB = 'MOB';
const String CODE = 'CODE';
const String ADDRESS = 'ADDRESS';
const String FCM_TOKEN = 'FCM_TOKEN';
const String SUCCUSS_MSG = 'SUCCUSS_MSG';
const String ENABLE_BTN = 'ENABLE_BTN';
const String CFA_ID = 'CFA_ID';
const String VILLAGE_ID = 'VILLAGE_ID';
const String GROWER_ID = 'GROWER_ID';
const String GROWER_ACTIVITY_ID = 'GROWER_ACTIVITY_ID';
const String ACTIVITY_ID = 'ACTIVITY_ID';
const String TITLE = 'TITLE';
const String TITLE_GOWER_OR_NAME = 'TITLE_GOWER_OR_NAME';
const String TERMSANDCONDITION_DATA = 'TERMSANDCONDITION_DATA';
const String ABOUTUS_DATA = 'ABOUTUS_DATA';

/* CONSTANT DATA */
const String ZONAL_INCHARGE = '4';
const String CFA = '5';
const String GROWER = '6';
const String DATA_NULL_HANDLER = '-';
const String LAND_CALCUALTED_TYPE = 'ha';
const String REJECTED = 'Rejected';
const String APPROVED = 'Approved';
const String LAT = 'LAT';
const String LONG = 'LONG';
const String Rs = '\u20B9';
const String VERSION_CODE = 'VERSION_CODE';
const String ACCOUNT_CODE = 'ACCOUNT_CODE';

const String USERUNIT = 'USERUNIT';
const String UNIT = 'UNIT';
const String COMBINATION = 'COMBINATION';
const String CROP_TYPE = 'CROP_TYPE';
const String USE_OF_FERTILIZER = 'USE_OF_FERTILIZER';

List<String> requestType = [
  'Factory official visit',
  'Crop Management Related',
  'Insect / Pest / Disease Incidence Reporting',
  'Extraneous Weather Condition Related',
  'Society related',
  'Labour/Trolley/Machine',
  'Other'
];

List<String> amountTypes = [
  'income'.tr,
  'expense'.tr,
];

List<String> requestFilterType = [
  'All',
  'Factory official visit',
  'Crop Management Related',
  'Insect / Pest / Disease Incidence Reporting',
  'Extraneous Weather Condition Related',
  'Society related',
  'Labour/Trolley/Machine',
  'Other'
];

List sideGrowerMenuList = [
  {
    "icon": "assets/images/personalinfo_d.png",
    "title": "personal_info",
    "id": 1,
    "color": Color(0xFF3D5B99)
  },
  {
    "icon": "assets/images/activityschedule_d.png",
    "title": "activity_schedule",
    "id": 2,
    "color": Color(0xFF995A26)
  },
  /* {"icon": "assets/images/query.png", "title": "farmers_query", "id": 3},*/
  {
    "icon": "assets/images/mydatalists_d.png",
    "title": "my_data_lists",
    "id": 4,
    "color": Color(0xFF998D26)
  },
  /*{"icon": "assets/images/plant.png", "title": "weather_forecast", "id": 6},*/
  {
    "icon": "assets/images/accounting_d.png",
    "title": "accounting",
    "id": 7,
    "color": Color(0xFF36997C)
  },
/*  {"icon": "assets/images/plant.png", "title": "settings", "id": 11},*/
  {
    "icon": "assets/images/fertilizer_dosage.png",
    "title": "fertilizer_dosage",
    "id": 8,
    "color": Color(0xFF991F56)
  },
/*  {"icon": "assets/images/plant.png", "title": "important_message", "id": 9},*/
  {
    "icon": "assets/images/krishi_yantra.png",
    "title": "krishi_yantra",
    "id": 10,
    "color": Color(0xFF7B1F99)
  },
  {
    "icon": "assets/images/cane_ebook.png",
    "title": "hand_book",
    "id": 5,
    "color": Color(0xFF998D26)
  },
  // {"icon": "assets/images/harvest.png", "title": "harvesting", "id": 98}, //now for twics only
  {
    "icon": "assets/images/instant_diagnosis.png",
    "title": "instant_diagnosis",
    "id": 99,
    "color": Color(0xFF4E661F)
  },
];

List sideCFAMenuList = [
  {
    "icon": "assets/images/personal_info.png",
    "title": "personal_info",
    "id": 1
  },
  {
    "icon": "assets/images/activity_schedule.png",
    "title": "activity_schedule",
    "id": 12
  },
  {"icon": "assets/images/plant.png", "title": "activity_report", "id": 16},
  /* {"icon": "assets/images/query.png", "title": "farmers_query", "id": 3},*/
  {"icon": "assets/images/growerlists.png", "title": "grower_list", "id": 13},
  {"icon": "assets/images/handbook.png", "title": "hand_book", "id": 5},
/*  {"icon": "assets/images/plant.png", "title": "weather_forecast", "id": 6},*/
  {"icon": "assets/images/dosage.png", "title": "fertilizer_dosage", "id": 8},
  /* {"icon": "assets/images/plant.png", "title": "important_message", "id": 9},*/
  {"icon": "assets/images/krishi.png", "title": "krishi_yantra", "id": 10},
  {
    "icon": "assets/images/diagnosis.png",
    "title": "instant_diagnosis",
    "id": 99
  },
  {"icon": "assets/images/form.png", "title": "demo_plots", "id": 100},
  /*{"icon": "assets/images/plant.png", "title": "settings", "id": 11},*/
];
List sideCDOMenuList = [
  {
    "icon": "assets/images/personal_info.png",
    "title": "personal_info",
    "id": 1
  },
  {"icon": "assets/images/cfalists.png", "title": "activity_report", "id": 17},
/*  {"icon": "assets/images/query.png", "title": "escalations", "id": 3},*/
/*  {"icon": "assets/images/plant.png", "title": "weather_forecast", "id": 6},*/
  {"icon": "assets/images/growerlists.png", "title": "grower_list", "id": 13},
  {"icon": "assets/images/dosage.png", "title": "fertilizer_dosage", "id": 8},
/*  {"icon": "assets/images/plant.png", "title": "important_message", "id": 9},*/
  {"icon": "assets/images/krishi.png", "title": "krishi_yantra", "id": 10},
  {"icon": "assets/images/handbook.png", "title": "hand_book", "id": 5},
  {
    "icon": "assets/images/diagnosis.png",
    "title": "instant_diagnosis",
    "id": 99
  },
  {"icon": "assets/images/form.png", "title": "demo_plots", "id": 100},
/*  {"icon": "assets/images/plant.png", "title": "settings", "id": 11},*/
];

Map<String, dynamic> readAndroidBuildData(AndroidDeviceInfo build) {
  Map<String, dynamic> local_data = <String, dynamic>{
    'version.securityPatch': build.version.securityPatch,
    'version.sdkInt': build.version.sdkInt,
    'version.release': build.version.release,
    'version.previewSdkInt': build.version.previewSdkInt,
    'version.incremental': build.version.incremental,
    'version.codename': build.version.codename,
    'version.baseOS': build.version.baseOS,
    'board': build.board,
    'bootloader': build.bootloader,
    'brand': build.brand,
    'device': build.device,
    'display': build.display,
    'fingerprint': build.fingerprint,
    'hardware': build.hardware,
    'host': build.host,
    'id': build.id,
    'manufacturer': build.manufacturer,
    'model': build.model,
    'product': build.product,
    'supported32BitAbis': build.supported32BitAbis,
    'supported64BitAbis': build.supported64BitAbis,
    'supportedAbis': build.supportedAbis,
    'tags': build.tags,
    'type': build.type,
    'isPhysicalDevice': build.isPhysicalDevice,
    'androidId': build.androidId,
    'systemFeatures': build.systemFeatures,
  };

  print('DEVEICE DATA =============  ${local_data}');

  return <String, dynamic>{
    "token": "${Prefs.getString(FCM_TOKEN)}",
    "deviceType": "ANDROID",
    "release": "${build.version.release}",
    "version": "${build.version.sdkInt}",
    "id": "${build.id}",
    "brand": "${build.brand}",
    "model": "${build.model}",
    "board": "${build.board}",
    "lang": "${getLanguage()}",
  };
}

Map<String, dynamic> readIosDeviceInfo(IosDeviceInfo data) {
  return <String, dynamic>{
    "token": "${Prefs.getString(FCM_TOKEN)}",
    "deviceType": "IOS",
    "release": "${data.utsname.release}",
    "version": "${data.systemVersion}",
    "id": "${data.identifierForVendor}",
    "brand": "${data.model}",
    "model": "${data.name}",
    "board": "${data.systemName}",
    "lang": "${getLanguage()}",
  };
}
