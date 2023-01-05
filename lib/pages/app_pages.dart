import 'package:dwarikesh/binding/account_binding.dart';
import 'package:dwarikesh/binding/activity_cfa_report.dart';
import 'package:dwarikesh/binding/activity_cfa_report_grower_list_binding.dart';

import 'package:dwarikesh/binding/activity_Report_cfa_binding.dart';

import 'package:dwarikesh/binding/activity_list_cfa_binding.dart';
import 'package:dwarikesh/binding/activity_list_grower_binding.dart';
import 'package:dwarikesh/binding/activity_or_village_cdo_report_binding.dart';
import 'package:dwarikesh/binding/activity_or_village_cfa_report_binding.dart';
import 'package:dwarikesh/binding/activity_report_cdo_list_binding.dart';
import 'package:dwarikesh/binding/agri_implements_binding.dart';
import 'package:dwarikesh/binding/announcements_binding.dart';
import 'package:dwarikesh/binding/cfareport_grower_detail.dart';

import 'package:dwarikesh/binding/dashboard_binding.dart';
import 'package:dwarikesh/binding/faq_binding.dart';
import 'package:dwarikesh/binding/fertiliser_calculator_binding.dart';
import 'package:dwarikesh/binding/fertiliser_result.dart';
import 'package:dwarikesh/binding/finance_list_binding.dart';
import 'package:dwarikesh/binding/formList_binding.dart';
import 'package:dwarikesh/binding/gower_activity_rep_biniding.dart';
import 'package:dwarikesh/binding/grower_list_binding.dart';
import 'package:dwarikesh/binding/grower_req_report_binidng.dart';
import 'package:dwarikesh/binding/info_center_binding.dart';
import 'package:dwarikesh/binding/instant_diagnosis_binding.dart';
import 'package:dwarikesh/binding/login_binding.dart';
import 'package:dwarikesh/binding/otp_binding.dart';
import 'package:dwarikesh/binding/profile_binding.dart';
import 'package:dwarikesh/binding/request_add_binding.dart';
import 'package:dwarikesh/binding/request_detail_binding.dart';
import 'package:dwarikesh/binding/request_list_binding.dart';
import 'package:dwarikesh/binding/terms_binding.dart';
import 'package:dwarikesh/binding/transaction_list_binding.dart';
import 'package:dwarikesh/binding/village_list_binding.dart';
import 'package:dwarikesh/binding/weather_binding.dart';
import 'package:dwarikesh/binding/yard_binding.dart';

import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/view/account/accounts.dart';

import 'package:dwarikesh/view/activity/grower/activity_detail_grower.dart';
import 'package:dwarikesh/view/activity/cfa/activity_list_cfa.dart';
import 'package:dwarikesh/view/activity/grower/activity_list_grower.dart';
import 'package:dwarikesh/view/activity_report/cdo_report/activity_cfa_list.dart';
import 'package:dwarikesh/view/activity_report/cdo_report/activity_or_villagewise_cdo_report.dart';
import 'package:dwarikesh/view/activity_report/cdo_report/activity_report_cdo.dart';
import 'package:dwarikesh/view/activity_report/cfa_report/activity_gowerwise_report.dart';
import 'package:dwarikesh/view/activity_report/cfa_report/activity_or_villagewise_cfa_report.dart';
import 'package:dwarikesh/view/activity_report/cfa_report/activity_report_cfa.dart';
import 'package:dwarikesh/view/agri_implements/agri_implements_details.dart';
import 'package:dwarikesh/view/agri_implements/agri_implements_list.dart';
import 'package:dwarikesh/view/announcements/announcement_details.dart';
import 'package:dwarikesh/view/announcements/announcements_list.dart';

