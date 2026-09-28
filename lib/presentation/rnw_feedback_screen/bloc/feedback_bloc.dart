import 'package:rnw_institue/presentation/rnw_feedback_screen/model/feedback_model.dart';
import 'package:rnw_institue/utils/app_export.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final HomeModuleRepository homeModuleRepository;

  FeedbackBloc(super.initialState, this.homeModuleRepository) {
    on<FeedbackEvent>((_onInitialize));
    on<SubmitFeedbackEvent>((_onFeddbackApiCall));
  }
  _onInitialize(FeedbackEvent event, Emitter<FeedbackState> emit) async {
    emit(state.copyWith());
  }

  _onFeddbackApiCall(
      SubmitFeedbackEvent event, Emitter<FeedbackState> emit) async {
    try {
      FeedbackModel feedbackModel = await homeModuleRepository.feedbackApi(
          subject: event.subject,
          type: event.type,
          remarks: event.remarks,
          feedbackType: event.feedbackType.toUpperCase());
      NavigatorService.goBack();
      emit(state.copyWith(feedbackModel: feedbackModel, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
