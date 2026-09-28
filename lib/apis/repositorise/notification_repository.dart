
import 'package:rnw_institue/presentation/rnw_bottombar_screen/model/create_user_device_token_model.dart';
import 'package:rnw_institue/presentation/rnw_notification_screen/model/notification_list_model.dart';
import 'package:rnw_institue/utils/app_export.dart';

class NotificationModuleRepository {
  final ApiClient apiClient;

  // Constructor to initialize the ApiClient
  NotificationModuleRepository({required this.apiClient});

  // Method to fetch the list of Notification
  Future<NotificationModel> getNotificationListAPI() async {
    try {
      var response = await apiClient.request(RequestType.GET,
          ApiEndPoints.baseURL + ApiEndPoints.userNotificationList,
          withoutMessage: true);
      // Parse and return the response as NotificationModel
      return NotificationModel.fromJson(response);
    } catch (e) {
      // Log the error and rethrow it for further handling
      Logger.lOG(e.toString());
      rethrow;
    }
  }

  // Method to fetch Notification for mark is read
  Future<NotificationModel> getMarkISReadAPI(
      {required int notificationID}) async {
    try {
      final Map<String, dynamic> postData = {
        "notification_ids": [notificationID]
      };
      var response = await apiClient.request(RequestType.POST,
          ApiEndPoints.baseURL + ApiEndPoints.userNotificationMarkISReadList,
          data: postData, withoutMessage: true);
      // Parse and return the response as NotificationModel
      return NotificationModel.fromJson(response);
    } catch (e) {
      // Log the error and rethrow it for further handling
      Logger.lOG(e.toString());
      rethrow;
    }
  }

  // Method to verify MPIN for Create User Device Token
  Future<CreateUserDeviceTokenModel> createUserDeviceTokenApi(
      {required String phoneNumber, required String oneSignalID}) async {
    try {
      final Map<String, dynamic> postData = {
        'mobile_no': phoneNumber,
        //TODO: YASH //Change Type
        'type': 'MOBILE',
        'token': oneSignalID,
      };

      // Make POST request to API
      var response = await apiClient.request(RequestType.POST,
          ApiEndPoints.baseURL + ApiEndPoints.createUserDeviceTokenURL,
          data: postData, withoutMessage: true);

      // Parse and return the response
      return CreateUserDeviceTokenModel.fromJson(response);
    } catch (e) {
      // Log error and rethrow it
      Logger.lOG(e.toString());
      rethrow;
    }
  }
}