import 'package:dwarikesh/view/dashboard/home.dart';
import 'package:dwarikesh/view/diagnosis/instant_diagnosis.dart';
import 'package:dwarikesh/view/fertiliser/fertiliser_calculator.dart';
import 'package:dwarikesh/view/fertiliser/fertiliser_result.dart';
import 'package:dwarikesh/view/finance/add_expense.dart';
import 'package:dwarikesh/view/finance/finance_list.dart';
import 'package:dwarikesh/view/finance/finance_success.dart';
import 'package:dwarikesh/view/form/form_1.dart';
import 'package:dwarikesh/view/form/form_2.dart';
import 'package:dwarikesh/view/form/form_list_page.dart';
import 'package:dwarikesh/view/grower/gower_activity_report.dart';
import 'package:dwarikesh/view/grower/gower_detail.dart';
import 'package:dwarikesh/view/grower/grower_list.dart';
import 'package:dwarikesh/view/grower/grower_plot_detail.dart';
import 'package:dwarikesh/view/grower/grower_request.dart';
import 'package:dwarikesh/view/grower/village_list.dart';
import 'package:dwarikesh/view/infocenter/info_center_detail.dart';
import 'package:dwarikesh/view/infocenter/info_center_list.dart';
import 'package:dwarikesh/view/language/language_list.dart';
import 'package:dwarikesh/view/location_checking.dart';
import 'package:dwarikesh/view/login/login_form.dart';
import 'package:dwarikesh/view/otp.dart';
import 'package:dwarikesh/view/preview_image.dart';
import 'package:dwarikesh/view/profile/profile.dart';
import 'package:dwarikesh/view/request/add_request.dart';
import 'package:dwarikesh/view/request/request_detail.dart';
import 'package:dwarikesh/view/request/request_list.dart';
import 'package:dwarikesh/view/request/success.dart';
import 'package:dwarikesh/view/settings/about_us.dart';
import 'package:dwarikesh/view/settings/faqs_detail.dart';
import 'package:dwarikesh/view/settings/faqs_list.dart';
import 'package:dwarikesh/view/settings/settings_page.dart';
import 'package:dwarikesh/view/settings/terms_and_condition.dart';
import 'package:dwarikesh/view/settings/web_view.dart';
import 'package:dwarikesh/view/splash.dart';
import 'package:dwarikesh/view/transaction/mill_purchy_detail.dart';
import 'package:dwarikesh/view/transaction/payment_detail.dart';
import 'package:dwarikesh/view/transaction/plot_detail.dart';
import 'package:dwarikesh/view/transaction/supply_ticket_detail.dart';
import 'package:dwarikesh/view/transaction/transaction_list.dart';
import 'package:dwarikesh/view/weather/weather_info.dart';
import 'package:dwarikesh/view/yard/yard_status.dart';
import 'package:get/get.dart';

