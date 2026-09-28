import 'dart:developer';
import 'package:rnw_institue/presentation/rnw_login_screen/model/mpin_model.dart';
import 'package:rnw_institue/presentation/rnw_login_screen/model/phone_number_model.dart';
import 'package:rnw_institue/presentation/rnw_login_screen/model/resend_otp_model.dart';
import 'package:rnw_institue/presentation/rnw_login_screen/model/verify_otp_model.dart';
import 'package:rnw_institue/presentation/rnw_login_screen/model/verify_mpin_model.dart';
import 'package:rnw_institue/utils/app_export.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(super.initialState, this.authRepository) {
    on<LoginEvent>((_onInitialize));
    on<PhoneNumberApiEvent>((_phoneNumberApiCall));
    on<CheckMPINApiEvent>((_checkMPINApiCall));
    on<VerifyOTPApiEvent>((_verifyOTPApiCall));
    on<VerifyMPINApiEvent>((_verifyMpinApiCall));
    on<ResendOTPEvent>((_resndOTPApiCall));
    on<RegisterMPINVerifyOTPApiEvent>((_registerMPINVerifyOTPApiCall));
  }

  _onInitialize(LoginEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith());
  }

  _phoneNumberApiCall(
      PhoneNumberApiEvent event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(isLoading: true, isStartTime: false));

      PhoneNumberModel phoneNumberModel = await authRepository.phoneNumberApi(
          phoneNumber: event.phoneNumber, authType: "OTP");
      if (phoneNumberModel.data != null) {
        PrefObj.preferences
            ?.put(PrefKeys.PHONENUMBER, event.phoneNumber.trim());
        emit(state.copyWith(
            isLoading: false,
            isStartTime: true,
            phoneNumberController: TextEditingController(),
            showOTP: true,
            isOTPSent: true));
      } else {
        emit(state.copyWith(
          showOTP: false,
          isLoading: true,
          isStartTime: false,
        ));
      }
    } catch (e) {
      emit(
          state.copyWith(isLoading: false, showOTP: false, isStartTime: false));
      log('error: $e');
    }
  }

  _checkMPINApiCall(CheckMPINApiEvent event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(isMPINLoading: true));

      CheckMpinModel checkMpinModel = await authRepository.mPINApi(
          phoneNumber: event.phoneNumber, authType: "MPIN");
      log(checkMpinModel.data!.message ?? '');
      if (checkMpinModel.data?.isMpin != null) {
        PrefObj.preferences
            ?.put(PrefKeys.PHONENUMBER, event.phoneNumber.trim());
        emit(state.copyWith(
            isMPIN: checkMpinModel.data!.isMpin,
            isMPINLoading: false,
            showMPINOTP: (checkMpinModel.data!.isMpin ?? true) ? false : true));
      } else {
        emit(state.copyWith(
            showLoginButtons: false,
            isMPIN: false,
            showOTP: true,
            showMPINOTP: false,
            isMPINLoading: false));
      }
    } catch (e) {
      log('MIPN failed: $e');
      emit(state.copyWith(isMPINLoading: false));
    }
  }

  _verifyOTPApiCall(VerifyOTPApiEvent event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(isLoad: true));
      log('Verify OTP API call initiated with: ${event.phoneNumber}, ${event.otp}');

      VerifyOTPModel verifyOTPModel = await authRepository.verifyOTPApi(
          phoneOTP: event.otp,
          mobile: event.phoneNumber,
          devicetoken: event.devicetoken);
      if (verifyOTPModel.data != null) {
        PrefObj.preferences
            ?.put(PrefKeys.PHONENUMBER, event.phoneNumber.trim());
        emit(state.copyWith(isLoad: false, isButtonEnabled: true));
        PrefObj.preferences
            ?.put(PrefKeys.DEVICETOKEN, verifyOTPModel.data!.token.toString());
        // .then(await _createUserDeviceTokenApiCall(
        //     CreateUserDeviceTokenApiEvent(
        //         phoneNumber: event.phoneNumber,
        //         oneSignalID:
        //             PrefObj.preferences?.get(PrefKeys.SUBSCRIPTIONID) ??
        //                 ''),
        // emit));

        if (state.isButtonEnabled) {
          NavigatorService.pushNamed(AppRoutes.homeScreen);
        }
      } else {
        emit(state.copyWith(isLoad: false, isButtonEnabled: false));
      }
    } catch (e) {
      emit(state.copyWith(isLoad: false, isButtonEnabled: false));
      log('Verify OTP API call success, state updated with model: ${state.verifyOTPModel}');
    }
  }

  _verifyMpinApiCall(VerifyMPINApiEvent event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(isSubmitMPINLoading: true));
      log('Verify OTP API call initiated with: ${event.phoneNumber}, ${event.mpin}');

      VerifyOTPModel verifyOTPModel = await authRepository.verifyMPINApi(
          phoneOTP: event.mpin,
          mobile: event.phoneNumber,
          devicetoken: event.devicetoken);

      if (verifyOTPModel.data != null) {
        PrefObj.preferences
            ?.put(PrefKeys.PHONENUMBER, event.phoneNumber.trim());
        emit(state.copyWith(isSubmitMPINLoading: false, isButtonEnabled: true));

        PrefObj.preferences
            ?.put(PrefKeys.DEVICETOKEN, verifyOTPModel.data!.token.toString());
        // .then(await _createUserDeviceTokenApiCall(
        //     CreateUserDeviceTokenApiEvent(
        //         phoneNumber: event.phoneNumber,
        //         oneSignalID:
        //             PrefObj.preferences?.get(PrefKeys.SUBSCRIPTIONID) ??
        //                 ''),
        //     emit));

        log(PrefObj.preferences?.get(PrefKeys.DEVICETOKEN).toString() ?? "");

        if (state.isButtonEnabled) {
          NavigatorService.pushNamed(AppRoutes.homeScreen);
        }
      } else {
        emit(
            state.copyWith(isSubmitMPINLoading: false, isButtonEnabled: false));
      }
    } catch (e) {
      emit(state.copyWith(isSubmitMPINLoading: false, isButtonEnabled: false));
      log('Verify OTP API call success, state updated with model: ${state.verifyOTPModel}');
    }
  }

  _resndOTPApiCall(ResendOTPEvent event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith());

      ReSendModel? reSendModel =
          await authRepository.resendOTPApi(mobile: event.phoneNumber);
    } catch (e) {
      emit(state.copyWith(reSendModel: state.reSendModel));
    }
  }

  _registerMPINVerifyOTPApiCall(
      RegisterMPINVerifyOTPApiEvent event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith());
      RegisterMPINVerifyOTPModel registerMPINVerifyOTP =
          await authRepository.registerMPINVerifyOTP(
              phoneNumber: event.phoneNumber.trim(),
              otp: event.otp.trim(),
              mpin: event.mpin.trim());

      if (registerMPINVerifyOTP.data!.message != null) {
        PrefObj.preferences
            ?.put(PrefKeys.PHONENUMBER, event.phoneNumber.trim());
        emit(state.copyWith(isSubmitMPINLoading: false, isButtonEnabled: true));

        if (state.isButtonEnabled) {
          NavigatorService.pushNamed(AppRoutes.loginScreen);
          showToast(
              "MPIN set successfully. Please log in again using your new MPIN.");
        }
      } else {
        emit(
            state.copyWith(isSubmitMPINLoading: false, isButtonEnabled: false));
      }
    } catch (e) {
      emit(state.copyWith(isSubmitMPINLoading: false, isButtonEnabled: false));
    }
  }
}
