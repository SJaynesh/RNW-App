part of 'announcement_bloc.dart';

abstract class AnnouncementEvent extends Equatable {
  const AnnouncementEvent();

  @override
  List<Object> get props => [];
}

class FetchAnnouncementEvent extends AnnouncementEvent {
  final String recuringId;

  const FetchAnnouncementEvent({required this.recuringId});

  @override
  List<Object> get props => [recuringId];
}


class UpdateAcknowledgeEvent extends AnnouncementEvent {
  final String announcementId;

  const UpdateAcknowledgeEvent({required this.announcementId});

  @override
  List<Object> get props => [announcementId];
}

class MarkReadEvent extends AnnouncementEvent {
  final List<int> announcementIds;
  final int admissionId;

  const MarkReadEvent({
    required this.announcementIds,
    required this.admissionId,
  });

  @override
  List<Object> get props => [announcementIds, admissionId];
}