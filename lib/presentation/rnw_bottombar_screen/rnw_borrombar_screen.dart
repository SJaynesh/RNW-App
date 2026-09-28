import 'dart:io';

import 'package:rnw_institue/apis/repositorise/notification_repository.dart';
import 'package:rnw_institue/apis/repositorise/ptm_report_repository.dart';
import 'package:rnw_institue/one_signal_notification/one_signal_config.dart';
import 'package:rnw_institue/presentation/rnw_notification_screen/bloc/notification_bloc.dart';
import 'package:rnw_institue/presentation/rnw_notification_screen/widget/notification_permission_page.dart';
import 'package:rnw_institue/utils/app_export.dart';
import 'package:rnw_institue/widget/rnw_app_update_helper/rnw_app_update_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static Widget builder(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<RnwBottombarBloc>(
          create: (context) => RnwBottombarBloc(const RnwBottombarState(bottomBarState: BottomBarState.initial),
              NotificationModuleRepository(apiClient: ApiClient()))
            ..add(MainHomeInitialEvent())),
      BlocProvider<NotificationBloc>(
        create: (_) =>
            NotificationBloc(const NotificationState(), NotificationModuleRepository(apiClient: ApiClient())),
      ),
      BlocProvider<HomeBloc>(
          create: (context) =>
              HomeBloc(const HomeState(), HomeModuleRepository(apiClient: ApiClient()))..add(GetStudentListAPIEvent())),
      BlocProvider<ReportBloc>(
          create: (context) =>
              ReportBloc(ReportilsitialEvent(), reportRepository: ReportRepository(apiClient: ApiClient()))),
      BlocProvider<ProfileBloc>(create: (context) => ProfileBloc()),
      BlocProvider<SettingsBloc>(
          create: (context) => SettingsBloc(const SettingsState(), AuthRepository(apiClient: ApiClient()))),
    ], child: const HomeScreen());
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  bool skipButton = false;
  bool _isApiCalled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkAndRequestNotificationPermission();
    context.read<RnwBottombarBloc>().add(CreateUserDeviceTokenApiEvent(
        phoneNumber: PrefObj.preferences?.get(PrefKeys.PHONENUMBER).toString() ?? '',
        oneSignalID: PrefObj.preferences?.get(PrefKeys.SUBSCRIPTIONID) ?? ''));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkPermissionAfterReturning();
    }
  }

  Future<void> _checkPermissionAfterReturning() async {
    if (await Permission.notification.status.isGranted) {
      scheduleMicrotask(() async => await initializeOneSignalNotification());
      if (!_isApiCalled) {
        _loadApi();
        // _isApiCalled = true;
      }
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return !skipButton
        ? _buildSplashContent()
        : BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themestate) {
            return BlocBuilder<RnwBottombarBloc, RnwBottombarState>(builder: (context, state) {
              return DoubleTapToExit(
                  child: Scaffold(
                      resizeToAvoidBottomInset: false,
                      body: _getbottombarContent(state),
                      extendBody: true,
                      bottomNavigationBar: _buildNavigationBar(state, themestate)));
            });
          });
  }

  Widget _buildSplashContent() {
    return PermissionAskerBuilder(
      permissions: const [Permission.notification],
      loaderBuilder: (context) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
      grantedBuilder: (context) {
        scheduleMicrotask(() async {
          await initializeOneSignalNotification();
          // _loadApi();
          if (!_isApiCalled) _loadApi();
        });
        return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themestate) {
          return BlocBuilder<RnwBottombarBloc, RnwBottombarState>(builder: (context, state) {
            return DoubleTapToExit(
                child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    body: _getbottombarContent(state),
                    extendBody: true,
                    bottomNavigationBar: _buildNavigationBar(state, themestate)));
          });
        });
      },
      notGrantedBuilder: (context, notGrantedPermissions) {
        return NotificationPermissionPage(
          onEnable: () {
            _checkPermissionAfterReturning();
          },
          onSkip: () => _loadApi(),
        );
      },
      notGrantedListener: (notGrantedPermissions) async {
        await notGrantedPermissions[0].permission.request();
      },
    );
  }

  Future<void> _checkAndRequestNotificationPermission() async {
    // Request notification permission
    var status = await Permission.notification.status;

    if (status.isGranted) {
    } else if (status.isDenied || status.isPermanentlyDenied) {
      setState(() {});
    }
  }

  _loadApi() async {
    if (_isApiCalled) return;
    _isApiCalled = true;
    skipButton = true;
    setState(() {
      Logger.lOG('Version Update Dialog');
    });
    Logger.lOG('Version Dialog');
    await _checkForAppUpdate();
  }

  Widget _buildNavigationBar(RnwBottombarState state, ThemeState themestate) {
    double safeAreaHeight = MediaQuery.of(context).padding.bottom;
    return Container(
        height: Platform.isIOS
            ? safeAreaHeight > 0
                ? 90.h
                : 70.h
            : 70.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(25.r), topEnd: Radius.circular(25.r)),
            color: AppColors.whitecolor,
            boxShadow: const [BoxShadow(blurRadius: 2, color: AppColors.boxShadow)]),
        margin: EdgeInsets.zero,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
          _customNavigationDestination(
              path: Assets.image.icon.icHome.path,
              label: Lang.of(context).lbl_home,
              isSelected: state.bottomBarState == BottomBarState.initial,
              onTap: () {
                FocusScope.of(context).unfocus();
                context.read<RnwBottombarBloc>().add(MainHomeInitialEvent());
              },
              themestate: themestate),
          _customNavigationDestination(
              path: Assets.image.icon.icFillApp.path,
              label: Lang.of(context).lbl_fill_app,
              isSelected: state.bottomBarState == BottomBarState.fillApp,
              onTap: () {
                FocusScope.of(context).unfocus();
                context.read<RnwBottombarBloc>().add(CommunityEvent());
              },
              themestate: themestate),
          _customNavigationDestination(
              path: Assets.image.icon.icProfile.path,
              label: Lang.of(context).profile,
              isSelected: state.bottomBarState == BottomBarState.userProfile,
              onTap: () {
                FocusScope.of(context).unfocus();
                context.read<RnwBottombarBloc>().add(UserProfilesEvent());
              },
              themestate: themestate)
        ]));
  }

  TextStyle labelStyle = TextStyle(color: Colors.grey, fontSize: 12.sp);
  TextStyle selectedLabelStyle = TextStyle(color: AppColors.primaryColor, fontSize: 12.sp);

  Widget _customNavigationDestination(
      {required String path,
      required String label,
      required bool isSelected,
      required VoidCallback onTap,
      required ThemeState themestate}) {
    return InkWell(
        onTap: onTap,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 5.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: isSelected ? AppColors.primaryColor.withOpacity(0.1) : Colors.transparent),
              child: _bottombarIcon(path, themestate, isSelect: isSelected)),
          buildSizedBoxH(2),
          Text(label, style: isSelected ? selectedLabelStyle : labelStyle)
        ]));
  }

  CustomImageView _bottombarIcon(String path, ThemeState themestate, {bool isSelect = false}) {
    return CustomImageView(
        imagePath: path, height: 25.h, color: isSelect ? AppColors.primaryColor : AppColors.borderColor);
  }

  Widget _getbottombarContent(RnwBottombarState state) {
    switch (state.bottomBarState) {
      case BottomBarState.initial:
        return const RNWHomeScreen();

      case BottomBarState.report:
        // return const RNWAnnouncementScreen();
        return RNWReportScreen();

      case BottomBarState.fillApp:
        return const RNWFillApp();

      case BottomBarState.userProfile:
        return const RNWProfileScreen();

      default:
        return const SizedBox.shrink();
    }
  }

// Modify your _checkForAppUpdate method in HomeScreen
  // _checkForAppUpdate() async {
  //   final settingsBloc = context.read<SettingsBloc>();
  //   settingsBloc.add(const VersionEvent());

  //   // Wait for the version check to complete
  //   await Future.delayed(const Duration(milliseconds: 1600));

  //   // Get the current state of the SettingsBloc
  //   final versionModel = settingsBloc.state.versionModel;

  //   if (versionModel != null) {
  //     await RNWAppUpdateHelper.checkForUpdate(context, versionModel);
  //   }
  // }
  _checkForAppUpdate() async {
    final settingsBloc = context.read<SettingsBloc>();
    settingsBloc.add(const VersionEvent());

    await Future.delayed(const Duration(milliseconds: 1600));

    final versionModel = settingsBloc.state.versionModel;
    if (versionModel != null) {
      await RNWAppUpdateHelper.checkForUpdate(context, versionModel);
    }
  }
  // String? contactNumber = widget.studentdetails.first.contact;
}
