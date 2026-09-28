import 'package:rnw_institue/utils/app_export.dart';
import 'package:rnw_institue/widget/rnw_app_button/base_button.dart';

class RnWCustomButton extends BaseButton {
  const RnWCustomButton({
    super.key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    super.margin,
    super.onPressed,
    super.buttonStyle,
    super.alignment,
    super.buttonTextStyle,
    super.isDisabled,
    super.height,
    super.width,
    this.rightIconwidth,
    this.leftIconwidth,
    this.isLoading = false,
    this.isoutline = false,
    required super.text,
  });

  final BoxDecoration? decoration;

  final Widget? leftIcon;

  final Widget? rightIcon;

  final Widget? rightIconwidth;

  final Widget? leftIconwidth;

  final bool isLoading;

  final bool isoutline;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50.h,
      width: width ?? MediaQuery.of(context).size.width * 0.5,
      margin: margin,
      decoration: decoration,
      child: ElevatedButton(
        style: isoutline
            ? ButtonStyle(
                overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                backgroundColor:
                    const WidgetStatePropertyAll(AppColors.whitecolor),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.r),
                    side: const BorderSide(
                        color: AppColors.btnColor, width: 1.0))))
            : ButtonStyle(
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.r)))),
        onPressed: isDisabled ?? false ? null : onPressed ?? () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leftIcon ?? const SizedBox.shrink(),
            leftIconwidth ?? const SizedBox.shrink(),
            isLoading
                ? Center(
                    child: RnwLoader(
                    color: isoutline
                        ? AppColors.primaryColor
                        : AppColors.whitecolor,
                  ))
                : Text(
                    text,
                    style: buttonTextStyle ??
                        Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: isoutline
                                ? AppColors.primaryColor
                                : AppColors.whitecolor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                  ),
            rightIconwidth ?? const SizedBox.shrink(),
            rightIcon ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
