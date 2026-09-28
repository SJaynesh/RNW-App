import 'package:rnw_institue/utils/app_export.dart';

class ApiEndPoints {
  // Base URL for the development environment
//  static String get baseURL => "http://103.154.233.221:3017/apt"; //dev

  // Uncomment the appropriate base URL for different environments:
  // static String get baseURL => "http://erp-student.devoteeinfotech.com/apt"; // stage
  // static String get baseURL => "https://erpapi.rnwmultimedia.com/aps"; //prod`
  static String get baseURL => "https://erpapi.rwskill.in/aps"; //prod`

  // Base URL for banner images hosted on S3
  static String get bannerbaseUrl {
    return 'https://rnw-public-pro.s3.amazonaws.com/';
  }

  // Endpoint for sending OTP to user
  static String get phoneNumber {
    return '/user/send-otp';
  }

  // Endpoint for checking if MPIN is set and sending OTP if necessary
  static String get checkUserMpinSetorNotAndSendOtp {
    return '/user/check-user-mpin-set-or-not-and-send-otp/?';
  }

  // Endpoint for registering MPIN or verifying OTP
  static String get registerMpinOrVerifyOtp {
    return '/user/register-mpin-or-verify-otp/?';
  }

  // Endpoint for verifying OTP
  static String get verifyotp {
    return '/user/verify-otp';
  }

  // Endpoint for fetching the student list
  static String get studentList {
    return '/students/student-list/v1';
  }

  // Endpoint for resending OTP
  static String get resendOTP {
    return '/user/resend-otp';
  }

  // Endpoint for fetching student details
  static String get studentDetails {
    return "/students";
  }

  // Alternative endpoint for fetching student details
  static String get studentDetails1 {
    return "/student-details/v1";
  }

  static String get addmissioinId {
    return "?admission_id=";
  }

  static String get mobileNumber {
    return "&mobile_number=";
  }

  // Endpoint for creating or updating student MPIN
  static String get sendMPIN {
    return '/user/create-or-upate-student-mpin';
  }

  // Endpoint for fetching student attendance details
  static String get studentAttendance {
    return "/attendance/";
  }

  // Endpoint for fetching student attendance part 1
  static String get studentattendencepart {
    return "/batch-student-shining-sheet-attendance";
  }

  // Endpoint for specifying the month in student attendance
  static String get studentattendencepart2 {
    return "?month=";
  }

  // Endpoint for specifying the year in student attendance
  static String get studentattendencepart3 {
    return "&year=";
  }

  // Endpoint for fetching course details
  static String get coursesDetails {
    return "/course/";
  }

  // Alternative endpoint for fetching course details
  static String get courses {
    return "/courses/";
  }

  static String get coursesDetails1 {
    return "/courses/v1";
  }

  // Endpoint for fetching banner images
  static String get banner {
    return "/banner/frot-banners";
  }

  // Endpoint for fetching shining sheet topics for batches
  static String get shiningSheet1 {
    return '/batch/';
  }

  // Endpoint for fetching shining sheet topics
  static String get shiningSheet2 {
    return '/shining-sheet-topic/v1';
  }

  // Endpoint for submitting feedback
  static String get submitFeedback {
    return "/feed-back/feed-back";
  }

  // Endpoint for fetching fee details
  static String get feeDetailAPI {
    return '/fees/';
  }

  // Alternative endpoint for fetching detailed fee information
  static String get feeDetailAPI1 {
    return '/fees-details/v1';
  }

  // URL for terms and conditions page
  static String get termsAndCondition {
    return 'https://www.rwskill.edu.in/terms-conditions-for-students/';
    // return 'https://www.rnwmultimedia.edu.in/student-terms-placement.php';
  }

  // URL for the contact us page
  static String get contactus {
    return 'https://www.rnwmultimedia.edu.in/contact-us';
  }

  // Endpoint for checking API version
  static String get version {
    return "/user/app-version?";
  }

  // Endpoint for fetching batch information
  static String get batches {
    return "/batch/";
  }

  // Endpoint for sending batch information
  static String get batchesend {
    return "/batches/";
  }

  // Endpoint for course feedback
  static String get coursefeedback {
    return "/feed-back/";
  }

  // Endpoint for course feedback
  static String get submissionlink {
    return "/student-submission-link";
  }

  // Base URL for student images hosted on S3
  static String get studentimagebaseurl {
    // https://rnw-public-pro.s3.amazonaws.com/AdmissionDocumentsAssets/d0d2d773-e9e9-4ef8-88b1-eb942d5878ff.jpg
    // return "https://rnw-public.s3.amazonaws.com/";
    return "https://rnw-public-pro.s3.amazonaws.com/";
  }

  // Endpoint for fetching User Notification
  static String get userNotificationList {
    return "/notifications/user-notifications-list";
  }

  // Endpoint for fetching User Notification
  static String get userNotificationMarkISReadList {
    return "/notifications/mark-is-read";
  }

  // Endpoint for fetching User Notification
  static String get createUserDeviceTokenURL {
    return "/user-device-token/create-user-device-token";
  }

  static String get helpcenter {
    return "/branches/help_center_api/";
  }

  static String get studentwiseattendencepart {
    return "/student-wise-attendance";
  }

  static String get studentwiseattendencepart1 {
    return "?date=";
  }

  static String studentPtmReportRecord(String id) {
    return '/students/$id/recurring-id';
  }

  static String studentPtmReport(String id) {
    return '/students/$id/student-ptm-report';
  }

  static String announcement(String id) {
    return '/announcement/$id/get-announcement';
  }

  static String updateAcknowledgeAnnouncement(String id) {
    return '/announcement/$id/update-acknowledge';
  }

  static String get annoucementId {
    return "/?announcement_id=";
  }

  static String markReadAnnouncement() {
    return '/announcement/mark-read';
  }

  // URL for the Feedback us page
  static String get feedback {
    return 'https://form.rwskill.edu.in/feedbacksurvey/';
    // return 'https://www.rnwmultimedia.edu.in/feedbacksurvey/';+
  }

  static String get studentatGrId {
    return "?grid=";
  }

  static String get studentatAdmissionId {
    return "&admission_id=";
  }
}
