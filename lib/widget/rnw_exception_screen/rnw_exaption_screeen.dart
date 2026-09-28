import 'package:rnw_institue/utils/app_export.dart';

class RnwExceptionScreen extends StatefulWidget {
  const RnwExceptionScreen({super.key});

  @override
  State<RnwExceptionScreen> createState() => _RnwExceptionScreenState();
}

class _RnwExceptionScreenState extends State<RnwExceptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          CustomImageView(imagePath: Assets.image.svg.svgException.path, height: 300.h, width: 300.w),
          Text(Lang.current.msg_data_not_found, style: Theme.of(context).textTheme.bodyLarge)
        ]));
  }
}
