part of 'attendance_bloc.dart';

class AttendanceState extends Equatable {
  const AttendanceState(
      {this.studentAttendanceModel,
      this.isLoading = false,
      this.studentwiseAttendanceModel});
  final StudentAttendanceModel? studentAttendanceModel;
  final StudentwiseattendenceModel? studentwiseAttendanceModel;
  final bool isLoading;
  @override
  List<Object?> get props =>
      [studentAttendanceModel, isLoading, studentwiseAttendanceModel];
  AttendanceState copyWith(
      {StudentAttendanceModel? studentAttendanceModel,
      bool? isLoading,
      StudentwiseattendenceModel? studentwiseAttendanceModel}) {
    return AttendanceState(
        studentAttendanceModel:
            studentAttendanceModel ?? this.studentAttendanceModel,
        isLoading: isLoading ?? this.isLoading,
        studentwiseAttendanceModel:
            studentwiseAttendanceModel ?? this.studentwiseAttendanceModel);
  }
}
