import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rnw_institue/utils/app_export.dart';

class RnwLoader extends StatelessWidget {
  final Color? color;
  final double? size;
  const RnwLoader({super.key, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return SpinKitCircle(color: color ?? AppColors.whitecolor, size: 20.sp);
  }
}
