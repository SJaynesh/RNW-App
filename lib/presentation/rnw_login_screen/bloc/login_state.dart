part of 'login_bloc.dart';

class LoginState extends Equatable {
  LoginState({
    this.isLoading = false,
    this.phoneNumberController,
    this.phoneNumberModel,
    this.verifyOTPModel,
    this.otpController,
    this.reSendModel,
    this.mpinModel,
    this.isLoad = false,
    this.isMPIN = false,
    this.showOTP = false,
    this.showMPINOTP = false,
    this.isMPINLoading = false,
    this.isSubmitMPINLoading = false,
    this.isOtpButtonDisble = false,
    this.isButtonEnabled = false,
    this.showLoginButtons = true,
    this.isStartTime = false,
    this.isOTPSent = false,
  });

  TextEditingController? phoneNumberController;
  String? otpController;
  PhoneNumberModel? phoneNumberModel;
  VerifyOTPModel? verifyOTPModel;
  ReSendModel? reSendModel;
  bool isLoading;
  bool isLoad;
  bool isMPINLoading;
  bool isSubmitMPINLoading;
  bool isOtpButtonDisble;
  CheckMpinModel? mpinModel;
  bool isMPIN;
  bool showOTP;
  bool showMPINOTP;
  bool showLoginButtons;
  bool isButtonEnabled;
  bool isStartTime;
  bool isOTPSent;

  @override
  List<Object?> get props => [
        phoneNumberController,
        phoneNumberModel,
        verifyOTPModel,
        otpController,
        reSendModel,
        isLoading,
        mpinModel,
        isMPIN,
        showOTP,
        showMPINOTP,
        showLoginButtons,
        isLoad,
        isMPINLoading,
        isSubmitMPINLoading,
        isOtpButtonDisble,
        isButtonEnabled,
        isStartTime,
        isOTPSent
      ];

  LoginState? get formKey => null;
  LoginState copyWith(
      {TextEditingController? phoneNumberController,
      PhoneNumberModel? phoneNumberModel,
      String? otpController,
      VerifyOTPModel? verifyOTPModel,
      ReSendModel? reSendModel,
      bool? isLoading,
      CheckMpinModel? mpinModel,
      bool? isMPIN,
      bool? showOTP,
      bool? showMPINOTP,
      bool? showLoginButtons,
      bool? isLoad,
      bool? isMPINLoading,
      bool? isSubmitMPINLoading,
      bool? isOtpButtonDisble,
      bool? isButtonEnabled,
      bool? isStartTime,
      bool? isOTPSent}) {
    return LoginState(
        phoneNumberController:
            phoneNumberController ?? this.phoneNumberController,
        phoneNumberModel: phoneNumberModel ?? this.phoneNumberModel,
        verifyOTPModel: verifyOTPModel ?? this.verifyOTPModel,
        otpController: otpController ?? this.otpController,
        reSendModel: reSendModel ?? this.reSendModel,
        isLoading: isLoading ?? this.isLoading,
        mpinModel: mpinModel ?? this.mpinModel,
        isMPIN: isMPIN ?? this.isMPIN,
        showOTP: showOTP ?? this.showOTP,
        showMPINOTP: showMPINOTP ?? this.showMPINOTP,
        showLoginButtons: showLoginButtons ?? this.showLoginButtons,
        isLoad: isLoad ?? this.isLoad,
        isMPINLoading: isMPINLoading ?? this.isMPINLoading,
        isSubmitMPINLoading: isSubmitMPINLoading ?? this.isSubmitMPINLoading,
        isOtpButtonDisble: isOtpButtonDisble ?? this.isOtpButtonDisble,
        isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
        isStartTime: isStartTime ?? this.isStartTime,
        isOTPSent: isOTPSent ?? this.isOTPSent);
  }
}
