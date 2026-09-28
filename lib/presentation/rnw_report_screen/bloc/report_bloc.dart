import 'package:rnw_institue/apis/repositorise/ptm_report_repository.dart';
import 'package:rnw_institue/presentation/rnw_report_screen/model/student_ptm_report_model.dart';
import 'package:rnw_institue/presentation/rnw_report_screen/model/student_ptm_report_record.dart';

import '../../../utils/app_export.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final ReportRepository reportRepository;

  ReportBloc(reportInitial, {required this.reportRepository}) : super(const ReportState()) {
    on<FetchStudentReportEvent>(_onFetchStudentReport);
    on<SearchStudentReportEvent>(_searchStudentReportEvent);
    on<FetchStudentReportRecordEvent>(_onfetchStudentReportRecordEvent);
  }

  Future<void> _onFetchStudentReport(
    FetchStudentReportEvent event,
    Emitter<ReportState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      final report = await reportRepository.getStudentReport(event.recuringId);

      if (report.data != null) {
        emit(state.copyWith(
          isLoading: false,
          ptmReportModel: report,
          errorMessage: null,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: report.message ?? 'Failed to load report',
        ));
        Logger.lOG("Error: ${report.message}");
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
      Logger.lOG('Error fetching report: $e');
    }
  }

  FutureOr<void> _searchStudentReportEvent(SearchStudentReportEvent event, Emitter<ReportState> emit) {
    if (state.ptmReportRecordModel == null || state.ptmReportRecordModel!.data == null) {
      return null;
    }

    final filteredList = state.ptmReportRecordModel!.data!.where((student) {
      return student.studentName?.toLowerCase().contains(event.query.toLowerCase()) ?? false;
    }).toList();

    emit(state.copyWith(filteredData: filteredList));
  }

  Future<void> _onfetchStudentReportRecordEvent(FetchStudentReportRecordEvent event, Emitter<ReportState> emit) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      final reportRecord = await reportRepository.getStudentReportRecord(event.admissionId);

      if (reportRecord.data != null) {
        emit(state.copyWith(
          isLoading: false,
          ptmReportRecordModel: reportRecord,
          errorMessage: null,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: reportRecord.message ?? 'Failed to load report',
        ));
        Logger.lOG("Error: ${reportRecord.message}");
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
      Logger.lOG('Error fetching report record: $e');
    }
  }
}
