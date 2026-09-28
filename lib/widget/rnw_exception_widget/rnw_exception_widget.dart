import 'package:rnw_institue/utils/app_export.dart';

class RnwxceptionWidget extends StatefulWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final bool showButton;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final bool showGif;
  final String? gifPath;

  const RnwxceptionWidget({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    this.showButton = true,
    this.buttonText,
    this.onButtonPressed,
    this.showGif = false,
    this.gifPath,
    super.key,
  });

  @override
  State<RnwxceptionWidget> createState() => _RnwxceptionWidgetState();
}

class _RnwxceptionWidgetState extends State<RnwxceptionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleButtonPress() {
    setState(() {
      _isLoading = true;
    });
    _controller.forward().then((_) {
      if (widget.onButtonPressed != null) {
        widget.onButtonPressed!();
      }
      // Simulate a delay to hide the progress indicator (e.g., after API call completes)
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        _controller.reverse();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageView(
              imagePath: widget.imagePath,
              height: 231.h,
              alignment: Alignment.center,
              fit: BoxFit.cover,
            ),
            buildSizedBoxH(60),
            Text(
              widget.title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w800, fontSize: 16.0.sp),
              textAlign: TextAlign.center,
            ),
            buildSizedBoxH(16),
            Text(
              widget.subtitle,
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
            if (widget.showButton) buildSizedBoxH(70),
            if (widget.showButton)
              RnWCustomButton(
                onPressed: _handleButtonPress,
                text: widget.buttonText ?? Lang.of(context).lbl_try_again,
                isLoading: _isLoading,
              ),
            if (widget.showGif)
              CustomImageView(
                width: double.infinity,
                imagePath: widget.gifPath,
                alignment: Alignment.center,
                fit: BoxFit.cover,
              ),
          ],
        ),
      ),
    );
  }
}
