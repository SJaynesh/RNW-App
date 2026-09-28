import 'package:rnw_institue/utils/app_export.dart';

part 'rnw_spash_screen_event.dart';
part 'rnw_spash_screen_state.dart';

class RnwSpalshScreenBloc
    extends Bloc<RnwSpalshScreenEvent, RnwSpalshScreenState> {
  RnwSpalshScreenBloc(super.initialState) {
    on<RnwSpalshScreenEvent>((_onInitialize));
  }

  _onInitialize(
    RnwSpalshScreenEvent event,
    Emitter<RnwSpalshScreenState> emit,
  ) async {
    Future.delayed(const Duration(seconds: 3), () {
      if (PrefObj.preferences?.get(PrefKeys.DEVICETOKEN) == null) {
        NavigatorService.pushReplacement(AppRoutes.loginScreen);
      } else {
        NavigatorService.pushReplacement(AppRoutes.homeScreen);
      }
    });
  }
}
