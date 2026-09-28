import 'package:rnw_institue/utils/app_export.dart';

class RnwMaterialButton extends StatelessWidget {
  final String label;
  final double height;
  final double width;
  final double fontSize;
  final Function()? onPressed;

  const RnwMaterialButton({
    super.key,
    required this.label,
    this.height = 40,
    this.width = 150,
    this.fontSize = 16,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      textColor: Colors.white,
      color: AppColors.PRIMERY_COLOR,
      shape: const StadiumBorder(),
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      disabledElevation: 0,
      highlightElevation: 0,
      height: height,
      minWidth: width,
      disabledColor: Colors.grey.shade300,
      splashColor: Colors.white.withOpacity(0.2),
      highlightColor: Colors.white.withOpacity(0.2),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSize,
          letterSpacing: 1,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class RnwDialogButton extends StatelessWidget {
  final String label;
  final Color color;
  final Color backgroundColor;
  final Color borderColor;
  final Function() onPressed;

  const RnwDialogButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = Colors.white,
    this.borderColor = AppColors.PRIMERY_COLOR,
    this.backgroundColor = AppColors.PRIMERY_COLOR,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: const Size(100, 35),
        textStyle: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(letterSpacing: 0.5, fontWeight: FontWeight.bold),
        foregroundColor: color,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: borderColor),
        ),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
