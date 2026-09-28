import 'package:rnw_institue/presentation/rnw_signing_sheet_screen/model/batches_model.dart';
import 'package:rnw_institue/presentation/rnw_signing_sheet_screen/model/course_feedback_model.dart';
import 'package:rnw_institue/presentation/rnw_signing_sheet_screen/model/singing_model.dart';
import 'package:rnw_institue/presentation/rnw_signing_sheet_screen/model/submission_link_model.dart';
import 'package:rnw_institue/utils/app_export.dart';

part 'signing_sheet_event.dart';
part 'signing_sheet_state.dart';

class SigningSheetBloc extends Bloc<SigningSheetEvent, SigningSheetState> {
  final HomeModuleRepository homeModuleRepository;
  SigningSheetBloc(super.initialState, this.homeModuleRepository) {
    on<SigningSheetEvent>(_onInitialize);
    on<BatchDetailsAPIEvent>(_onBatchDetailsAPIEvent);
    on<BatchAPIEvent>(_batchdetailApiEvent);
    on<CourseFeedBackAPIEvent>(_oncourseFeedbackApiEvent);
    on<CoursesubmissionLinkAPIEvent>(_oncourseSubmissionApiEvent);
  }

  _onInitialize(
      SigningSheetEvent event, Emitter<SigningSheetState> emit) async {
    emit(state.copyWith());
  }

  _onBatchDetailsAPIEvent(
    BatchDetailsAPIEvent event,
    Emitter<SigningSheetState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      BatchDetailsModel batchdetailsModel =
          await homeModuleRepository.getSingingSheetAPI(batchId: event.batchId);
      if (batchdetailsModel.data != null) {
        emit(state.copyWith(
            isLoading: false, batchDetailsModel: batchdetailsModel));

        Logger.lOG(batchdetailsModel.message);
      } else {
        emit(state.copyWith(isLoading: false));
        Logger.lOG("Error ${batchdetailsModel.message}");
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      Logger.lOG(e);
    }
  }

  _batchdetailApiEvent(
      BatchAPIEvent event, Emitter<SigningSheetState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      BatchesModel batchesModel = await homeModuleRepository.getbatchDetailsApi(
          admissionId: event.batchId);
      if (batchesModel.data != null) {
        emit(state.copyWith(isLoading: false, batchesModel: batchesModel));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      Logger.lOG(e);
    }
  }

  _oncourseFeedbackApiEvent(
      CourseFeedBackAPIEvent event, Emitter<SigningSheetState> emit) async {
    try {
      CourseFeedbackModel courseFeedbackModel =
          await homeModuleRepository.coursefeedbackApi(
              courseId: event.courseId, feedback: event.feedback);
      if (courseFeedbackModel.data != null) {
        emit(state.copyWith(courseFeedbackModel: courseFeedbackModel));

        await _onBatchDetailsAPIEvent(
            BatchDetailsAPIEvent(batchId: event.batchId), emit);
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      Logger.lOG(e);
    }
  }

  _oncourseSubmissionApiEvent(CoursesubmissionLinkAPIEvent event,
      Emitter<SigningSheetState> emit) async {
    try {
      SubmissionLinkModel courseSubmissionModel =
          await homeModuleRepository.courseSubmissionApi(
              submissionId: event.submissionId,
              submissionLink: event.submissionLink,
              admissionId: event.admissionId);
      if (courseSubmissionModel.data != null) {
        await _onBatchDetailsAPIEvent(
            BatchDetailsAPIEvent(batchId: event.batchId), emit);
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      Logger.lOG(e);
    }
  }
}
