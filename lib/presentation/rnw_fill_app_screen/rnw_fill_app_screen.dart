import 'package:rnw_institue/utils/app_export.dart';
import 'package:rnw_institue/utils/mixin.dart';

class RNWFillApp extends StatefulWidget {
  const RNWFillApp({super.key});

  @override
  State<RNWFillApp> createState() => _RNWFillAppState();
}

class _RNWFillAppState extends State<RNWFillApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //App Bar
        appBar: RNWAppBar(title: Text(Lang.current.lbl_redwhitemultimedia), action: [
          Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: GestureDetector(
                onTap: () {
                  NavigatorService.pushNamed(AppRoutes.rnwnotificationslist);
                },
                child: notificationIcon(),
              ))
        ]),
        body: BackgroundImage(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
            CustomImageView(
              imagePath: Assets.image.svg.svgComingSoon.path,
              height: 300.h,
            ),
            Center(child: Text('Coming Soon...', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 15.sp, color: AppColors.textColor)))
          ]),
        ));
  }
}
