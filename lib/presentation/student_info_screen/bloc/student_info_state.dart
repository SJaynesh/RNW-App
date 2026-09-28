part of 'student_info_bloc.dart';

class StudentInfoState extends Equatable {
  const StudentInfoState(
      {this.studentdetailsModel,
      this.helpcenterModel,
      this.isLoading = false,
      this.isLoad = false,
      this.courseDateController});
  final StudentDetailsModel? studentdetailsModel;
  final HelpcenterModel? helpcenterModel;
  final bool isLoading;
  final bool isLoad;
  final TextEditingController? courseDateController;

  @override
  List<Object?> get props => [
        studentdetailsModel,
        isLoading,
        isLoad,
        courseDateController,
        helpcenterModel
      ];

  StudentInfoState copyWith(
      {StudentDetailsModel? studentdetailsModel,
      HelpcenterModel? helpcenterModel,
      bool? isLoading,
      bool? isLoad,
      TextEditingController? courseDateController}) {
    return StudentInfoState(
        studentdetailsModel: studentdetailsModel ?? this.studentdetailsModel,
        isLoading: isLoading ?? this.isLoading,
        isLoad: isLoad ?? this.isLoad,
        courseDateController: courseDateController ?? this.courseDateController,
        helpcenterModel: helpcenterModel ?? this.helpcenterModel);
  }
}
