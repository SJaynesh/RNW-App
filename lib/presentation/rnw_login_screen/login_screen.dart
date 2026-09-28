import 'dart:io';

import 'package:rnw_institue/utils/app_export.dart';
import 'package:rnw_institue/widget/rnw_textfield_widget/rnw_custom_otp_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(LoginState(), AuthRepository(apiClient: ApiClient()))..add(LoginInitialEvent()),
      child: const LoginScreen(),
    );
  }

  @override
  State<LoginScreen> createState() => _RNWLoginScreenState();
}

class _RNWLoginScreenState extends State<LoginScreen> {
  bool otpSent = false;
  bool mpinSent = false;
  bool isStop = true;
  final interval = const Duration(seconds: 1);
  final int timerMaxSeconds = 30;
  int currentSeconds = 0;
  Timer? countdownTimer;

  String get timerText => '00:${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  void startTimer([int? milliseconds]) {
    setState(() {
      currentSeconds = 0;
      isStop = false;
    });
    var duration = interval;
    countdownTimer = Timer.periodic(duration, (timer) {
      setState(() {
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) {
          isStop = true;
          timer.cancel();
        }
      });
    });
  }

  final defaultPinTheme = PinTheme(
      width: 50.w,
      height: 50.h,
      textStyle: TextStyle(fontSize: 25.sp, color: AppColors.blackcolor),
      decoration: BoxDecoration(color: AppColors.btnColor, borderRadius: BorderRadius.circular(4.r), border: Border.all(color: AppColors.whitecolor)));

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController pinController = TextEditingController();
  TextEditingController mpinController = TextEditingController();
  TextEditingController confiMpinController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  late LoginState state;
  DateTime? _lastPressedAt;
  @override
  void initState() {
    super.initState();
    state = LoginState();
    // String subscriptionID =
    //     PrefObj.preferences?.get(PrefKeys.SUBSCRIPTIONID) ?? '';
    // log('SUBSCRIPTIONID $subscriptionID');
    // getToken();
  }

  // Future<String> getToken() async {
  //   String? token = await FirebaseMessaging.instance.getToken();
  //   log('token ${token.toString()}');
  //   return token!;
  // }

  @override
  void dispose() {
    if (countdownTimer != null) {
      countdownTimer!.cancel();
      isStop;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      if (Platform.isIOS) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
      } else {
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark));
      }
      return WillPopScope(
          onWillPop: () async {
            FocusScope.of(context).unfocus();
            if (state.showOTP == true || state.isMPIN == true || state.isMPIN == false) {
              setState(() {
                if (countdownTimer != null) {
                  countdownTimer!.cancel();
                  isStop = true;
                }
                state.showOTP = false;
                state.isMPIN = false;
                state.showMPINOTP = false;
                state.showLoginButtons = true;
              });

              state.isOTPSent = false;
              pinController.clear();
              mpinController.clear();
              confiMpinController.clear();
              phoneController.clear();
              return true;
            }

            return true;
          },
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: BackgroundImage(
                child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                        reverse: true,
                        child: Padding(
                            padding: EdgeInsets.only(top: 28.h),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                              buildSizedBoxH(70),
                              buildloginUser(),
                              dividerContainer(),
                              buildSizedBoxH(40),
                              builLoginImage(),
                              buildSizedBoxH(50),
                              numberTextFeild(state),
                              buildSizedBoxH(30),
                              if (!(state.showOTP) && !(state.isMPIN) && !(state.showMPINOTP))
                                Visibility(visible: state.showLoginButtons, child: Column(children: [buildSendOTP(state), buildSizedBoxH(20), buildSendMPIN(state), buildSizedBoxH(30)])),
                              if (state.showOTP) buildCheckemail(state),
                              if (state.isMPIN) buildMPIN(state),
                              if (state.showMPINOTP) buildMPINWithOTP(state),
                              buildSizedBoxH(16)
                            ])))),
              )));
    });
  }

//Login User Text
  Widget buildloginUser() {
    return Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(Lang.current.login, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 26.sp, color: AppColors.btnColor)),
      Text(Lang.current.user, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 26.sp, color: AppColors.btnColor, fontWeight: FontWeight.bold))
    ]));
  }

//Login Image
  Widget builLoginImage() {
    return Lottie.asset(Assets.image.lotties.jsonLogin.path, height: 250.h, width: 250.w, repeat: true);
  }

//Phone Number Textfeild
  Widget numberTextFeild(LoginState state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: RnwCustomTextFormField(
        context: context,
        enabled: !state.isOTPSent,
        hintText: Lang.current.lbl_ent_your_num,
        inputAction: TextInputAction.done,
        textInputType: TextInputType.phone,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        controller: phoneController,
        validator: FormValidators.validatePhoneNumber,
      ),
    );
  }

