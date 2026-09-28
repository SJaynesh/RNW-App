part of 'announcement_bloc.dart';

class AnnouncementState extends Equatable {
  const AnnouncementState({
    this.isLoading = false,
    this.errorMessage,
    this.filteredData,
    this.announcementModel,
    this.isUpdatingAcknowledge = false,
    this.updateAcknowledgeSuccess = false,
    this.updateAcknowledgeMessage,
    this.acknowledgeUpdateError,
    this.updatingAnnouncementId,
    this.isMarkingRead = false,
    this.markReadSuccess = false,
    this.markReadMessage,
    this.markReadResponse,
  });

  final bool isLoading;
  final String? errorMessage;
  final List<RecordData>? filteredData;
  final AnnouncementModel? announcementModel;

  // Fields for update acknowledge
  final bool isUpdatingAcknowledge;
  final bool updateAcknowledgeSuccess;
  final String? updateAcknowledgeMessage;
  final String? acknowledgeUpdateError;
  final String? updatingAnnouncementId;

  // New fields for mark-read
  final bool isMarkingRead;
  final bool markReadSuccess;
  final String? markReadMessage;
  final MarkReadModel? markReadResponse;

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        filteredData,
        announcementModel,
        isUpdatingAcknowledge,
        updateAcknowledgeSuccess,
        updateAcknowledgeMessage,
        acknowledgeUpdateError,
        updatingAnnouncementId,
        isMarkingRead,
        markReadSuccess,
        markReadMessage,
        markReadResponse,
      ];

  AnnouncementState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<RecordData>? filteredData,
    AnnouncementModel? announcementModel,
    bool? isUpdatingAcknowledge,
    bool? updateAcknowledgeSuccess,
    String? updateAcknowledgeMessage,
    String? acknowledgeUpdateError,
    String? updatingAnnouncementId,
    bool? isMarkingRead,
    bool? markReadSuccess,
    String? markReadMessage,
    MarkReadModel? markReadResponse,
  }) {
    return AnnouncementState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      filteredData: filteredData ?? this.filteredData,
      announcementModel: announcementModel ?? this.announcementModel,
      isUpdatingAcknowledge:
          isUpdatingAcknowledge ?? this.isUpdatingAcknowledge,
      updateAcknowledgeSuccess:
          updateAcknowledgeSuccess ?? this.updateAcknowledgeSuccess,
      acknowledgeUpdateError:
          acknowledgeUpdateError ?? this.acknowledgeUpdateError,
      updatingAnnouncementId:
          updatingAnnouncementId ?? this.updatingAnnouncementId,
      updateAcknowledgeMessage:
          updateAcknowledgeMessage ?? this.updateAcknowledgeMessage,
      isMarkingRead: isMarkingRead ?? this.isMarkingRead,
      markReadSuccess: markReadSuccess ?? this.markReadSuccess,
      markReadMessage: markReadMessage ?? this.markReadMessage,
      markReadResponse: markReadResponse ?? this.markReadResponse,
    );
  }
}
