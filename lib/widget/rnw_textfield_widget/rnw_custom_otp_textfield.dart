import 'package:rnw_institue/utils/app_export.dart';

class CustomOtpTextField extends StatelessWidget {
  final String? Function(String?)? validator; // Validator for OTP input
  final TextEditingController?
      otpController; // Controller for managing OTP input state
  final void Function(String)?
      onCompleted; // Callback when OTP input is completed

  const CustomOtpTextField({
    super.key,
    required this.validator,
    required this.otpController,
    required this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Pinput(
      showCursor: true, // Show a custom cursor in the OTP field
      cursor: Container(
        height: 20.h,
        width: 3.w,
        color: Colors.red, // Custom red cursor color
      ),
      length: 6, // Length of the OTP (6 digits)
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly
      ], // Restrict input to digits
      preFilledWidget: Text(
        '',
        style: Theme.of(context)
            .textTheme
            .bodyMedium, // Placeholder for empty fields
      ),
      onCompleted: onCompleted, // Triggered when all OTP fields are filled
      controller: otpController, // Manages the input text
      validator: validator, // Input validation
      errorTextStyle: GoogleFonts.montserrat(
          fontSize: 16), // Error text style using Montserrat font
      hapticFeedbackType:
          HapticFeedbackType.lightImpact, // Light haptic feedback on input
      errorText: '', // Default error text
      keyboardType: TextInputType.number, // Sets the keyboard type to numeric
      focusedPinTheme: PinTheme(
        height: 50.h,
        width: 50.w,
        textStyle: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontSize: 16.sp), // Style for focused OTP field text
        decoration: BoxDecoration(
          color: AppColors.whitecolor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
              color: AppColors.whitecolor), // Border styling for focused field
          boxShadow: const [
            BoxShadow(
              color: AppColors.grayBoxColor,
              spreadRadius: 1,
              blurRadius: 1, // Adds a subtle shadow for depth
            )
          ],
        ),
      ),
      defaultPinTheme: PinTheme(
        height: 50.h,
        width: 50.w,
        textStyle: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontSize: 16.sp), // Style for default OTP field text
        decoration: BoxDecoration(
          color: AppColors.whitecolor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
              color: AppColors.whitecolor), // Border styling for default state
          boxShadow: const [
            BoxShadow(
              color: AppColors.grayBoxColor,
              spreadRadius: 1,
              blurRadius: 1, // Subtle shadow for default field
            )
          ],
        ),
      ),
      errorPinTheme: PinTheme(
        height: 50.h,
        width: 50.w,
        textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context)
                .primaryColor), // Style for error state with primary color
        decoration: BoxDecoration(
          color: AppColors.whitecolor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
              color: AppColors.primaryColor), // Border styling for error state
          boxShadow: const [
            BoxShadow(
              color: AppColors.grayBoxColor,
              spreadRadius: 1,
              blurRadius: 1, // Shadow for error field
            )
          ],
        ),
      ),
    );
  }
}
