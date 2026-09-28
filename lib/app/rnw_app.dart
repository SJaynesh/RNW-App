import 'package:rnw_institue/apis/repositorise/notification_repository.dart';
import 'package:rnw_institue/one_signal_notification/one_signal_config.dart';
import 'package:rnw_institue/utils/app_export.dart';

class RnwApp extends StatefulWidget {
  // Constructor that requires a Box for preferences
  const RnwApp({super.key, required this.prefs});

  final Box prefs;

  @override
  State<RnwApp> createState() => _RnwAppState();
}

// Global key for the scaffold messenger, used to show snack bars or other messages
final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class _RnwAppState extends State<RnwApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    // SocketService.initializeSocket();
    _initializeNotifications();
    WidgetsBinding.instance.addObserver(this);
  }

  Future<void> _initializeNotifications() async {
    // Initialize OneSignal configuration
    await initializeOneSignalNotification();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.paused) {
  //     // App is in the background
  //     SocketService.closeConnection();
  //   } else if (state == AppLifecycleState.resumed) {
  //     // App is in the foreground
  //     SocketService.initializeSocket();
  //     Future.delayed(const Duration(seconds: 2), () {
  //       Logger.lOG("RECONNECT");
  //       if (PrefObj.preferences?.get(PrefKeys.DEVICETOKEN) != null) {
  //         SocketService.emit(APIEndPoints.joinSocket, {
  //           'Authorization': PrefObj.preferences?.get(PrefKeys.DEVICETOKEN),
  //         });
  //         SocketService.response(
  //           APIEndPoints.joinSocket,
  //           (joinSocket) {},
  //         );
  //       }
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // Initialize preferences in a global object
    PrefObj.preferences = widget.prefs;

    return MultiBlocProvider(
      providers: [
        // Provide ConnectivityBloc for network connectivity management
        BlocProvider<ConnectivityBloc>(
          create: (context) => ConnectivityBloc(InternetConnectionChecker()),
        ),
        // Provide ThemeBloc for managing app theme (light/dark)
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
        // Provide LocaleBloc for managing locale (language) settings
        BlocProvider<LocaleBloc>(
          create: (context) => LocaleBloc(),
        ),
        // Provide LoginBloc for managing authentication state
        BlocProvider<LoginBloc>(
          create: (context) =>
              LoginBloc(LoginState(), AuthRepository(apiClient: ApiClient()))
                ..add(LoginInitialEvent()),
        ),
        // Provide HomeBloc for managing home screen state
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(
              const HomeState(), HomeModuleRepository(apiClient: ApiClient()))
            ..add(HomeInstitialEvent()),
        ),
        // Provide FeesDetailBloc for managing fee details
        BlocProvider<FeesDetailBloc>(
          create: (context) => FeesDetailBloc(
              FeesDetailInitial(), HomeModuleRepository(apiClient: ApiClient()))
            ..add(FeesdetailsitialEvent()),
        ),
        // Provide BannerBloc for managing banner data
        BlocProvider(
          create: (context) => BannerBloc(
              const BannerState(), BannerRepository(apiClient: ApiClient()))
            ..add(GetBannerAPIEvent()),
        ),
        BlocProvider<RnwBottombarBloc>(
            create: (context) => RnwBottombarBloc(
                const RnwBottombarState(bottomBarState: BottomBarState.initial),
                NotificationModuleRepository(apiClient: ApiClient()))
              ..add(MainHomeInitialEvent())),
      ],
      child: BlocBuilder<ConnectivityBloc, ConnectivityState>(
        builder: (context, connectivityState) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              return BlocBuilder<LocaleBloc, LocaleState>(
                builder: (context, localeState) {
                  return AnnotatedRegion<SystemUiOverlayStyle>(
                    value: SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                      statusBarIconBrightness: themeState.isDarkThemeOn
                          ? Brightness.light
                          : Brightness.dark,
                    ),
                    child: ScreenUtilInit(
                      designSize: const Size(375, 812),
                      minTextAdapt: true,
                      splitScreenMode: true,
                      builder: (context, child) => MaterialApp(
                        scaffoldMessengerKey: rootScaffoldMessengerKey,
                        theme: themeState.isDarkThemeOn
                            ? RnWThemeHelper.darkTheme
                            : RnWThemeHelper.lightTheme,
                        debugShowCheckedModeBanner: false,
                        navigatorKey: NavigatorService.navigatorKey,
                        locale: localeState.locale,
                        supportedLocales: Lang.delegate.supportedLocales,
                        localizationsDelegates: const [
                          Lang.delegate,
                          GlobalMaterialLocalizations.delegate,
                          GlobalWidgetsLocalizations.delegate,
                          GlobalCupertinoLocalizations.delegate,
                        ],
                        initialRoute: AppRoutes.initialRoute,
                        routes: AppRoutes.routes,
                        builder: (context, child) {
                          // Check connectivity and show appropriate UI
                          if (!connectivityState.isConnected) {
                            return MediaQuery(
                              data: MediaQuery.of(context).copyWith(
                                highContrast: true,
                                displayFeatures:
                                    MediaQuery.of(context).displayFeatures,
                                gestureSettings:
                                    MediaQuery.of(context).gestureSettings,
                                textScaler: TextScaler.noScaling,
                                invertColors: false,
                                boldText: false,
                              ),
                              child: Scaffold(
                                body: Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 100.0.h),
                                    child: RnwxceptionWidget(
                                      imagePath: Assets
                                          .image.svg.svgNetworkConnection.path,
                                      title: Lang.current.lbl_please_connect,
                                      subtitle: '',
                                      showGif: false,
                                      onButtonPressed: () {
                                        context
                                            .read<ConnectivityBloc>()
                                            .add(ConnectivityChecked());
                                      },
                                      buttonText:
                                          Lang.of(context).lbl_try_again,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          // Render the child widget if connected
                          return MediaQuery(
                            data: MediaQuery.of(context).copyWith(
                              highContrast: true,
                              displayFeatures:
                                  MediaQuery.of(context).displayFeatures,
                              gestureSettings:
                                  MediaQuery.of(context).gestureSettings,
                              textScaler: TextScaler.noScaling,
                              invertColors: false,
                              boldText: false,
                            ),
                            child: child!,
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
