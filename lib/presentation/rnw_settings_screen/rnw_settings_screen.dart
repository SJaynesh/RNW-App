// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:rnw_institue/utils/app_export.dart';

class RnwsettingsScreen extends StatefulWidget {
  const RnwsettingsScreen({super.key});
  static Widget builder(BuildContext context) {
    return BlocProvider<SettingsBloc>(
        create: (context) => SettingsBloc(
            const SettingsState(), AuthRepository(apiClient: ApiClient()))
          ..add(const VersionEvent()),
        child: const RnwsettingsScreen());
  }

  @override
  State<RnwsettingsScreen> createState() => _RnwsettingsScreenState();
}

class _RnwsettingsScreenState extends State<RnwsettingsScreen> {
  final String playStoreUrl = 'https://play.google.com/store/apps/details?id=';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      return Scaffold(
          appBar: RNWAppBar(
              title: Text(Lang.current.lbl_settings,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.whitecolor)),
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    NavigatorService.goBack();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: AppColors.whitecolor))),
          body: BackgroundImage(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Column(children: [
                  buildSizedBoxH(30),
                  buildNotification(),
                  buildSizedBoxH(25),
                  buildOthersettings(),
                  buildSizedBoxH(25),
                  const Spacer(),
                  _buildTermandConditionOrVirsion(state),
                  buildSizedBoxH(25)
                ])),
          ));
    });
  }

  // Notification Container
  Widget buildNotification() {
    return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                    child: Container(
                        height: 320.h,
                        padding: EdgeInsets.symmetric(
                            horizontal: 9.w, vertical: 10.h),
                        decoration: BoxDecoration(
                            color: AppColors.whitecolor,
                            borderRadius: BorderRadius.circular(26.r)),
                        child: Column(children: [
                          buildSizedBoxH(20),
                          Image.asset(Assets.image.png.pngPushNotification.path,
                              scale: 2.5.sp),
                          buildSizedBoxH(12),
                          Text(Lang.current.lbl_notification_setting,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.sp)),
                          buildSizedBoxH(10),
                          Text(
                              textAlign: TextAlign.center,
                              Lang.current.lbl_setting_of_the_notification,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.grayColors,
                                      fontSize: 12.sp)),
                          buildSizedBoxH(10),
                          TextButton(
                              autofocus: false,
                              onPressed: () async {
                                openAppSettings();
                              },
                              child: Text(Lang.current.lbl_go_to_settings,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15.sp,
                                          color: AppColors.primaryColor)))
                        ])));
              });
        },
        child: Container(
            height: 45.h,
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.whitecolor,
                borderRadius: BorderRadius.circular(5.r),
                boxShadow: const [
                  BoxShadow(blurRadius: 1, color: Colors.black26)
                ]),
            child: Row(children: [
              buildSizedboxW(10),
              Text(Lang.current.lbl_notification_setting,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                      color: Colors.black87)),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios_rounded, size: 20),
              buildSizedboxW(10)
            ])));
  }

// Other Settings
  Widget buildOthersettings() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Expanded(
          child: GestureDetector(
              onTap: () {
                NavigatorService.pushNamed(AppRoutes.rnwcontactusscreen);
              },
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  decoration: BoxDecoration(
                      color: AppColors.whitecolor,
                      borderRadius: BorderRadius.circular(6.r),
                      boxShadow: const [
                        BoxShadow(blurRadius: 1, color: Colors.black26)
                      ]),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomImageView(
                            imagePath: Assets.image.icon.icContactUs.path,
                            height: 35.h,
                            width: 35.h),
                        Text(Lang.current.lbl_contact_us,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: AppColors.primaryColor,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600))
                      ])))),
      buildSizedboxW(15),
      // Expanded(
      //     child: Container(
      //         padding: EdgeInsets.symmetric(vertical: 15.h),
      //         decoration: BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.circular(6.sp),
      //             boxShadow: const [
      //               BoxShadow(blurRadius: 1, color: Colors.black26)
      //             ]),
      //         child: GestureDetector(
      //             onTap: () async {
      //               final packageInfo =
      //                   (await PackageInfo.fromPlatform()).packageName;

      //               FocusScope.of(context).unfocus();
      //               String storeUrl = Platform.isIOS
      //                   ? 'Download Red & White Application on App store : https://apps.apple.com/in/app/rnw-student-app/id6449534062'
      //                   : 'Download Red & White Application on Play store : $playStoreUrl$packageInfo';
      //               Share.share(storeUrl);
      //             },
      //             child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                 children: [
      //                   CustomImageView(
      //                       imagePath: Assets.image.icon.icShare.path,
      //                       height: 35.h,
      //                       width: 35.h),
      //                   Text(Lang.current.lbl_share,
      //                       style: Theme.of(context)
      //                           .textTheme
      //                           .bodyMedium
      //                           ?.copyWith(
      //                               color: AppColors.primaryColor,
      //                               fontSize: 13.sp,
      //                               fontWeight: FontWeight.w600))
      //                 ])))),
      // buildSizedboxW(15),
      Expanded(
          child: GestureDetector(
              onTap: () async {
                final packageInfo =
                    (await PackageInfo.fromPlatform()).packageName;
                String storeUrl =
                    Platform.isIOS ? playStoreUrl : '$playStoreUrl$packageInfo';
                await canLaunch(storeUrl)
                    ? await launch(storeUrl)
                    : throw 'Could not launch $storeUrl';
              },
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  decoration: BoxDecoration(
                      color: AppColors.whitecolor,
                      borderRadius: BorderRadius.circular(6.sp),
                      boxShadow: const [
                        BoxShadow(blurRadius: 1, color: Colors.black26)
                      ]),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomImageView(
                            imagePath: Assets.image.icon.icRateUs.path,
                            height: 35.h,
                            width: 35.h),
                        Text(Lang.current.lbl_rate_us,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: AppColors.primaryColor,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600))
                      ]))))
    ]);
  }

