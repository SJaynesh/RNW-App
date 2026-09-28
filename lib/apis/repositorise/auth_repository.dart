import 'dart:developer';
import 'dart:io';
import 'package:rnw_institue/presentation/rnw_login_screen/model/mpin_model.dart';
import 'package:rnw_institue/presentation/rnw_login_screen/model/phone_number_model.dart';
import 'package:rnw_institue/presentation/rnw_login_screen/model/resend_otp_model.dart';
import 'package:rnw_institue/presentation/rnw_login_screen/model/verify_otp_model.dart';
import 'package:rnw_institue/presentation/rnw_login_screen/model/verify_mpin_model.dart';
import 'package:rnw_institue/presentation/rnw_settings_screen/model/rnw_version.dart';
import 'package:rnw_institue/utils/app_export.dart';

class AuthRepository {
  final ApiClient apiClient;

  // Constructor to initialize the ApiClient
  AuthRepository({required this.apiClient});

  // Method to request an OTP and check if MPIN is set
  Future<PhoneNumberModel> phoneNumberApi(
      {required String phoneNumber, required String authType}) async {
    try {
      final Map<String, String> paramsData = {
        'mobile_no': phoneNumber,
        'auth_type': authType
      };
      // Convert parameters to query string
      String queryString = Uri(queryParameters: paramsData).query;

      // Make GET request to API
      var response = await apiClient.request(
          RequestType.GET,
          ApiEndPoints.baseURL +
              ApiEndPoints.checkUserMpinSetorNotAndSendOtp +
              queryString);

      // Parse and return the response
      return PhoneNumberModel.fromJson(response);
    } catch (e) {
      // Log error and rethrow it
      Logger.lOG(e.toString());
      rethrow;
    }
  }

  // Method to verify OTP for login
  Future<VerifyOTPModel> verifyOTPApi(
      {required String phoneOTP,
      required String mobile,
      required String devicetoken}) async {
    try {
      final Map<String, dynamic> postData = {
        'otp': phoneOTP,
        'mobile_no': mobile,
        'device_token': devicetoken,
        'type': Platform.isAndroid ? 'ANDROID' : 'IOS',
        'auth': 'OTP'
      };

      // Make POST request to API
      var response = await apiClient.request(
        RequestType.POST,
        ApiEndPoints.baseURL + ApiEndPoints.verifyotp,
        data: postData,
      );

      // Parse and return the response
      return VerifyOTPModel.fromJson(response);
    } catch (e) {
      // Log error and rethrow it
      Logger.lOG(e.toString());
      rethrow;
    }
  }

  // Method to verify MPIN for login
  Future<VerifyOTPModel> verifyMPINApi(
      {required String phoneOTP,
      required String mobile,
      required String devicetoken}) async {
    try {
      final Map<String, dynamic> postData = {
        'otp': phoneOTP,
        'mobile_no': mobile,
        'device_token': devicetoken,
        'type': Platform.isAndroid ? 'ANDROID' : 'IOS',
        'auth': 'MPIN'
      };

      // Make POST request to API
      var response = await apiClient.request(
        RequestType.POST,
        ApiEndPoints.baseURL + ApiEndPoints.verifyotp,
        data: postData,
      );

      // Parse and return the response
      return VerifyOTPModel.fromJson(response);
    } catch (e) {
      // Log error and rethrow it
      Logger.lOG(e.toString());
      rethrow;
    }
  }

  // Method to resend OTP
  Future<ReSendModel> resendOTPApi({required String mobile}) async {
    try {
      final Map<String, dynamic> postData = {'mobile_no': mobile};

      // Make POST request to API
      var response = await apiClient.request(
        RequestType.POST,
        ApiEndPoints.baseURL + ApiEndPoints.resendOTP,
        data: postData,
      );

      // Parse and return the response
      return ReSendModel.fromJson(response);
    } catch (e) {
      // Log error and rethrow it
      Logger.lOG(e.toString());
      rethrow;
    }
  }

  // Method to check MPIN and send OTP if necessary
  Future<CheckMpinModel> mPINApi(
      {required String phoneNumber, required String authType}) async {
    try {
      final Map<String, String> paramsData = {
        'mobile_no': phoneNumber,
        'auth_type': authType
      };
      // Convert parameters to query string
      String queryString = Uri(queryParameters: paramsData).query;

      // Make GET request to API
      var response = await apiClient.request(
          RequestType.GET,
          ApiEndPoints.baseURL +
              ApiEndPoints.checkUserMpinSetorNotAndSendOtp +
              queryString);

      // Parse and return the response
      return CheckMpinModel.fromJson(response);
    } catch (e) {
      // Log error and rethrow it
      Logger.lOG(e.toString());
      rethrow;
    }
  }

  // Method to register MPIN or verify OTP
  Future<RegisterMPINVerifyOTPModel> registerMPINVerifyOTP(
      {required String phoneNumber,
      required String otp,
      required String mpin}) async {
    try {
      final Map<String, String> paramsData = {
        'mobile_no': phoneNumber,
        'otp': otp,
        'mpin': mpin
      };
      // Convert parameters to query string
      String queryString = Uri(queryParameters: paramsData).query;

      // Make POST request to API
      var response = await apiClient.request(
          RequestType.POST,
          ApiEndPoints.baseURL +
              ApiEndPoints.registerMpinOrVerifyOtp +
              queryString);

      // Log the full URL for debugging
      log(ApiEndPoints.baseURL +
          ApiEndPoints.registerMpinOrVerifyOtp +
          queryString);

      // Parse and return the response
      return RegisterMPINVerifyOTPModel.fromJson(response);
    } catch (e) {
      // Log error and rethrow it
      Logger.lOG(e.toString());
      rethrow;
    }
  }

  // Method to get API version
  Future<VersionModel> getVersionAPI() async {
    try {
      final Map<String, String> paramsData = {
        'type': Platform.isAndroid ? 'ANDROID' : 'IOS'
      };
      // Convert parameters to query string
      String queryString = Uri(queryParameters: paramsData).query;
      // Make GET request to API
      var response = await apiClient.request(RequestType.GET,
          ApiEndPoints.baseURL + ApiEndPoints.version + queryString,
          withoutMessage: true);

      // Parse and return the response
      return VersionModel.fromJson(response);
    } catch (e) {
      // Log error and rethrow it
      Logger.lOG(e.toString());
      rethrow;
    }
  }
}
