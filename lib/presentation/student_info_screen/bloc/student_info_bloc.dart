import 'package:rnw_institue/presentation/rnw_help_center_screen/model/help_center_model.dart';
import 'package:rnw_institue/presentation/student_info_screen/model/student_details_model.dart';
import 'package:rnw_institue/utils/app_export.dart';
part 'student_info_event.dart';
part 'student_info_state.dart';

class StudentInfoBloc extends Bloc<StudentInfoEvent, StudentInfoState> {
  final HomeModuleRepository homeModuleRepository;
  StudentInfoBloc(super.initialState, this.homeModuleRepository) {
    on<StudentInfoilsitialEvent>(_onInitialize);
    on<GetStudentDetailsAPIEvent>(_ongetStudentDetailsAPICall);
    on<GetStudentDetailsFatched>(_ongetStudentDetailsFatch);
    on<HelpcenterAPIEvent>(_ongethelpcenterDataApi);
  }
  _onInitialize(
    StudentInfoilsitialEvent event,
    Emitter<StudentInfoState> emit,
  ) async {
    emit(state.copyWith(studentdetailsModel: StudentDetailsModel()));
  }

  _ongetStudentDetailsFatch(
      GetStudentDetailsFatched event, Emitter<StudentInfoState> emit) async {
    emit(state.copyWith(isLoad: true));
  }

  _ongetStudentDetailsAPICall(
      GetStudentDetailsAPIEvent event, Emitter<StudentInfoState> emit) async {
    try {
      String? loginMobileNo = PrefObj.preferences?.get(PrefKeys.PHONENUMBER);

      emit(state.copyWith(isLoading: true));
      StudentDetailsModel studentDetailsModel =
          await homeModuleRepository.getStudentDetailsAPI(
              addmissionID: event.admissionId,
              mobilrNumber: loginMobileNo.toString());
      if (studentDetailsModel.data != null) {
        emit(state.copyWith(
          studentdetailsModel: studentDetailsModel,
        ));
        emit(state.copyWith(isLoading: false));
      } else {
        emit(state.copyWith(isLoading: false));
        Logger.lOG("Error ${studentDetailsModel.message}");
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      Logger.lOG('Error $e');
    }
  }

  Future<void> _ongethelpcenterDataApi(
      HelpcenterAPIEvent event, Emitter<StudentInfoState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      HelpcenterModel helpcenterModel =
          await homeModuleRepository.helpcenterApi(branchid: event.branchid);
      if (helpcenterModel.data != null) {
        emit(state.copyWith(
          helpcenterModel: helpcenterModel,
        ));
        emit(state.copyWith(isLoading: false));
      } else {
        emit(state.copyWith(isLoading: false));
        Logger.lOG("Error ${helpcenterModel.message}");
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      Logger.lOG('Error $e');
    }
  }
}
