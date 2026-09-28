import 'package:rnw_institue/apis/api_client/api_client.dart';
import 'package:rnw_institue/apis/api_endpoints/api_end_points.dart';
import 'package:rnw_institue/utils/logger.dart';
import 'package:rnw_institue/core/rnw_banners/model/banner_model.dart';

class BannerRepository {
  final ApiClient apiClient;

  // Constructor to initialize the ApiClient
  BannerRepository({required this.apiClient});

  // Method to fetch banner data from the API
  Future<BannersModel> getBannerAPI() async {
    try {
      // Make GET request to the API endpoint for banners
      var response = await apiClient.request(
        RequestType.GET,
        ApiEndPoints.baseURL + ApiEndPoints.banner,
        withoutMessage: true
      );

      // Parse and return the response as BannersModel
      return BannersModel.fromJson(response);
    } catch (e) {
      // Log the error and rethrow it for further handling
      Logger.lOG(e.toString());
      rethrow;
    }
  }
}
