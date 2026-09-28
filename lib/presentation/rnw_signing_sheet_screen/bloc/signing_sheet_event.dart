part of 'signing_sheet_bloc.dart';

abstract class SigningSheetEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SginingSheetitialEvent extends SigningSheetEvent {
  @override
  List<Object> get props => [];
}

class BatchDetailsAPIEvent extends SigningSheetEvent {
  BatchDetailsAPIEvent({required this.batchId});
  final String batchId;
  @override
  List<Object> get props => [batchId];
}

class BatchAPIEvent extends SigningSheetEvent {
  BatchAPIEvent({required this.batchId});
  final String batchId;
  @override
  List<Object> get props => [batchId];
}

class CourseFeedBackAPIEvent extends SigningSheetEvent {
  CourseFeedBackAPIEvent(
      {required this.courseId, required this.feedback, required this.batchId});
  final String courseId;
  final String feedback;
  final String batchId;

  @override
  List<Object> get props => [courseId, feedback, batchId];
}

class CoursesubmissionLinkAPIEvent extends SigningSheetEvent {
  CoursesubmissionLinkAPIEvent(
      {required this.submissionId,
      required this.submissionLink,
      required this.batchId,
      required this.admissionId});
  final String submissionId;
  final String submissionLink;
  final String batchId;
  final int admissionId;

  @override
  List<Object> get props => [submissionId, submissionLink, batchId];
}
