part of 'attendance_bloc.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object> get props => [];
}

class AttendanceilsitialEvent extends AttendanceEvent {
  @override
  List<Object> get props => [];
}

class GetStudentAttendanceAPIEvent extends AttendanceEvent {
  final String admissionId;
  final String? month;
  final String? year;

  const GetStudentAttendanceAPIEvent({
    required this.admissionId,
    this.month,
    this.year,
  });

  @override
  List<Object> get props => [];
}

class StudentwiseAttendanceAPIEvent extends AttendanceEvent {
  final String admissionId;
  final String? month;
  final String? year;

  const StudentwiseAttendanceAPIEvent({
    required this.admissionId,
    this.month,
    this.year,
  });

  @override
  List<Object> get props => [];
}
