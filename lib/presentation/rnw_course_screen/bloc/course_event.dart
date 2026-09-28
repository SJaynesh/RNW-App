part of 'course_bloc.dart';

class CourseEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CourseitialEvent extends CourseEvent {
  @override
  List<Object> get props => [];
}

class GetCourseAPIEvent extends CourseEvent {
  GetCourseAPIEvent({required this.addmissionID});
  final String addmissionID;
  @override
  List<Object> get props => [addmissionID];
}
