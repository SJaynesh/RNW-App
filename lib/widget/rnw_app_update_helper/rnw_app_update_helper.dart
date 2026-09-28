// import 'dart:io';

// import 'package:rnw_institue/presentation/rnw_settings_screen/model/rnw_version.dart';
// import 'package:rnw_institue/utils/app_export.dart';

// class RNWAppUpdateHelper {
//   static Future<bool> checkForUpdate(BuildContext context, VersionModel versionModel) async {
//     try {
//       // Get current app version
//       PackageInfo packageInfo = await PackageInfo.fromPlatform();
//       String currentVersion = packageInfo.version;
//       Logger.lOG("versionModel data version ${versionModel.data?.version}");

//       // Check if server version is different from current version
//       if (versionModel.data?.version != null && currentVersion != versionModel.data!.version!) {
//         await _showUpdateDialog(
//             context,
//             currentVersion,
//             versionModel.data!.version!,
//             Platform.isIOS ? 'https://apps.apple.com/us/app/rnw-student-app/id6449534062' : 'https://play.google.com/store/apps/details?id=${packageInfo.packageName}',
//             'A new version of the app is available.');
//         return true;
//       } else {
//         if (PrefObj.preferences!.get(PrefKeys.SUBSCRIPTIONID) != null) {
//           context
//               .read<RnwBottombarBloc>()
//               .add(CreateUserDeviceTokenApiEvent(phoneNumber: PrefObj.preferences?.get(PrefKeys.PHONENUMBER).toString() ?? '', oneSignalID: PrefObj.preferences?.get(PrefKeys.SUBSCRIPTIONID) ?? ''));
//         }
//         context.read<HomeBloc>().add(GetStudentListAPIEvent());
//         context.read<BannerBloc>().add(GetBannerAPIEvent());
//         return false;
//       }
//     } catch (e) {
//       print('Error checking app update: $e');
//       return false;
//     }
//   }

//   static Future<void> _showUpdateDialog(BuildContext context, String currentVersion, String newVersion, String? updateLink, String updateMessage) {
//     return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext ctx) {
//         return WillPopScope(
//           onWillPop: () async => false,
//           child: AlertDialog(
//             title: const Text(
//               'Update Available',
//               textAlign: TextAlign.center,
//             ),
//             content: SingleChildScrollView(
//               child: ListBody(
//                 children: <Widget>[
//                   Text(updateMessage),
//                   Text('Current Version: $currentVersion'),
//                   Text('New Version: $newVersion'),
//                 ],
//               ),
//             ),
//             actions: <Widget>[
//               TextButton(
//                 child: const Text('Update'),
//                 onPressed: () {
//                   if (updateLink != null) {
//                     _launchUpdateUrl(updateLink);
//                     Logger.lOG("update Url:-- $updateLink");
//                   }
//                 },
//               ),
//               TextButton(
//                 child: const Text('Cancel'),
//                 onPressed: () {
//                   if (PrefObj.preferences!.get(PrefKeys.SUBSCRIPTIONID) != null) {
//                     context.read<RnwBottombarBloc>().add(CreateUserDeviceTokenApiEvent(
//                         phoneNumber: PrefObj.preferences?.get(PrefKeys.PHONENUMBER).toString() ?? '', oneSignalID: PrefObj.preferences?.get(PrefKeys.SUBSCRIPTIONID) ?? ''));
//                   }
//                   context.read<HomeBloc>().add(GetStudentListAPIEvent());
//                   context.read<BannerBloc>().add(GetBannerAPIEvent());
//                   Navigator.of(ctx).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   static Future<void> _launchUpdateUrl(String updateLink) async {
//     final Uri url = Uri.parse(updateLink);
//     if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
//       throw Exception('Could not launch $url');
//     }
//   }
// }
import 'dart:io';
import 'package:in_app_update/in_app_update.dart';
import 'package:rnw_institue/presentation/rnw_settings_screen/model/rnw_version.dart';
import 'package:rnw_institue/utils/app_export.dart';

class RNWAppUpdateHelper {
  static Future<void> checkForUpdate(
      BuildContext context, VersionModel versionModel) async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String currentVersion = packageInfo.version;
      String? serverVersion = versionModel.data?.version;

      Logger.lOG(
          "Server version: $serverVersion, Current version: $currentVersion");

      if (serverVersion != null && currentVersion != serverVersion) {
        if (Platform.isAndroid) {
          _handleAndroidUpdate();
        } else if (Platform.isIOS) {
          _redirectToAppStore();
        }
      } else {
        _fetchAppData(context);
      }
    } catch (e) {
      Logger.lOG('Error checking app update: $e');
    }
  }

  static Future<void> _handleAndroidUpdate() async {
    try {
      AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();

      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        if (updateInfo.immediateUpdateAllowed) {
          await InAppUpdate.performImmediateUpdate().catchError((e) {
            Logger.lOG("Immediate update failed: $e");
          });
        } else if (updateInfo.flexibleUpdateAllowed) {
          await InAppUpdate.startFlexibleUpdate();
          await InAppUpdate.completeFlexibleUpdate();
        }
      }
    } catch (e) {
      Logger.lOG('Failed to check in-app update: $e');
    }
  }

  static void _redirectToAppStore() {
    const String appStoreUrl =
        'https://apps.apple.com/us/app/rnw-student-app/id6449534062';
    _launchUpdateUrl(appStoreUrl);
  }

  static void _fetchAppData(BuildContext context) {
    if (PrefObj.preferences!.get(PrefKeys.SUBSCRIPTIONID) != null) {
      context.read<RnwBottombarBloc>().add(CreateUserDeviceTokenApiEvent(
          phoneNumber:
              PrefObj.preferences?.get(PrefKeys.PHONENUMBER).toString() ?? '',
          oneSignalID:
              PrefObj.preferences?.get(PrefKeys.SUBSCRIPTIONID) ?? ''));
    }
    context.read<HomeBloc>().add(GetStudentListAPIEvent());
    context.read<BannerBloc>().add(GetBannerAPIEvent());
  }

  static Future<void> _launchUpdateUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
  }
}
