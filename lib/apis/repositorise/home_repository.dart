import 'package:rnw_institue/presentation/rnw_attendance_screen/model/student_attendance_model.dart';
import 'package:rnw_institue/presentation/rnw_attendance_screen/model/student_wise_attendence_model.dart';
import 'package:rnw_institue/presentation/rnw_feedback_screen/model/feedback_model.dart';
import 'package:rnw_institue/presentation/rnw_fees_details_scrteen/model/fee_details_model.dart';
import 'package:rnw_institue/presentation/rnw_help_center_screen/model/help_center_model.dart';
import 'package:rnw_institue/presentation/rnw_signing_sheet_screen/model/batches_model.dart';
import 'package:rnw_institue/presentation/rnw_signing_sheet_screen/model/course_feedback_model.dart';
import 'package:rnw_institue/presentation/rnw_signing_sheet_screen/model/singing_model.dart';
import 'package:rnw_institue/presentation/rnw_signing_sheet_screen/model/submission_link_model.dart';
import 'package:rnw_institue/presentation/student_info_screen/model/student_details_model.dart';
import 'package:rnw_institue/utils/app_export.dart';

class HomeModuleRepository {
  final ApiClient apiClient;

  // Constructor to initialize the ApiClient
  HomeModuleRepository({required this.apiClient});

  // Method to fetch the list of students
  Future<StudentListModel> getStudentListAPI() async {
    try {
      var response = await apiClient.request(
          RequestType.GET, ApiEndPoints.baseURL + ApiEndPoints.studentList,
          withoutMessage: true);
      // Parse and return the response as StudentListModel
      return StudentListModel.fromJson(response);
    } catch (e) {
      // Log the error and rethrow it for further handling
      Logger.lOG(e.toString());
      rethrow;
    }
  }

  // Method to fetch singing sheet details for a specific batch
  Future<BatchDetailsModel> getSingingSheetAPI(
      {required String batchId}) async {
    try {
      var response = await apiClient.request(
          RequestType.GET,
          ApiEndPoints.baseURL +
              ApiEndPoints.shiningSheet1 +
              batchId +
              ApiEndPoints.shiningSheet2,
          withoutMessage: true);
      // Parse and return the response as BatchDetailsModel
      return BatchDetailsModel.fromJson(response);
    } catch (e) {
      // Log the error and rethrow it for further handling
      Logger.lOG(e.toString());
      rethrow;
    }
  }

  // Method to fetch student attendance for a specific admission ID
  Future<StudentAttendanceModel> getStudentAttendanceAPI(
      {required String addmissionId, String? month, String? year}) async {
    try {
      // Construct the URL with optional month and year parameters
      var url = ApiEndPoints.baseURL +
          ApiEndPoints.studentAttendance +
          addmissionId +
          ApiEndPoints.studentattendencepart +
          ApiEndPoints.studentattendencepart2 +
          (month ?? '') +
          ApiEndPoints.studentattendencepart3 +
          (year ?? '');

      var response =
          await apiClient.request(RequestType.GET, url, withoutMessage: true);
      // Parse and return the response as StudentAttendanceModel
      return StudentAttendanceModel.fromJson(response);
    } catch (e) {
      // Log the error and rethrow it for further handling
      Logger.lOG(e.toString());
      rethrow;
    }
  }

  // Method to fetch student details for a specific admission ID
  Future<StudentDetailsModel> getStudentDetailsAPI(
      {required String addmissionID, required String mobilrNumber}) async {
    try {
      var response = await apiClient.request(
          RequestType.GET,
          ApiEndPoints.baseURL +
              ApiEndPoints.studentDetails +
              ApiEndPoints.studentDetails1 +
              ApiEndPoints.addmissioinId +
              addmissionID +
              ApiEndPoints.mobileNumber +
              mobilrNumber,
          // ApiEndPoints.baseURL + ApiEndPoints.studentDetails + addmissionID + ApiEndPoints.studentDetails1,
          withoutMessage: true);
      // Parse and return the response as StudentDetailsModel
      return StudentDetailsModel.fromJson(response);
    } catch (e) {
      // Log the error and rethrow it for further handling
      Logger.lOG(e.toString());
      rethrow;
    }
  }

