import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:rnw_institue/utils/app_export.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

Future<void> initializeOneSignalNotification() async {
  try {
    // Remove this method to stop OneSignal Debugging
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    // Initialize OneSignal with your app ID
    OneSignal.initialize('dd6f30b9-c8c3-4859-8a9b-068042f5dfe3');
    // Request permission for notifications
    await OneSignal.Notifications.requestPermission(true);
    // Loop until permission is granted
    await getSubscriptionId();

    // Add foreground notification listener
    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      WakelockPlus.enable();
      Logger.lOG(
          'NOTIFICATION WILL DISPLAY LISTENER CALLED WITH: ${event.notification.jsonRepresentation()}');
      event.preventDefault();
      event.notification.display();
      Future.delayed(
        const Duration(seconds: 10),
        () {
          WakelockPlus.disable();
        },
      );
    });

    // Notification opened listener
    OneSignal.Notifications.addClickListener((openedResult) {
      String? screen;
      Logger.lOG(
          'NOTIFICATION OPENED LISTENER CALLED WITH: ${openedResult.notification.jsonRepresentation()}');
      final data = openedResult.notification.additionalData;
      screen = data?['screen_type'];
      if (screen != null) {
        NavigatorService.navigatorKey.currentState?.pushNamed(screen);
      }
    });
  } catch (e) {
    Logger.lOG("Error initializing OneSignal: $e");
  }
}

Future<void> getSubscriptionId() async {
  OneSignal.Notifications.addPermissionObserver(
    (permission) {
      Logger.lOG("permission");
    },
  );
  if (await Permission.notification.isGranted) {
    String? externalId = await OneSignal.User.getExternalId();
    OneSignal.login(externalId.toString());
    Logger.lOG("PushSubscription Id: ${OneSignal.User.pushSubscription.id}");
    PrefObj.preferences?.put(
        PrefKeys.SUBSCRIPTIONID, OneSignal.User.pushSubscription.id ?? '');

    NavigatorService.navigatorKey.currentContext?.read<RnwBottombarBloc>().add(
        CreateUserDeviceTokenApiEvent(
            phoneNumber:
                PrefObj.preferences?.get(PrefKeys.PHONENUMBER).toString() ?? '',
            oneSignalID:
                PrefObj.preferences?.get(PrefKeys.SUBSCRIPTIONID) ?? ''));
  }
}
