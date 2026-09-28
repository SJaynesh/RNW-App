import 'package:rnw_institue/presentation/student_info_screen/model/course_details_model.dart';
import 'package:rnw_institue/utils/app_export.dart';
part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final CourseRepository courseRepository;
  CourseBloc(super.initialState, this.courseRepository) {
    on<CourseitialEvent>(_onInitialize);
    on<GetCourseAPIEvent>(_onGetCourseAPICall);
  }
  _onInitialize(CourseitialEvent event, Emitter<CourseState> emit) async {
    emit(state.copyWith());
  }

  _onGetCourseAPICall(GetCourseAPIEvent event, Emitter<CourseState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      CourseDetailsModel courseModel = await courseRepository.getCourseAPI(addmissionID: event.addmissionID);
      if (courseModel.data != null) {
        emit(state.copyWith(courseModel: courseModel, isLoading: false));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      Logger.lOG('Error *****$e');
    }
  }
}