import '../binding/form1_binding.dart';
import '../binding/form2_binding.dart';
import '../binding/form_view_binding.dart';
import '../binding/grower_noApp_binding.dart';
import '../view/form/form_view.dart';
import '../view/grower/grower_noApp_list.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: ROUTE_SPLASH, page: () => SplashPage()),
    GetPage(
        name: ROUTE_LOGIN, page: () => LoginForm(), binding: LoginBinding()),
    GetPage(name: ROUTE_LOCATION, page: () => LocationCheck()),
    GetPage(
        name: ROUTE_HOME, page: () => HomePage(), binding: DashboardBinding()),
    GetPage(name: ROUTE_OTP, page: () => OTPScreen(), binding: OtpBinding()),
    GetPage(
        name: ROUTE_PROFILE,
        page: () => ProfilePage(),
        binding: ProfileBinding()),
    GetPage(
        name: ROUTE_REQUEST_LIST,
        page: () => RequestList(),
        binding: RequestListBinding()),
    GetPage(
        name: ROUTE_REQUEST_ADD,
        page: () => AddNewRequest(),
        binding: RequestAddBinding()),
    GetPage(name: ROUTE_REQUEST_SUCCESS, page: () => SuccessPage()),
    GetPage(
        name: ROUTE_REQUEST_DETAIL,
        page: () => RequestDetail(),
        binding: RequestDetailBinding()),
    GetPage(
        name: ROUTE_ACTIVITY_LIST_GROWER,
        page: () => ActivityListGrower(),
        binding: ActivityListGrowerBinding()),
    GetPage(
        name: ROUTE_ACTIVITY_DETAIL_GROWER,
        page: () => ActivityDetailGrower(),
        binding: ActivityListGrowerBinding()),
    GetPage(
        name: ROUTE_ACTIVITY_CFA_REPORT,
        page: () => ActivityReportCfa(),
        binding: ActivityReportCfaBinding()),
    GetPage(
        name: ROUTE_ACTIVITY_OR_VILLAGE_CFA_REPORT,
        page: () => ActivityorVillagewiseCFAReport(),
        binding: ActivityorVillageCFAReportBinding()),
    GetPage(
        name: ROUTE_ACTIVITY_CFA_REPORT_GROWER_LIST,
        page: () => ActivityCFAreportGowerList(),
        binding: ActivityCFAReportGowerListBinding()),
    GetPage(
        name: ROUTE_ACTIVITY_CDO_REPORT_LIST,
        page: () => ActivityReportCdoList(),
        binding: ActivityReportCdoListBinding()),
    GetPage(
        name: ROUTE_ACTIVITY_OR_VILLAGE_CDO_REPORT,
        page: () => ActivityorVillagewiseCDOReport(),
        binding: ActivityorVillageCDOReportBinding()),
    GetPage(
        name: ROUTE_ACTIVITY_CFA_CDO_REPORT,
        page: () => ActivityCFAReport(),
        binding: ActivityCFAReportBinding()),
    GetPage(
        name: ROUTE_ACTIVITY_CFA_GROWER,
        page: () => ActivityListCfa(),
        binding: ActivityListCfaBinding()),
    GetPage(
        name: ROUTE_FERTILISER_CALC,
        page: () => FertiliserCalculator(),
        binding: FertiliserCalculatorBinding()),
    GetPage(
        name: ROUTE_FERTILISER_RESULT,
        page: () => FertiliserResult(),
        binding: FertiliserResultBinding()),
    GetPage(
        name: ROUTE_AGRI_IMPLEMENTS_LIST,
        page: () => AgriImplementsList(),
        binding: AgriImplementsBinding()),
    GetPage(
        name: ROUTE_AGRI_IMPLEMENTS_DETAIL, page: () => AgriImplementsDetail()),
    GetPage(
        name: ROUTE_ANNOUNCEMENTS_LIST,
        page: () => AnnouncementsList(),
        binding: AnnouncementsBinding()),
    GetPage(name: ROUTE_ANNOUNCEMENTS_DETAIL, page: () => AnnouncementDetail()),
    GetPage(
        name: ROUTE_FINANCE_List,
        page: () => FinanceList(),
        binding: FinanceListBinding()),
    GetPage(name: ROUTE_EXPENSE_ADD, page: () => AddExpense()),
    GetPage(name: ROUTE_FINANCE_SUCCESS, page: () => FinanceSuccess()),
    GetPage(
        name: ROUTE_VILLAGE_LIST,
        page: () => VillagewiseList(),
        binding: VillagewiseListBinding()),
    GetPage(
        name: ROUTE_GROWER_LIST,
        page: () => GrowerList(),
        binding: GrowerListBinding()),
    GetPage(
        name: ROUTE_GROWER_NO_APP_LIST,
        page: () => GrowerNoAppList(),
        binding: GrowerNoAppListBinding()),
    GetPage(
        name: ROUTE_TRANSACTION_LIST,
        page: () => TransactionList(),
        binding: TransactionListBinding()),
    GetPage(name: ROUTE_SUPPLY_TICKET_DETAIL, page: () => SupplyTicketDetail()),
    GetPage(name: ROUTE_MILL_PURCHY_DETAIL, page: () => MillPurchyDetails()),
    GetPage(name: ROUTE_PAYMENTS_DETAIL, page: () => PaymentDetails()),
    GetPage(name: ROUTE_PLOT_DETAIL, page: () => PlotDetails()),
    GetPage(
        name: ROUTE_WEATHER,
        page: () => WeatherInfo(),
        binding: WeatherBinding()),
    GetPage(name: ROUTE_LANGUAGE, page: () => LanguagePage()),
    GetPage(name: ROUTE_SETTING, page: () => SettingsPage()),
    GetPage(name: ROUTE_FAQ, page: () => FAQsList(), binding: FAQsBinding()),
    GetPage(name: ROUTE_FAQ_DETAIL, page: () => FAQsDetails()),
    GetPage(
        name: ROUTE_TERMS_AND_CONDITION,
        page: () => TermsAndCondition(),
        binding: TermsBinding()),
    GetPage(
        name: ROUTE_ABOUTS_US, page: () => AboutsUs(), binding: TermsBinding()),
    GetPage(
        name: ROUTE_INFO_CENTER_LIST,
        page: () => InfoCenterList(),
        binding: InfoCenterBinding()),
    GetPage(name: ROUTE_INFO_CENTER_DETAIL, page: () => InfoCenterDetail()),
    GetPage(name: ROUTE_INSTANT_DIAGNOSIS, page: () => InstantDiagnosisList()),
    GetPage(name: ROUTE_WEB_VIEW, page: () => WebViewData()),
    GetPage(name: ROUTE_IMAGE_VIEW, page: () => PreviewImage()),
    GetPage(
        name: ROUTE_CFA_REPORT_GROWER_DETAIL,
        page: () => GowerDetailReport(),
        binding: CfaReportGowerDetailBinding()),
    GetPage(
        name: ROUTE_ACCOUNT_LIST,
        page: () => AccountsList(),
        binding: AccountBinding()),
    GetPage(name: ROUTE_CFA_REPORT_GROWER_PLOT, page: () => GowerPlotDetail()),
    GetPage(
        name: ROUTE_CFA_REPORT_GROWER_REQ,
        page: () => GrowerRequestReport(),
        binding: GrowerReqReportBinding()),
    GetPage(
        name: ROUTE_CFA_REPORT_GROWER_ACTIVIY,
        page: () => GrowerActivityReport(),
        binding: GrowerActivityRepBinding()),
    GetPage(
        name: ROUTE_YARD_ACTIVIY,
        page: () => YardStatus(),
        binding: YardStatusBinding()),
    GetPage(
        name: ROUTE_FORM_LIST,
        page: () => FormListPage(),
        binding: FormListBinding()),
    GetPage(name: ROUTE_FORM_1, page: () => Form1(), binding: Form1Binding()),
    GetPage(name: ROUTE_FORM_2, page: () => Form2(), binding: Form2Binding()),
    GetPage(
        name: ROUTE_FORM_VIEW,
        page: () => FormViewPage(),
        binding: FormViewBinding()),
  ];
}
