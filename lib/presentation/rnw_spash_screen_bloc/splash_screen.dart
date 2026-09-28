import 'package:rnw_institue/utils/app_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<RnwSpalshScreenBloc>(
      create: (context) => RnwSpalshScreenBloc(RnwSpalshScreenState())
        ..add(SplashInitialEvent()),
      child: const SplashScreen(),
    );
  }

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  // bool _hasNavigated = false;
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addObserver(this);
  //   _checkAndRequestNotificationPermission();
  // }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.resumed) {
  //     _checkPermissionAfterReturning();
  //   }
  // }

  // Future<void> _checkPermissionAfterReturning() async {
  //   if (await Permission.notification.status.isGranted) {
  //     scheduleMicrotask(() => initializeOneSignalNotification());
  //     _navigateToNextScreen();
  //   } else {
  //     setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: _buildSplashContent(),
      body: BackgroundImage(
        child: BlocListener<RnwSpalshScreenBloc, RnwSpalshScreenState>(
          listener: (context, state) {},
          child: _buildSplashImage(),
        ),
      ),
    );
  }

  // Widget _buildSplashContent() {
  //   return FutureBuilder(
  //     future: Permission.notification.status,
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return _buildSplashImage();
  //       }

  //       if (snapshot.hasData && snapshot.data!.isGranted) {
  //         scheduleMicrotask(() => initializeOneSignalNotification());
  //         return _buildSplashImage();
  //       } else {
  //         return NotificationPermissionPage(
  //           onEnable: () {},
  //           onSkip: () {},
  //         );
  //       }
  //     },
  //   );
  // }

  _buildSplashImage() {
    return Column(children: [
      buildSizedBoxH(80.0),
      CustomImageView(
        alignment: Alignment.center,
        imagePath: Assets.image.png.pngRnwLogo.path,
        height: 150.h,
        width: 150.w,
      ),
      const Spacer(),
      Text(
        textAlign: TextAlign.center,
        "Shaping skills for scaling higher..!!",
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 14.w,
            fontWeight: FontWeight.w800,
            color: AppColors.primaryColor),
      ),
      buildSizedBoxH(60.0),
    ]);
  }

  Widget _buildPermissionRequestUI() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            // ClipRRect(
            //   borderRadius:
            //       const BorderRadius.vertical(top: Radius.circular(16.0)),
            //   child: CustomImageView(
            //     imagePath: Assets.images.png.other.pngNotificatonHeader.path,
            //     height: 250.h,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 40.0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      // _skipPermission();
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Lang.of(context).lbl_skip',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        buildSizedBoxH(16),
        Flexible(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0.w),
            child: Column(
              children: [
                Text(
                  'Lang.of(context).lbl_allow_yoii_notification_permission',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                Text(
                  'Lang.of(context).lbl_notification_subtitle',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: Theme.of(context).iconTheme.color),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                RnWCustomButton(
                  width: double.infinity,
                  isDisabled: false,
                  onPressed: () async {
                    await openAppSettings();
                    // _checkPermissionAfterReturning();
                  },
                  text: 'Lang.of(context).lbl_enable',
                ),
              ],
            ),
          ),
        ),
        buildSizedBoxH(30),
      ],
    );
  }

  // Future<void> _skipPermission() async {
  //   _navigateToNextScreen();
  // }

  // Future<void> _checkAndRequestNotificationPermission() async {
  //   var status = await Permission.notification.status;

  //   if (status.isGranted) {
  //     scheduleMicrotask(() => initializeOneSignalNotification());
  //     _navigateToNextScreen();
  //   } else if (status.isDenied || status.isPermanentlyDenied) {
  //     setState(() {});
  //   }
  // }

  // _navigateToNextScreen() {
  //   if (_hasNavigated) return;
  //   _hasNavigated = true;

  //   Future.delayed(const Duration(milliseconds: 500), () {
  //     if (PrefObj.preferences?.get(PrefKeys.DEVICETOKEN) == null) {
  //       NavigatorService.pushReplacement(AppRoutes.loginScreen);
  //     } else {
  //       NavigatorService.pushReplacement(AppRoutes.homeScreen);
  //     }
  //   });
  // }
}