// Send OTP Button
  Widget buildSendOTP(LoginState state) {
    return RnWCustomButton(
        onPressed: () {
          if (countdownTimer != null) {
            countdownTimer!.cancel();
            isStop;
          }
          FocusScope.of(context).unfocus();

          if (formKey.currentState!.validate()) {
            context.read<LoginBloc>().add(PhoneNumberApiEvent(phoneNumber: phoneController.text.trim()));
            startTimer();
            Logger.lOG('resend otp : ${state.isStartTime}');
          }
        },
        isLoading: state.isLoading,
        isDisabled: state.isLoading || state.isMPINLoading,
        text: Lang.current.btn_login_with_otp);
  }

// Send MPIN Button
  Widget buildSendMPIN(LoginState state) {
    return RnWCustomButton(
      isoutline: true,
      isLoading: state.isMPINLoading,
      isDisabled: state.isMPINLoading || state.isLoading,
      text: Lang.current.btn_login_with_mpin,
      onPressed: () {
        FocusScope.of(context).unfocus();
        if (formKey.currentState!.validate()) {
          context.read<LoginBloc>().add(CheckMPINApiEvent(phoneNumber: phoneController.text.trim()));
          state.showOTP = false;
          state.isMPIN = false;
          state.showMPINOTP = false;
          Future.delayed(const Duration(milliseconds: 600), () {
            if (state.mpinModel?.data?.isMpin ?? false) {
              state.isMPIN = true;
            } else {
              state.isMPIN = false;
              state.showMPINOTP = true;
            }
          });
        }
      },
    );
  }

//Divider
  Widget dividerContainer() {
    return Container(height: 5.h, width: 130.w, decoration: BoxDecoration(color: AppColors.btnColor, borderRadius: BorderRadius.circular(5)));
  }

//Check your email for OTP
  Widget buildCheckemail(
    LoginState state,
  ) {
    return Column(children: [buildOTPFeild(state), buildSizedBoxH(20), buildResendOtp(state)]);
  }

//OTP TextFeild
  Widget buildOTPFeild(LoginState state) {
    return Column(children: [
      Text(Lang.current.lbl_enter_otp, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 18.sp, color: AppColors.blackcolor, fontWeight: FontWeight.w700)),
      buildSizedBoxH(10),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        child: CustomOtpTextField(
          otpController: pinController,
          validator: FormValidators.validateOTP,
          onCompleted: (value) {
            FocusScope.of(context).unfocus();
            if (value.length == 6) {
              state.isButtonEnabled = true;
              context.read<LoginBloc>().add(VerifyOTPApiEvent(phoneNumber: phoneController.text, otp: pinController.text, devicetoken: PrefKeys.TOKEN));
            }
          },
        ),
      )
    ]);
  }

  Widget buildOTPFeildmpin(LoginState state) {
    return Column(children: [
      Text(Lang.current.lbl_enter_otp, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 18.sp, color: AppColors.blackcolor, fontWeight: FontWeight.w700)),
      buildSizedBoxH(10),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        child: CustomOtpTextField(
          otpController: pinController,
          validator: FormValidators.validateOTP,
          onCompleted: (value) {
            FocusScope.of(context).unfocus();
          },
        ),
      )
    ]);
  }

//Resend Otp ,Sumbit button
  Widget buildResendOtp(LoginState state) {
    return Column(children: [
      Text(Lang.current.msg_dont_receive_otp, style: TextStyle(fontSize: 14.sp, color: AppColors.graytextColor)),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        GestureDetector(
            onTap: isStop
                ? () {
                    FocusScope.of(context).unfocus();
                    context.read<LoginBloc>().add(
                          ResendOTPEvent(phoneNumber: phoneController.text),
                        );
                    Logger.lOG('Resend :${phoneController.text}');
                    startTimer();
                  }
                : null,
            child: Text(isStop ? Lang.current.lbl_resend_otp : timerText, style: Theme.of(context).textTheme.bodyLarge?.copyWith(decoration: TextDecoration.underline)))
      ]),
      buildSizedBoxH(10),
      RnWCustomButton(
          isDisabled: !state.isButtonEnabled,
          isLoading: state.isLoad,
          text: Lang.current.btn_submit,
          onPressed: () {
            FocusScope.of(context).unfocus();
            if (formKey.currentState!.validate()) {
              context.read<LoginBloc>().add(VerifyOTPApiEvent(phoneNumber: phoneController.text, otp: pinController.text, devicetoken: PrefKeys.TOKEN));
            }
          }),
      buildSizedBoxH(30)
    ]);
  }

  //MPIN UI
  Widget buildMPIN(LoginState state) {
    return Column(children: [buildSizedBoxH(10), buildMPINFeild(), buildSizedBoxH(30), buildSubmitBtn(state)]);
  }

  Widget buildMPINWithOTP(LoginState state) {
    return Column(children: [
      buildSizedBoxH(10),
      buildOTPFeildmpin(state),
      buildSizedBoxH(10),
      buildNoMPINFeild(),
      buildSizedBoxH(20),
      buildConfiremMPINFeild(),
      buildSizedBoxH(30),
      buildSubmitMPINBtn(state),
    ]);
  }

