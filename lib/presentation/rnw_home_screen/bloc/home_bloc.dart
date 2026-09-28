import 'dart:developer';
import '../../../utils/app_export.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeModuleRepository homeModuleRepository;
  HomeBloc(super.initialState, this.homeModuleRepository) {
    on<GetStudentListAPIEvent>(_ongetStudentListAPICall);
  }

  _ongetStudentListAPICall(
      GetStudentListAPIEvent event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      StudentListModel studentListModel =
          await homeModuleRepository.getStudentListAPI();
      if (studentListModel.data != null) {
        emit(state.copyWith(
            isLoading: false, studentListModel: studentListModel));
      } else {
        emit(state.copyWith(isLoading: false));
        log("Error ${studentListModel.message}");
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      Logger.lOG('====$e');
    }
  }
}
