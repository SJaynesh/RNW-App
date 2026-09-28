import 'package:rnw_institue/utils/app_export.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RnWConcactUsScreen extends StatefulWidget {
  const RnWConcactUsScreen({super.key});
  static Widget builder(BuildContext context) {
    return const RnWConcactUsScreen();
  }

  @override
  State<RnWConcactUsScreen> createState() => _RnWConcactUsScreenState();
}

class _RnWConcactUsScreenState extends State<RnWConcactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: RNWAppBar(
            title: Text(Lang.current.lbl_contact_us,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600, color: AppColors.whitecolor)),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  NavigatorService.goBack();
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: AppColors.whitecolor))),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 25.0.h),
                child: Container(
                    padding: EdgeInsets.all(8.0.w),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.black26.withOpacity(0.2)),
                      color: AppColors.whitecolor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(children: [
                      _buildcontactusicon(),
                      buildSizedboxW(8),
                      _buildcontactusText()
                    ])),
              )
            ],
          ),
        ));
  }

  Widget _buildcontactusicon() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.grayBoxColor,
            borderRadius: BorderRadius.circular(8.0.r)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: CustomImageView(
            imagePath: Assets.image.svg.svgContactUs.path,
            height: 30.h,
          ),
        ),
      ),
    );
  }

  Widget _buildcontactusText() {
    return Text(Lang.current.lbl_contact_info,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 15.sp,
            color: AppColors.graytextColor));
  }
}
