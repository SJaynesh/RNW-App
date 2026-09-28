import 'dart:developer';

import 'package:rnw_institue/apis/repositorise/notification_repository.dart';
import 'package:rnw_institue/presentation/rnw_bottombar_screen/model/create_user_device_token_model.dart';
import 'package:rnw_institue/utils/app_export.dart';

part 'rnw_bottombar_event.dart';
part 'rnw_bottombar_state.dart';

enum BottomBarState { initial, report, fillApp, userProfile }

class RnwBottombarBloc extends Bloc<RnwBottombarEvent, RnwBottombarState> {
  final NotificationModuleRepository notificationModuleRepository;

  RnwBottombarBloc(super.initialState, this.notificationModuleRepository) {
    on<MainHomeInitialEvent>(_onInitialize);
    on<CategoryEvent>(_onCategoryEvent);
    on<CommunityEvent>(_oncommunityEvent);
    on<UserProfilesEvent>(_onuserProfileEvent);
    on<BackToInitial>(_onBackToInitialEvent);
    on<CreateUserDeviceTokenApiEvent>(_createUserDeviceTokenApiCall);
  }
  _onInitialize(
    MainHomeInitialEvent event,
    Emitter<RnwBottombarState> emit,
  ) async {
    emit(state.copyWith(bottomBarState: BottomBarState.initial));
  }

  _onCategoryEvent(
    CategoryEvent event,
    Emitter<RnwBottombarState> emit,
  ) async {
    emit(state.copyWith(bottomBarState: BottomBarState.report));
  }

  _oncommunityEvent(
    CommunityEvent event,
    Emitter<RnwBottombarState> emit,
  ) async {
    emit(state.copyWith(bottomBarState: BottomBarState.fillApp));
  }

  _onuserProfileEvent(
    UserProfilesEvent event,
    Emitter<RnwBottombarState> emit,
  ) async {
    emit(state.copyWith(bottomBarState: BottomBarState.userProfile));
  }

  _onBackToInitialEvent(
    BackToInitial event,
    Emitter<RnwBottombarState> emit,
  ) async {
    emit(state.copyWith(bottomBarState: BottomBarState.initial));
  }

  _createUserDeviceTokenApiCall(CreateUserDeviceTokenApiEvent event,
      Emitter<RnwBottombarState> emit) async {
    try {
      CreateUserDeviceTokenModel createUserDeviceTokenModel =
          await notificationModuleRepository.createUserDeviceTokenApi(
              phoneNumber: event.phoneNumber, oneSignalID: event.oneSignalID);

      if (createUserDeviceTokenModel.data != null) {}
    } catch (e) {
      log('Create User Device Token API call success, state updated with model');
    }
  }
}