//MPIN TextFeild
  Widget buildMPINFeild() {
    return Column(children: [
      Text(Lang.current.lbl_enter_mpin, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18.sp)),
      buildSizedBoxH(8),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        child: CustomOtpTextField(
          otpController: mpinController,
          validator: FormValidators.validateOTP,
          onCompleted: (value) {
            FocusScope.of(context).unfocus();
            if (value.length == 6) {
              state.isButtonEnabled == true;
              context.read<LoginBloc>().add(VerifyMPINApiEvent(phoneNumber: phoneController.text.trim(), mpin: mpinController.text.trim(), devicetoken: PrefKeys.TOKEN));
            }
          },
        ),
      )
    ]);
  }

  Widget buildNoMPINFeild() {
    return Column(children: [
      Text(Lang.current.lbl_enter_mpin, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 18.sp, color: AppColors.blackcolor, fontWeight: FontWeight.w700)),
      buildSizedBoxH(8),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        child: CustomOtpTextField(
          otpController: mpinController,
          validator: FormValidators.validateOTP,
          onCompleted: (value) {
            FocusScope.of(context).unfocus();
          },
        ),
      )
    ]);
  }

//MPIN ConfirmFeild
  Widget buildConfiremMPINFeild() {
    return Column(children: [
      Text(Lang.current.lbl_confirm_mpin, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 18.sp, color: AppColors.blackcolor, fontWeight: FontWeight.w700)),
      buildSizedBoxH(8),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        child: CustomOtpTextField(
          otpController: confiMpinController,
          validator: FormValidators.validateOTP,
          onCompleted: (value) {
            FocusScope.of(context).unfocus();
            if (formKey.currentState!.validate()) {
              if (mpinController.text == confiMpinController.text) {
                context.read<LoginBloc>().add(RegisterMPINVerifyOTPApiEvent(phoneNumber: phoneController.text.trim(), otp: pinController.text, mpin: mpinController.text));
              } else {
                showToast("Plese Enater confirmMPIN");
              }
            }
          },
        ),
      )
    ]);
  }

//Sumbit Mpin button
  Widget buildSubmitMPINBtn(LoginState state) {
    return Column(children: [
      RnWCustomButton(
        isLoading: state.isSubmitMPINLoading,
        isDisabled: !state.isButtonEnabled,
        text: Lang.current.btn_submit,
        onPressed: () {
          FocusScope.of(context).unfocus();
          if (formKey.currentState!.validate()) {
            if (mpinController.text == confiMpinController.text) {
              context.read<LoginBloc>().add(RegisterMPINVerifyOTPApiEvent(phoneNumber: phoneController.text.trim(), otp: pinController.text, mpin: mpinController.text));
            } else {
              showToast("Plese Enater MPIN");
            }
          }
        },
      ),
      buildSizedBoxH(30)
    ]);
  }

  //Sumbit button
  Widget buildSubmitBtn(LoginState state) {
    return Column(children: [
      RnWCustomButton(
          isDisabled: !state.isButtonEnabled,
          isLoading: state.isSubmitMPINLoading,
          text: Lang.current.btn_submit,
          onPressed: () {
            FocusScope.of(context).unfocus();
            if (formKey.currentState!.validate()) {
              if (state.showMPINOTP == true) {
                if (mpinController.text == confiMpinController.text) {
                  context.read<LoginBloc>().add(RegisterMPINVerifyOTPApiEvent(phoneNumber: phoneController.text.trim(), otp: pinController.text, mpin: mpinController.text));
                } else {
                  showToast("Plese Enater MPIN");
                }
              } else {
                context.read<LoginBloc>().add(VerifyMPINApiEvent(phoneNumber: phoneController.text.trim(), mpin: mpinController.text.trim(), devicetoken: PrefKeys.TOKEN));
                Logger.lOG('MPIN: ${mpinController.text}');
              }
            }
          }),
      buildSizedBoxH(30)
    ]);
  }
}
