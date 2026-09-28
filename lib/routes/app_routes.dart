import 'package:rnw_institue/presentation/rnw_announcement_screen/rnw_announcement_preview_screen.dart';
import 'package:rnw_institue/presentation/rnw_announcement_screen/rnw_announcement_screen.dart';
import 'package:rnw_institue/presentation/rnw_feedback_screen/rnw_feedback_webiew.dart';
import 'package:rnw_institue/presentation/rnw_help_center_screen/rnw_help_center_screen.dart';
import 'package:rnw_institue/presentation/rnw_notification_screen/rnw_notification_screen.dart';
import 'package:rnw_institue/utils/app_export.dart';

class AppRoutes {
  static const String initialRoute = '/initialRoute';
  static const String splashScreen = '/splash_Screen';
  static const String loginScreen = '/login_screen';
  static const String homeScreen = "/home_screen";
  static const String rnwCourseDetailsscreen = '/rnw_course_detais_screen';
  // static const String rnwcoursescreen = '/rnw_course_screen';
  static const String rnwsigningsheetscreen = '/rnw_signing_sheet_scree';
  static const String rnwfeesdetailsscreen = '/rnw_fees_details_screen';
  static const String rnwcertificatescreen = "/rnw_certificate_screen";
  static const String rnwfeedbackscreen = "/rnw_feedback_screen";
  static const String rnwhomescreen = "/rnw_home_screen";
  static const String studentinfoscreen = "/student_info_screen";
  static const String rnwattendancescreen = "/rnw_attendance_screen";
  static const String rnwreportdetailsscreen = "/rnw_report_details_screen";
  static const String rnwprofilescreen = "/rnw_profile_screen";
  static const String rnwsettingsscreen = "/rnw_settings_screen";
  static const String rnehelpandfeedback = "/rnw_help_and_feedback_screen";
  static const String rnwCertificateFormscreen = "/rnw_certificate_form";
  static const String rnwtermsandconditionscreen = '/rnw_terms_and_condition_screen';
  static const String rnwcontactusscreen = '/rnw_contact_us_screen';
  static const String rnwviewcoursescreen = '/rnw_view_course_screen';
  static const String rnwnotificationslist = '/rnw_notifications_list';
  static const String rnwAnnouncementlist = '/rnw_announcement_list';
  static const String rnwAnnouncementPreviewlist = '/rnw_announcement_preview_list';
  static const String rnwhelpcenter = '/rnw_help_center';
  static const String rNWReportScreen = '/rnw_report_screen';
  static const String rNWfeedbackwebviewScreen = '/rnw_feedback_webview_screen';

  static Map<String, WidgetBuilder> get routes => {
        initialRoute: SplashScreen.builder,
        splashScreen: SplashScreen.builder,
        loginScreen: LoginScreen.builder,
        homeScreen: HomeScreen.builder,
        rnwCourseDetailsscreen: RNWCourseDetailsScreen.builder,
        // rnwcoursescreen: RnwCourseScreen.builder,
        rnwsigningsheetscreen: RNWSigningSheetScreen.builder,
        rnwfeesdetailsscreen: RnwFeesDetailsScreen.builder,
        rnwcertificatescreen: RnwCertificateScreen.builder,
        rnwfeedbackscreen: RNWFeedbackScreen.builder,
        rnwhomescreen: RNWHomeScreen.builder,
        studentinfoscreen: StudentInfoScreen.builder,
        rnwattendancescreen: RNWAttendanceScreen.builder,
        rnwreportdetailsscreen: RnwReportDetailsScreen.builder,
        rnehelpandfeedback: RnwHelpandFeedbackScreen.builder,
        rnwprofilescreen: RNWProfileScreen.builder,
        rnwCertificateFormscreen: CirtificateFormScreen.builder,
        rnwtermsandconditionscreen: RnwTermAndConditionScreen.builder,
        rnwsettingsscreen: RnwsettingsScreen.builder,
        rnwcontactusscreen: RnWConcactUsScreen.builder,
        rnwviewcoursescreen: RnwViewCoursesScreen.builder,
        rnwnotificationslist: RNWNotificationsList.builder,
        rnwAnnouncementlist: RNWAnnouncementScreen.builder,
        rnwAnnouncementPreviewlist: RNWAnnouncementPreviewScreen.builder,
        rnwhelpcenter: RNWHelpCenterScreen.builder,
        rNWReportScreen: RNWReportScreen.builder,
        rNWfeedbackwebviewScreen: RnwFeedbackScreen.builder
      };
}
