import 'package:rnw_institue/utils/app_export.dart';

// ApiClient class for handling HTTP requests using Dio
// Implements various HTTP methods and handles errors and responses
// Utilizes Dio for making HTTP requests and PrettyDioLogger for logging

// ignore_for_file: constant_identifier_names

enum RequestType { GET, POST, PUT, DELETE, PATCH, MULTIPART_POST }

class ApiClient {
  final Dio _dio;

  ApiClient()
      : _dio = Dio(BaseOptions(
          headers: _buildHeaders(),
        )) {
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
  }

  // Method to build headers for HTTP requests
  static Map<String, String> _buildHeaders() {
    final headers = <String, String>{'Content-Type': 'application/json'};
    String? authToken = PrefObj.preferences?.get(PrefKeys.DEVICETOKEN) ?? '';
    if (authToken!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $authToken';
    }
    return headers;
  }

  Future<Map<String, dynamic>> request(
    RequestType requestType,
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? multipartData,
    bool withoutMessage = false,
  }) async {
    Response response;

    try {
      switch (requestType) {
        case RequestType.GET:
          response = await _dio.get(path);
          break;
        case RequestType.POST:
          response = await _dio.post(path, data: data);
          break;
        case RequestType.PUT:
          response = await _dio.put(path, data: data);
          break;
        case RequestType.DELETE:
          response = await _dio.delete(path);
          break;
        case RequestType.PATCH:
          response = await _dio.patch(path, data: data);
          break;
        case RequestType.MULTIPART_POST:
          FormData formData = FormData();
          if (multipartData != null && multipartData.isNotEmpty) {
            bool isFirstEntryProcessed = false;

            for (var entry in multipartData.entries) {
              if (entry.value is List && entry.value.isNotEmpty) {
                if (!isFirstEntryProcessed) {
                  for (var filepath in entry.value) {
                    formData.files.add(
                      MapEntry(
                        entry.key,
                        await MultipartFile.fromFile(filepath),
                      ),
                    );
                  }
                  isFirstEntryProcessed = true;
                } else {
                  formData.fields.add(MapEntry(entry.key, entry.value.toString()));
                }
              } else {
                formData.fields.add(MapEntry(entry.key, entry.value.toString()));
              }
            }
          }
          response = await _dio.post(
            path,
            data: formData,
          );
          break;
        default:
          throw ArgumentError('Invalid request type');
      }

      return withoutMessage ? _handlewithoutMessageResponse(response) : _handleResponse(response);
    } catch (error) {
      if (error is DioException) {
        return withoutMessage ? _handleErrorWithoutMessage(error) : _handleError(error);
      } else {
        rethrow;
      }
    }
  }

  // Method to handle successful HTTP responses
  Map<String, dynamic> _handleResponse(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      final message = _extractMessage(response.data);
      showToast(message);
      return response.data;
    } else {
      throw _handleNonSuccessStatus(response);
    }
  }

  Map<String, dynamic> _handlewithoutMessageResponse(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    } else {
      throw _handleNonSuccessStatusWithoutMessage(response);
    }
  }

  // Method to handle non-successful HTTP responses
  Map<String, dynamic> _handleNonSuccessStatus(Response response) {
    if (response.statusCode == 400) {
      final message = _extractMessage(response.data);
      showToast(message);
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    } else if (response.statusCode == 401) {
      final message = _extractMessage(response.data);
      showToast(message);
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.unknown,
      );
    } else {
      final message = _extractMessage(response.data);
      showToast(message);

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }
  }

  //_handle Non Success Status Without Message
  Map<String, dynamic> _handleNonSuccessStatusWithoutMessage(Response response) {
    if (response.statusCode == 400) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    } else if (response.statusCode == 401) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.unknown,
      );
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }
  }

  // Method to extract message from response data
  String _extractMessage(Map<String, dynamic> data) {
    return data['message'] ?? data['data']?['message'] ?? 'Something went wrong, please try again';
  }

  // Method to handle Dio errors
  Map<String, dynamic> _handleError(DioException error) {
    if (error.response != null) {
      return _handleNonSuccessStatus(error.response!);
    } else {
      final message = _extractMessage(error.response?.data);
      showToast(message);
      throw DioException(
        requestOptions: error.requestOptions,
        error: error.error,
        type: DioExceptionType.unknown,
      );
    }
  }

  Map<String, dynamic> _handleErrorWithoutMessage(DioException error) {
    if (error.response != null) {
      return _handleNonSuccessStatusWithoutMessage(error.response!);
    } else {
      throw DioException(
        requestOptions: error.requestOptions,
        error: error.error,
        type: DioExceptionType.unknown,
      );
    }
  }
}
