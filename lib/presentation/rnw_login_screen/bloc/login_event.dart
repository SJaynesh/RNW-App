part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {}

class LoginInitialEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class PhoneNumberApiEvent extends LoginEvent {
  final String phoneNumber;

  PhoneNumberApiEvent({
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [phoneNumber];
}

class CheckMPINApiEvent extends LoginEvent {
  final String phoneNumber;

  CheckMPINApiEvent({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

class RegisterMPINVerifyOTPApiEvent extends LoginEvent {
  final String phoneNumber;
  final String otp;
  final String mpin;

  RegisterMPINVerifyOTPApiEvent(
      {required this.phoneNumber, required this.otp, required this.mpin});

  @override
  List<Object?> get props => [phoneNumber, otp, mpin];
}

class VerifyOTPApiEvent extends LoginEvent {
  final String phoneNumber;
  final String otp;
  final String devicetoken;

  VerifyOTPApiEvent({
    required this.phoneNumber,
    required this.otp,
    required this.devicetoken,
  });

  @override
  List<Object?> get props => [phoneNumber, otp, devicetoken];
}

class VerifyMPINApiEvent extends LoginEvent {
  final String phoneNumber;
  final String mpin;
  final String devicetoken;

  VerifyMPINApiEvent(
      {required this.phoneNumber,
      required this.mpin,
      required this.devicetoken});

  @override
  List<Object?> get props => [phoneNumber, mpin, devicetoken];
}

class ResendOTPEvent extends LoginEvent {
  final String phoneNumber;

  ResendOTPEvent({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

class MpinEvent extends LoginEvent {
  final String mpin;

  MpinEvent({
    required this.mpin,
  });

  @override
  List<Object?> get props => [mpin];
}
