part of 'course_bloc.dart';

class CourseState extends Equatable {
  const CourseState({this.courseModel, this.isLoading = false});
  final CourseDetailsModel? courseModel;
  final bool isLoading;
  @override
  List<Object?> get props => [courseModel, isLoading];
  CourseState copyWith({CourseDetailsModel? courseModel, bool? isLoading}) {
    return CourseState(
        courseModel: courseModel ?? this.courseModel,
        isLoading: isLoading ?? this.isLoading);
  }
}
