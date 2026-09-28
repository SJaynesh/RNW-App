import 'package:rnw_institue/apis/api_client/api_client.dart';
import 'package:rnw_institue/apis/api_endpoints/api_end_points.dart';
import 'package:rnw_institue/presentation/student_info_screen/model/course_details_model.dart';
import 'package:rnw_institue/utils/logger.dart';

class CourseRepository {
  final ApiClient apiClient;

  // Constructor to initialize the ApiClient
  CourseRepository({required this.apiClient});

  // Method to fetch course details using admission ID
  Future<CourseDetailsModel> getCourseAPI({required String addmissionID}) async {
    try {
      // Construct the endpoint URL with admission ID

      // Make GET request to the constructed URL
      var response = await apiClient.request(RequestType.GET, ApiEndPoints.baseURL + ApiEndPoints.coursesDetails + addmissionID + ApiEndPoints.coursesDetails1, withoutMessage: true);
      return CourseDetailsModel.fromJson(response);
    } catch (e) {
      // Log the error and rethrow it for further handling
      Logger.lOG(e.toString());
      rethrow;
    }
  }
}