  // Method to submit feedback
  Future<FeedbackModel> feedbackApi(
      {required String subject,
      required String type,
      required String remarks,
      required String feedbackType}) async {
    try {
      final Map<String, dynamic> postData = {
        "subject": subject,
        "type": type,
        "remarks": remarks,
        "feedback_type": feedbackType
      };

      var response = await apiClient.request(
        RequestType.POST,
        ApiEndPoints.baseURL + ApiEndPoints.submitFeedback,
        data: postData,
      );
      // Parse and return the response as FeedbackModel
      return FeedbackModel.fromJson(response);
    } catch (e) {
      // Log the error and rethrow it for further handling
      Logger.lOG(e.toString());
      rethrow;
    }
  }

  // Method to fetch fee details for a specific admission ID
  Future<FeeDetailsModel> feeDetailsApi({required String admissionId}) async {
    try {
      var response = await apiClient.request(
          RequestType.GET,
          ApiEndPoints.baseURL +
              ApiEndPoints.feeDetailAPI +
              admissionId +
              ApiEndPoints.feeDetailAPI1,
          withoutMessage: true);
      // Parse and return the response as FeeDetailsModel
      return FeeDetailsModel.fromJson(response);
    } catch (e) {
      // Log the error and rethrow it for further handling
      Logger.lOG(e.toString());
      rethrow;
    }
  }

  // Method to fetch batch details for a specific admission ID
  Future<BatchesModel> getbatchDetailsApi({required String admissionId}) async {
    try {
      var response = await apiClient.request(
          RequestType.GET,
          ApiEndPoints.baseURL +
              ApiEndPoints.batches +
              admissionId +
              ApiEndPoints.batchesend,
          withoutMessage: true);
      // Parse and return the response as BatchesModel
      return BatchesModel.fromJson(response);
    } catch (e) {
      // Log the error and rethrow it for further handling
      Logger.lOG(e.toString());
      rethrow;
    }
  }

  // Method to submit course feedback
  Future<CourseFeedbackModel> coursefeedbackApi(
      {required String courseId, required String feedback}) async {
    try {
      final Map<String, dynamic> postData = {
        "feedback": feedback,
      };

      var response = await apiClient.request(
          RequestType.PATCH,
          ApiEndPoints.baseURL +
              ApiEndPoints.coursefeedback +
              courseId +
              ApiEndPoints.coursefeedback,
          data: postData);
      // Parse and return the response as CourseFeedbackModel
      return CourseFeedbackModel.fromJson(response);
    } catch (e) {
      // Log the error and rethrow it for further handling
      Logger.lOG(e.toString());
      rethrow;
    }
  }

  Future<SubmissionLinkModel> courseSubmissionApi(
      {required String submissionId,
      required String submissionLink,
      required int admissionId}) async {
    try {
      final Map<String, dynamic> postData = {
        "submission_link": submissionLink,
        "admission_id": admissionId,
      };

      var response = await apiClient.request(
          RequestType.PATCH,
          ApiEndPoints.baseURL +
              ApiEndPoints.batches +
              submissionId +
              ApiEndPoints.submissionlink,
          data: postData);
      // Parse and return the response as CourseFeedbackModel
      return SubmissionLinkModel.fromJson(response);
    } catch (e) {
      // Log the error and rethrow it for further handling
      Logger.lOG(e.toString());
      rethrow;
    }
  }

  Future<HelpcenterModel> helpcenterApi({required String branchid}) async {
    try {
      final Map<String, dynamic> postData = {
        "branch_id ": branchid,
      };

      var response = await apiClient.request(RequestType.GET,
          ApiEndPoints.baseURL + ApiEndPoints.helpcenter + branchid,
          data: postData, withoutMessage: true);
      return HelpcenterModel.fromJson(response);
    } catch (e) {
      Logger.lOG(e.toString());
      rethrow;
    }
  }

  Future<StudentwiseattendenceModel> getStudentwiseAttendanceAPI(
      {required String addmissionId, String? month, String? year}) async {
    try {
      var formattedMonth = month?.padLeft(2, '0') ?? '01';
      var url =
          '${ApiEndPoints.baseURL}${ApiEndPoints.studentAttendance}$addmissionId${ApiEndPoints.studentwiseattendencepart}${ApiEndPoints.studentwiseattendencepart1}${year ?? ''}-$formattedMonth';

      var response =
          await apiClient.request(RequestType.GET, url, withoutMessage: true);
      return StudentwiseattendenceModel.fromJson(response);
    } catch (e) {
      Logger.lOG(e.toString());
      rethrow;
    }
  }
}
