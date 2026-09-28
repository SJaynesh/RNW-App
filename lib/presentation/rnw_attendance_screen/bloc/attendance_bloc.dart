import 'package:rnw_institue/presentation/rnw_attendance_screen/model/student_attendance_model.dart';
import 'package:rnw_institue/presentation/rnw_attendance_screen/model/student_wise_attendence_model.dart';
import 'package:rnw_institue/utils/app_export.dart';
part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final HomeModuleRepository homeModuleRepository;

  AttendanceBloc(super.initialState, this.homeModuleRepository) {
    on<AttendanceilsitialEvent>(_onInitial);
    on<GetStudentAttendanceAPIEvent>(_ongetStudentAttendanceAPICall);
    on<StudentwiseAttendanceAPIEvent>(_ongetStudentwiseendanceAPICall);
  }

  _onInitial(AttendanceilsitialEvent event, Emitter<AttendanceState> emit) {
    emit(state.copyWith());
  }

  _ongetStudentAttendanceAPICall(
      GetStudentAttendanceAPIEvent event, Emitter<AttendanceState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      StudentAttendanceModel studentAttendanceModel =
          await homeModuleRepository.getStudentAttendanceAPI(
              addmissionId: event.admissionId,
              month: event.month,
              year: event.year);
      if (studentAttendanceModel.data != null) {
        emit(state.copyWith(
            isLoading: false, studentAttendanceModel: studentAttendanceModel));
      } else {
        emit(state.copyWith(isLoading: false));
        Logger.lOG("Error ${studentAttendanceModel.message}");
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      Logger.lOG('$e');
    }
  }

  Future<void> _ongetStudentwiseendanceAPICall(
      StudentwiseAttendanceAPIEvent event,
      Emitter<AttendanceState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      StudentwiseattendenceModel studentwiseAttendanceModel =
          await homeModuleRepository.getStudentwiseAttendanceAPI(
              addmissionId: event.admissionId,
              month: event.month,
              year: event.year);
      if (studentwiseAttendanceModel.data != null) {
        emit(state.copyWith(
            isLoading: false,
            studentwiseAttendanceModel: studentwiseAttendanceModel));
      } else {
        emit(state.copyWith(isLoading: false));
        Logger.lOG("Error ${studentwiseAttendanceModel.message}");
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      Logger.lOG('$e');
    }
  }
}
