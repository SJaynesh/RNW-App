import 'package:rnw_institue/utils/app_export.dart';

class FeedbackEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FeedbackInitialEvent extends FeedbackEvent {
  @override
  List<Object?> get props => [];
}

class SubmitFeedbackEvent extends FeedbackEvent {
  final String subject;
  final String type;
  final String remarks;
  final String feedbackType;

  SubmitFeedbackEvent({
    required this.subject,
    required this.type,
    required this.remarks,
    required this.feedbackType,
  });
  @override
  List<Object?> get props => [subject, type, remarks, feedbackType];
}
