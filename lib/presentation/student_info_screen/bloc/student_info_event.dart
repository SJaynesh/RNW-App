part of 'student_info_bloc.dart';

abstract class StudentInfoEvent extends Equatable {
  const StudentInfoEvent();

  @override
  List<Object> get props => [];
}

class StudentInfoilsitialEvent extends StudentInfoEvent {
  @override
  List<Object> get props => [];
}

class CertificateilsitialEvent extends StudentInfoEvent {
  @override
  List<Object> get props => [];
}

class GetStudentDetailsAPIEvent extends StudentInfoEvent {
  const GetStudentDetailsAPIEvent({required this.admissionId});
  final String admissionId;
  @override
  List<Object> get props => [admissionId];
}

class GetStudentDetailsFatched extends StudentInfoEvent {
  @override
  List<Object> get props => [];
}

class HelpcenterAPIEvent extends StudentInfoEvent {
  const HelpcenterAPIEvent({required this.branchid});
  final String branchid;
  @override
  List<Object> get props => [branchid];
}
