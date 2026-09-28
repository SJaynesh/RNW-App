import 'package:rnw_institue/apis/api_client/api_client.dart';
import 'package:rnw_institue/apis/api_endpoints/api_end_points.dart';
import 'package:rnw_institue/presentation/rnw_announcement_screen/model/announcement_list_model.dart';
import 'package:rnw_institue/presentation/rnw_announcement_screen/model/mark_read_model.dart';
import 'package:rnw_institue/presentation/rnw_announcement_screen/model/update_acknowledge_model.dart';
import 'package:rnw_institue/utils/logger.dart';

class AnnouncementRepository {
  final ApiClient apiClient;

  AnnouncementRepository({required this.apiClient});

  Future<AnnouncementModel> getAnnouncementModuleList(String id) async {
    try {
      var response = await apiClient.request(
        RequestType.GET,
        ApiEndPoints.baseURL + ApiEndPoints.announcement(id),
        withoutMessage: true,
      );
      return AnnouncementModel.fromJson(response);
    } catch (e) {
      Logger.lOG(e.toString());
      rethrow;
    }
  }

  Future<UpdateAcknowledgeModel> updateAcknowledgeAnnouncement(
      String announcementId) async {
    try {
      var response = await apiClient.request(
        RequestType.PATCH,
        ApiEndPoints.baseURL +
            ApiEndPoints.updateAcknowledgeAnnouncement(announcementId) +
            ApiEndPoints.annoucementId +
            (announcementId),
        withoutMessage: true,
      );
      return UpdateAcknowledgeModel.fromJson(response);
    } catch (e) {
      Logger.lOG(e.toString());
      rethrow;
    }
  }

  Future<MarkReadModel> markReadAnnouncements({
    required List<int> announcementIds,
    required int admissionId,
  }) async {
    try {
      var response = await apiClient.request(
        RequestType.PUT,
        ApiEndPoints.baseURL + ApiEndPoints.markReadAnnouncement(),
        data: {
          'announcement_id': announcementIds,
          'admission_id': admissionId,
        },
        withoutMessage: true,
      );
      return MarkReadModel.fromJson(response);
    } catch (e) {
      Logger.lOG(e.toString());
      rethrow;
    }
  }
}
