import 'dart:io';
import 'package:rnw_institue/utils/app_export.dart';
import 'package:rnw_institue/utils/mixin.dart';

class RNWProfileScreen extends StatefulWidget {
  const RNWProfileScreen({super.key});
  static Widget builder(BuildContext context) {
    return const RNWProfileScreen();
  }

  @override
  State<RNWProfileScreen> createState() => _RNWProfileScreenState();
}

class _RNWProfileScreenState extends State<RNWProfileScreen> {
  int? isSelected = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RNWAppBar(
        title: Text(Lang.current.profile),
        action: [
          Padding(
            padding: EdgeInsets.only(right: 10.sp),
            child: GestureDetector(
              onTap: () {
                NavigatorService.pushNamed(AppRoutes.rnwnotificationslist);
              },
              child: notificationIcon(),
            ),
          ),
        ],
      ),
      body: BackgroundImage(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildUserInfoColumn(),
              buildSizedBoxH(10),
              Divider(
                  thickness: 1, color: AppColors.blackcolor.withOpacity(0.4)),
              buildSizedBoxH(5),
              buildOtherOptions(),
            ],
          ),
        ),
      ),
    );
  }

  // User Info Section
  Widget buildUserInfoColumn() {
    String stdName = PrefObj.preferences?.get(PrefKeys.STDNAME) ?? 'N/A';
    String? grId = PrefObj.preferences?.get(PrefKeys.GRID)?.toString() ?? 'N/A';
    String stdPhoto = PrefObj.preferences?.get(PrefKeys.PHOTO) ?? '';
    String imageUrl = stdPhoto == 'null'
        ? Assets.image.png.pngProfilePlaceholder.path
        : "${ApiEndPoints.studentimagebaseurl}$stdPhoto";

    Logger.lOG("Image Url:-----    $imageUrl");

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildSizedBoxH(15),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    color: AppColors.primaryColor.withOpacity(0.2)),
              ],
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
            ),
            child: CustomImageView(
              height: 150.h,
              width: 145.w,
              fit: BoxFit.cover,
              imagePath: imageUrl,
              radius: BorderRadius.circular(10.r),
            ),
          ),
          buildSizedBoxH(15),
          Text(
            stdName,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
          ),
          buildSizedBoxH(3),
          Text(
            "Gr No. :- $grId",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
          ),
        ],
      ),
    );
  }

  // Options List
  Widget buildOtherOptions() {
    List<OptionItem> options = [
      OptionItem(
        icon: Assets.image.icon.icProfile.path,
        title: Lang.current.profile,
        onTap: () {
          // NavigatorService.pushNamed(AppRoutes.rnwprofilescreen);
        },
      ),
      OptionItem(
        icon: Assets.image.icon.icSettings.path,
        title: Lang.current.lbl_settings,
        onTap: () {
          _buildNotificationSetting();
        },
      ),
      OptionItem(
        icon: Assets.image.icon.icSigningSheet.path,
        title: Lang.current.lbl_terms_and_condition,
        onTap: () {
          NavigatorService.pushNamed(AppRoutes.rnwtermsandconditionscreen);
        },
      ),
      OptionItem(
        icon: Assets.image.icon.icContactUs.path,
        title: Lang.current.lbl_contact_us,
        onTap: () {
          NavigatorService.pushNamed(AppRoutes.rnwcontactusscreen);
        },
      ),
      OptionItem(
        icon: Assets.image.icon.icRateUs.path,
        title: Lang.current.lbl_rate_us,
        onTap: () async {
          final packageInfo = (await PackageInfo.fromPlatform()).packageName;
          String storeUrl = Platform.isIOS
              ? 'https://apps.apple.com/us/app/rnw-student-app/id6449534062'
              : 'https://play.google.com/store/apps/details?id=$packageInfo';
          await launch(storeUrl);
        },
      ),
      OptionItem(
        icon: Assets.image.icon.icSignOut.path,
        title: Lang.current.lbl_sign_out,
        onTap: () {
          buildSignOutDialog();
        },
      ),
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: options.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: options[index].onTap,
          child: Container(
            height: 50.h,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            color: isSelected == index
                ? AppColors.primaryColor
                : Colors.transparent,
            child: Row(
              children: [
                CustomImageView(
                  imagePath: options[index].icon,
                  height: 25.h,
                  width: 25.w,
                  color: isSelected != index ? Colors.black54 : Colors.white,
                ),
                const SizedBox(width: 10),
                Text(
                  options[index].title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 15.sp,
                        color:
                            isSelected != index ? Colors.black54 : Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _buildNotificationSetting() {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              child: Container(
                  height: 320.h,
                  padding:
                      EdgeInsets.symmetric(horizontal: 9.w, vertical: 10.h),
                  decoration: BoxDecoration(
                      color: AppColors.whitecolor,
                      borderRadius: BorderRadius.circular(26.r)),
                  child: Column(children: [
                    buildSizedBoxH(20),
                    Image.asset(Assets.image.png.pngPushNotification.path,
                        scale: 2.5.sp),
                    buildSizedBoxH(12),
                    Text(Lang.current.lbl_notification_setting,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 15.sp)),
                    buildSizedBoxH(10),
                    Text(
                        textAlign: TextAlign.center,
                        Lang.current.lbl_setting_of_the_notification,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
  }

  // Sign-Out Dialog
  void buildSignOutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomImageView(
                  imagePath: Assets.image.png.pngAlert.path,
                  height: 50.h,
                  width: 50.w,
                  color: AppColors.primaryColor,
                ),
                buildSizedBoxH(10),
                Text(
                  Lang.current.lbl_please_confirm,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                buildSizedBoxH(10),
                Text(
                  Lang.current.lbl_are_sure_log_out,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600, color: Colors.black45),
                ),
                buildSizedBoxH(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildDialogButton(Lang.current.lbl_cancle, Colors.white,
                        AppColors.primaryColor, () {
                      NavigatorService.goBack();
                    }),
                    buildDialogButton(Lang.current.lbl_sign_out,
                        AppColors.primaryColor, Colors.white, () {
                      PrefObj.preferences?.clear();
                      NavigatorService.pushAndRemoveUntil(AppRoutes.loginScreen,
                          routePredicate: (route) => false);
                    }),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildDialogButton(
      String text, Color bgColor, Color textColor, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 45.h,
        width: 100.w,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20.sp),
          boxShadow: [BoxShadow(blurRadius: 1, color: AppColors.primaryColor)],
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.w800, color: textColor),
          ),
        ),
      ),
    );
  }
}

class OptionItem {
  final String icon;
  final String title;
  final VoidCallback onTap;

  OptionItem({required this.icon, required this.title, required this.onTap});
}