//Sign Out Button
  Widget buildSignOutBtn() {
    return MaterialButton(
        height: 50.h,
        minWidth: 200.w,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.sp)),
        color: AppColors.primaryColor,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                    child: Container(
                        height: 220.h,
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(26.sp)),
                        child: Column(children: [
                          buildSizedBoxH(20),
                          CustomImageView(
                              imagePath: Assets.image.png.pngAlert.path,
                              height: 50.h,
                              color: AppColors.primaryColor),
                          buildSizedBoxH(12),
                          Text(Lang.current.lbl_please_confirm,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.w700)),
                          buildSizedBoxH(10),
                          Text(
                              textAlign: TextAlign.center,
                              Lang.current.lbl_are_sure_log_out,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black45)),
                          buildSizedBoxH(20),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //cancel Button
                                InkWell(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      NavigatorService.goBack();
                                    },
                                    child: Container(
                                        height: 45.h,
                                        width: 100.w,
                                        decoration: BoxDecoration(
                                            color: AppColors.whitecolor,
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            boxShadow: const [
                                              BoxShadow(
                                                  blurRadius: 1,
                                                  color: AppColors.primaryColor)
                                            ]),
                                        child: Center(
                                            child: Text(Lang.current.lbl_cancle,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        color: AppColors
                                                            .primaryColor))))),
                                //Sign Out button
                                InkWell(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      PrefObj.preferences?.clear();

                                      NavigatorService.pushAndRemoveUntil(
                                        AppRoutes.loginScreen,
                                        routePredicate: (route) => false,
                                      );
                                    },
                                    child: Container(
                                        height: 45.h,
                                        width: 100.w,
                                        decoration: BoxDecoration(
                                            color: AppColors.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            boxShadow: const [
                                              BoxShadow(
                                                  blurRadius: 1,
                                                  color: AppColors.primaryColor)
                                            ]),
                                        child: Center(
                                            child: Text(
                                                Lang.current.lbl_sign_out,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        color: AppColors
                                                            .whitecolor)))))
                              ])
                        ])));
              });
        },
        child: Text(Lang.current.btn_signout,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.whitecolor)));
  }

//Terms asnd condition and version
  Widget _buildTermandConditionOrVirsion(SettingsState state) {
    return Column(children: [
      RichText(
          text: TextSpan(
              text: '',
              style: const TextStyle(color: Colors.black),
              children: [
            TextSpan(
                text: Lang.current.lbl_terms_and_condition,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.primaryColor,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w600,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationThickness: 2,
                    decorationColor: AppColors.primaryColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    FocusScope.of(context).unfocus();
                    NavigatorService.pushNamed(
                        AppRoutes.rnwtermsandconditionscreen);
                  }),
            TextSpan(
                text: Lang.current.lbl_of_using_app,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: AppColors.textboldColor))
          ])),
      buildSizedBoxH(15),
      Text(
          textAlign: TextAlign.center,
          "Version\n${state.versionModel?.data?.version ?? "1.0"}",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 14.sp,
              color: AppColors.textboldColor))
    ]);
  }
}

class FadePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadePageRoute({required this.page})
      : super(
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = 0.0;
              const end = 1.0;
              const curve = Curves.easeInOut;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var opacityAnimation = animation.drive(tween);

              return FadeTransition(opacity: opacityAnimation, child: child);
            });
}
