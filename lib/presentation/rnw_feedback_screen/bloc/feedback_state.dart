import 'package:rnw_institue/presentation/rnw_feedback_screen/model/feedback_model.dart';
import 'package:rnw_institue/utils/app_export.dart';

class FeedbackState extends Equatable {
  const FeedbackState({this.feedbackModel, this.isLoading = false});

  final FeedbackModel? feedbackModel;
  final bool isLoading;
  @override
  List<Object?> get props => [feedbackModel, isLoading];

  FeedbackState copyWith({FeedbackModel? feedbackModel, bool? isLoading}) {
    return FeedbackState(
        feedbackModel: feedbackModel ?? this.feedbackModel,
        isLoading: isLoading ?? this.isLoading);
  }
}

class FeedbackInitial extends FeedbackState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class FeedbackInitials extends FeedbackState {}

class FeedbackLoading extends FeedbackState {}

class FeedbackSuccess extends FeedbackState {}

class FeedbackFailure extends FeedbackState {
  final String error;

  const FeedbackFailure(this.error);
}
