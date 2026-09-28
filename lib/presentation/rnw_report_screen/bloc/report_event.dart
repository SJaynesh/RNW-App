part of 'report_bloc.dart';

abstract class ReportEvent extends Equatable {
  const ReportEvent();

  @override
  List<Object> get props => [];
}

class ReportilsitialEvent extends ReportEvent {}

class FetchStudentReportEvent extends ReportEvent {
  final String recuringId;

  const FetchStudentReportEvent(this.recuringId);

  @override
  List<Object> get props => [recuringId];
}

class SearchStudentReportEvent extends ReportEvent {
  final String query;
  const SearchStudentReportEvent(this.query);
}

class FetchStudentReportRecordEvent extends ReportEvent {
  final String admissionId;
  const FetchStudentReportRecordEvent(this.admissionId);
  @override
  List<Object> get props => [admissionId];
}
