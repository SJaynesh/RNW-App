part of 'signing_sheet_bloc.dart';

class SigningSheetState extends Equatable {
  const SigningSheetState(
      {this.batchDetailsModel,
      this.isLoading = false,
      this.batchesModel,
      this.courseFeedbackModel});
  final BatchDetailsModel? batchDetailsModel;
  final bool isLoading;
  final BatchesModel? batchesModel;
  final CourseFeedbackModel? courseFeedbackModel;

  @override
  List<Object?> get props =>
      [batchDetailsModel, isLoading, batchesModel, courseFeedbackModel];
  SigningSheetState copyWith(
      {BatchDetailsModel? batchDetailsModel,
      bool? isLoading,
      CourseFeedbackModel? courseFeedbackModel,
      BatchesModel? batchesModel}) {
    return SigningSheetState(
        batchDetailsModel: batchDetailsModel ?? this.batchDetailsModel,
        isLoading: isLoading ?? this.isLoading,
        courseFeedbackModel: courseFeedbackModel ?? this.courseFeedbackModel,
        batchesModel: batchesModel ?? this.batchesModel);
  }
}
