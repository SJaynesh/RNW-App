import 'package:rnw_institue/apis/api_client/api_client.dart';
import 'package:rnw_institue/apis/api_endpoints/api_end_points.dart';
import 'package:rnw_institue/presentation/rnw_report_screen/model/student_ptm_report_model.dart';
import 'package:rnw_institue/presentation/rnw_report_screen/model/student_ptm_report_record.dart';
import 'package:rnw_institue/utils/logger.dart';

class ReportRepository {
  final ApiClient apiClient;

  ReportRepository({required this.apiClient});

  Future<StudentPtmReportModel> getStudentReport(String id) async {
    try {
      var response = await apiClient.request(
        RequestType.GET,
        ApiEndPoints.baseURL + ApiEndPoints.studentPtmReport(id),
        withoutMessage: true,
      );
      return StudentPtmReportModel.fromJson(response);
    } catch (e) {
      Logger.lOG(e.toString());
      rethrow;
    }
  }

  Future<StudentPtmReportRecordModel> getStudentReportRecord(String id) async {
    try {
      var response = await apiClient.request(
        RequestType.GET,
        ApiEndPoints.baseURL + ApiEndPoints.studentPtmReportRecord(id),
        withoutMessage: true,
      );
      return StudentPtmReportRecordModel.fromJson(response);
    } catch (e) {
      Logger.lOG(e.toString());
      rethrow;
    }
  }
}
