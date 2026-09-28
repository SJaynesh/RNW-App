import 'package:rnw_institue/apis/repositorise/announcement_repository.dart';
import 'package:rnw_institue/presentation/rnw_announcement_screen/model/announcement_list_model.dart';
import 'package:rnw_institue/presentation/rnw_announcement_screen/model/mark_read_model.dart';
import 'package:rnw_institue/presentation/rnw_report_screen/model/student_ptm_report_record.dart';

import '../../../utils/app_export.dart';

part 'announcement_event.dart';
part 'announcement_state.dart';

class AnnouncementBloc extends Bloc<AnnouncementEvent, AnnouncementState> {
  final AnnouncementRepository announcementRepository;

  AnnouncementBloc(reportInitial, {required this.announcementRepository})
      : super(const AnnouncementState()) {
    on<FetchAnnouncementEvent>(_onFetchAnnouncement);
    on<UpdateAcknowledgeEvent>(_onUpdateAcknowledge);
    on<MarkReadEvent>(_onMarkRead);
  }

  Future<void> _onFetchAnnouncement(
    FetchAnnouncementEvent event,
    Emitter<AnnouncementState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      final report = await announcementRepository
          .getAnnouncementModuleList(event.recuringId);

      if (report.data != null) {
        emit(state.copyWith(
          isLoading: false,
          announcementModel: report,
          errorMessage: null,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorMessage:
              report.message ?? Lang.current.lbl_failed_to_load_announcement,
        ));
        Logger.lOG("Error: ${report.message}");
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
      Logger.lOG('Error fetching Announcement: $e');
    }
  }

  Future<void> _onUpdateAcknowledge(
    UpdateAcknowledgeEvent event,
    Emitter<AnnouncementState> emit,
  ) async {
    try {
      emit(state.copyWith(
        isUpdatingAcknowledge: true,
        updateAcknowledgeSuccess: false,
        updateAcknowledgeMessage: null,
        updatingAnnouncementId: event.announcementId,
      ));

      final response = await announcementRepository
          .updateAcknowledgeAnnouncement(event.announcementId);

      if (response.message != null && response.message!.isNotEmpty) {
        bool isSuccess = false;

        if (response.data != null) {
          if (response.data is Map &&
              (response.data as Map).containsKey('affected') &&
              (response.data as Map)['affected'] > 0) {
            isSuccess = true;
          }
        } else if (response.message!.toLowerCase().contains('success')) {
          isSuccess = true;
        }

        if (isSuccess) {
          emit(state.copyWith(
            isUpdatingAcknowledge: false,
            updateAcknowledgeSuccess: true,
            updateAcknowledgeMessage: response.message!,
            updatingAnnouncementId: event.announcementId,
          ));
          Logger.lOG("Success: ${response.message}");
        } else {
          emit(state.copyWith(
            isUpdatingAcknowledge: false,
            updateAcknowledgeSuccess: false,
            updateAcknowledgeMessage: response.message!,
            updatingAnnouncementId: event.announcementId,
          ));
          Logger.lOG("Error: ${response.message}");
        }
      } else {
        emit(state.copyWith(
          isUpdatingAcknowledge: false,
          updateAcknowledgeSuccess: false,
          updateAcknowledgeMessage:
              Lang.current.lbl_failed_to_update_acknowledgment,
          updatingAnnouncementId: event.announcementId,
        ));
        Logger.lOG("Error: No message in response");
      }
    } catch (e) {
      emit(state.copyWith(
        isUpdatingAcknowledge: false,
        updateAcknowledgeSuccess: false,
        updateAcknowledgeMessage: e.toString(),
        updatingAnnouncementId: event.announcementId,
      ));
      Logger.lOG('Error updating acknowledgment: $e');
    }
  }

  Future<void> _onMarkRead(
    MarkReadEvent event,
    Emitter<AnnouncementState> emit,
  ) async {
    try {
      emit(state.copyWith(
        isMarkingRead: true,
        markReadSuccess: false,
        markReadMessage: null,
      ));

      final response = await announcementRepository.markReadAnnouncements(
        announcementIds: event.announcementIds,
        admissionId: event.admissionId,
      );

      if (response.message != null &&
          response.data?.affected != null &&
          response.data!.affected! > 0) {
        final updatedModel =
            _updateAnnouncementsReadStatus(event.announcementIds);

        emit(state.copyWith(
          isMarkingRead: false,
          markReadSuccess: true,
          markReadMessage: response.message!,
          markReadResponse: response,
          announcementModel: updatedModel,
        ));

        Logger.lOG(
            "Success: Marked announcements as read - ${response.message}");
      } else {
        emit(state.copyWith(
          isMarkingRead: false,
          markReadSuccess: false,
          markReadMessage:
              Lang.current.lbl_failed_to_mark_announcements_as_read,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isMarkingRead: false,
        markReadSuccess: false,
        markReadMessage: e.toString(),
      ));
      Logger.lOG('Error marking announcements as read: $e');
    }
  }

  AnnouncementModel? _updateAnnouncementsReadStatus(List<int> announcementIds) {
    if (state.announcementModel?.data?.rows == null) {
      return state.announcementModel;
    }

    final updatedRows = state.announcementModel!.data!.rows!.map((row) {
      if (announcementIds.contains(row.announcementId)) {
        return AnnouncementRow(
          id: row.id,
          admissionId: row.admissionId,
          announcementId: row.announcementId,
          isRead: true,
          isReadDate: DateTime.now().millisecondsSinceEpoch.toString(),
          isAcknowledge: row.isAcknowledge,
          isAcknowledgeDate: row.isAcknowledgeDate,
          assignDate: row.assignDate,
          announcement: row.announcement,
        );
      }
      return row;
    }).toList();

    final updatedData = AnnouncementData(
      rows: updatedRows,
      count: state.announcementModel!.data!.count,
    );

    return AnnouncementModel(
      data: updatedData,
      message: state.announcementModel!.message,
    );
  }
}
