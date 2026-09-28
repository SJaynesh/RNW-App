import 'package:rnw_institue/utils/app_export.dart';

class CongratulationsCertificateScreen extends StatefulWidget {
  const CongratulationsCertificateScreen({super.key});

  @override
  State<CongratulationsCertificateScreen> createState() =>
      _CongratulationsCertificateScreenState();
}

class _CongratulationsCertificateScreenState
    extends State<CongratulationsCertificateScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [buildCongratulation()],
        ),
      ),
    );
  }

  Widget buildCongratulation() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            height: 185.h,
            width: 185.w,
            imagePath: Assets.image.png.pngCertificate2.path,
          ),
          Text(Lang.current.lbl_congratulations,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold)),
          Text(Lang.current.lbl_you_have_complated,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: AppColors.grayColors, fontSize: 15.sp))
        ]);
  }
}
