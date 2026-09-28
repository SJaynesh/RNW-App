part of 'report_bloc.dart';

class ReportState extends Equatable {
  const ReportState({
    this.ptmReportModel,
    this.isLoading = false,
    this.errorMessage,
    this.filteredData,
    this.ptmReportRecordModel,
  });

  final StudentPtmReportModel? ptmReportModel;
  final bool isLoading;
  final String? errorMessage;
  final List<RecordData>? filteredData;
  final StudentPtmReportRecordModel? ptmReportRecordModel;

  @override
  List<Object?> get props => [ptmReportModel, isLoading, errorMessage, filteredData, ptmReportRecordModel];

  ReportState copyWith(
      {StudentPtmReportModel? ptmReportModel,
      bool? isLoading,
      String? errorMessage,
      List<RecordData>? filteredData,
      StudentPtmReportRecordModel? ptmReportRecordModel}) {
    return ReportState(
      ptmReportModel: ptmReportModel ?? this.ptmReportModel,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      filteredData: filteredData ?? this.filteredData,
      ptmReportRecordModel: ptmReportRecordModel ?? this.ptmReportRecordModel,
    );
  }
}
