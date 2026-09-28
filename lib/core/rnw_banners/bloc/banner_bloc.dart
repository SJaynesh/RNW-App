import 'package:rnw_institue/utils/app_export.dart';
import 'package:rnw_institue/core/rnw_banners/model/banner_model.dart';
part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final BannerRepository bannerRepository;

  // Constructor takes initialState and BannerRepository, 
  // listens for GetBannerAPIEvent to trigger API call.
  BannerBloc(super.initialState, this.bannerRepository) {
    on<GetBannerAPIEvent>(_onGetBannerAPICall);
  }

  // Function to handle the GetBannerAPIEvent
  _onGetBannerAPICall(
      GetBannerAPIEvent event, Emitter<BannerState> emit) async {
    try {
      // Emit loading state
      emit(state.copyWith(isLoading: true));
      
      // Fetch banners from API
      BannersModel bannersModel = await bannerRepository.getBannerAPI();

      // Check if data is available and emit success state
      if (bannersModel.data != null) {
        emit(state.copyWith(isLoading: false, bannersModel: bannersModel));
      } else {
        // Emit failure state if no data and log error message
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      // Emit error state if exception occurs and log error
      emit(state.copyWith(isLoading: false));
      
    }
  }
}
