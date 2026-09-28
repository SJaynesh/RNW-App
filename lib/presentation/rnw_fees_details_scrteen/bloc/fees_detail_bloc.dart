import 'dart:developer';
import 'package:rnw_institue/presentation/rnw_fees_details_scrteen/model/fee_details_model.dart';
import 'package:rnw_institue/utils/app_export.dart';
part 'fees_detail_event.dart';
part 'fees_detail_state.dart';

class FeesDetailBloc extends Bloc<FeesDetailEvent, FeesDetailState> {
  final HomeModuleRepository homeModuleRepository;

  FeesDetailBloc(super.initialState, this.homeModuleRepository) {
    on<FeesdetailsApi>((_onFeeDetailsAPICall));
  }

  _onFeeDetailsAPICall(
      FeesdetailsApi event, Emitter<FeesDetailState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      FeeDetailsModel feeDetailsModel = await homeModuleRepository
          .feeDetailsApi(admissionId: event.admissionId);
      if (feeDetailsModel.data != null) {
        emit(
            state.copyWith(feeDetailsModel: feeDetailsModel, isLoading: false));
      } else {
        emit(state.copyWith(isLoading: false));
        log("Error ${feeDetailsModel.message}");
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      Logger.lOG('====$e');
    }
  }
}
