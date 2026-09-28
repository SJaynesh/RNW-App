import 'package:rnw_institue/utils/app_export.dart';

// Custom text field widget for flexible input with various configuration options
// ignore: must_be_immutable
class RnwCustomTextFormField extends StatelessWidget {
  RnwCustomTextFormField(
      {super.key,
      required this.context, // Build context for accessing theme and other properties
      this.validator, // Custom validation function
      this.width, // Optional width of the text field
      this.alignment, // Alignment for the text field
      this.textStyle, // Custom text style for the text input
      this.isObscure = false, // Obscure text for password fields
      this.isCapitalized = false, // Capitalize input text
      this.maxLines = 1, // Number of lines for the text field (default is 1)
      this.isLabelEnabled = true, // Toggle to always show the label
      this.readOnly = false, // Make text field read-only if true
      this.controller, // Controller to manage text input
      this.inputAction, // Text input action (e.g., next, done)
      this.focusNode, // Focus node to handle input focus
      this.label, // Label for the text field
      this.hint = "", // Hint text displayed inside the text field
      this.onTap, // Action to perform on tap
      this.prefix, // Optional prefix widget
      this.maxLength, // Max character limit for the input
      this.suffixIcon, // Suffix icon for additional actions or indicators
      this.autofillHints, // Autofill hints for text inputs like email, name, etc.
      this.inputFormatters, // Input formatters for controlling text format (e.g., number only)
      this.prefixIcon, // Icon that appears at the beginning of the text field
      this.onFieldSubmitted, // Action on submitting the field (e.g., pressing done)
      this.onChanged, // Action to handle changes in text input
      this.textInputAction, // Defines the action button on the keyboard
      this.textInputType, // Input type for the keyboard (e.g., number, text)
      this.hintStyle, // Style for the hint text
      this.hintText, // Custom hint text
      this.obscureText = false, // Toggles obscuring text (for passwords)
      this.suffix, // Widget for displaying suffix content
      this.fillColor, // Background color of the text field
      this.filled = false, // Whether the text field should have a background color
      this.borderDecoration, // Custom decoration for the border
      this.enabled = true, // Whether the text field is enabled or not
      this.labelText, // Label text to display outside the field
      this.required = false, // Whether the field is required
      this.autovalidateMode, // Autovalidation mode (e.g., always, disabled)
      this.onSaved, // Action to perform when saving the form
      this.lableStyle, // Custom style for the label text
      this.initialValue, // Initial value for the text field
      this.contentPadding, // Padding inside the text field
      this.height}); // Optional height of the text field

  TextEditingController? controller; // Controller to manage the text input
  final BuildContext context; // Build context for theme, colors, etc.
  final Alignment? alignment; // Alignment of the text field widget
  final double? width; // Width of the text field
  final double? height; // Height of the text field
  final TextInputAction? inputAction; // Action on the keyboard (next, done)
  final String? label; // Label text for the field
  final String hint; // Hint text for the field
  final bool isObscure; // Flag to hide or show the text (password fields)
  final bool isCapitalized; // Flag to capitalize the input text
  final TextStyle? textStyle; // Custom style for the input text
  final int maxLines; // Maximum number of lines in the text field
  final int? maxLength; // Maximum number of characters allowed
  final ValueChanged<String>? onChanged; // Callback for text change
  final bool obscureText; // Obscures the text for security (password fields)
  final bool isLabelEnabled; // Flag to enable label display
  final String? Function(String?)? validator; // Custom validator for the input
  final Function(String)? onFieldSubmitted; // Callback for form submission
  final bool readOnly; // Flag to make the field read-only
  final Widget? suffixIcon; // Widget for suffix icon
  final String? hintText; // Hint text for the input field
  final TextStyle? lableStyle; // Custom style for the label
  final TextStyle? hintStyle; // Custom style for the hint text
  final Widget? prefix; // Prefix widget to display before the text field
  final Widget? prefixIcon; // Prefix icon
  final void Function()? onTap; // Function triggered on tap
  final Iterable<String>? autofillHints; // Autofill suggestions (e.g., email)
  final FocusNode? focusNode; // Focus node for managing input focus
  final List<TextInputFormatter>? inputFormatters; // Formatters to control input format
  final TextInputAction? textInputAction; // Action triggered by the keyboard
  final TextInputType? textInputType; // Type of keyboard to display
  final Widget? suffix; // Widget to display after the text field
  final Color? fillColor; // Background color of the text field
  final bool? filled; // Flag to toggle background fill color
  final InputBorder? borderDecoration; // Custom decoration for the border
  final bool? enabled; // Whether the field is enabled or disabled
  final String? labelText; // Label text
  final bool? required; // Whether the field is required
  final AutovalidateMode? autovalidateMode; // Autovalidation mode for form
  final String? initialValue; // Initial value for the field
  final void Function(String?)? onSaved; // Callback when the field is saved
  final EdgeInsetsGeometry? contentPadding; // Padding inside the field

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center, // Align the text field if alignment is provided
            child: textFormFieldWidget, // Build the text form field widget
          )
        : textFormFieldWidget; // Otherwise, return the text field as is
  }

  // Main text form field widget with all properties applied
  Widget get textFormFieldWidget => SizedBox(
        width: width ?? double.maxFinite, // Set the width or default to full width
        child: TextFormField(
          enabled: enabled, // Whether the field is enabled
          onSaved: onSaved, // On saved callback
          initialValue: initialValue, // Initial value if provided
          onChanged: onChanged, // Callback for text changes
          obscureText: obscureText, // Obscure text if needed
          inputFormatters: inputFormatters, // Formatters for input restriction
          autofillHints: autofillHints, // Autofill hints for user data
          onTap: onTap, // On tap callback
          maxLines: maxLines, // Number of lines for the input
          maxLength: maxLength, // Maximum character length
          onFieldSubmitted: onFieldSubmitted, // Callback on field submission
          focusNode: focusNode, // Focus node for managing focus
          controller: controller, // Text editing controller
          readOnly: readOnly, // Read-only property
          style: textStyle ?? // Text style
              Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.textColor, fontSize: 15.sp),
          textCapitalization: isCapitalized
              ? TextCapitalization.words // Capitalize text if enabled
              : TextCapitalization.none,
          textInputAction: textInputAction, // Input action (next, done, etc.)
          keyboardType: textInputType ?? TextInputType.text, // Keyboard type
          decoration: decoration, // Decoration for the field
          validator: validator, // Validation function
          enableSuggestions: true, // Enable suggestions
          cursorOpacityAnimates: true, // Animate cursor opacity
          autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled, // Autovalidation mode
        ),
      );

  // Decoration for the text field
  InputDecoration get decoration => InputDecoration(
        label: Text(labelText ?? ''), // Label text
        labelStyle: lableStyle ?? Theme.of(context).textTheme.bodySmall, // Label style
        alignLabelWithHint: true, // Align label with the hint
        hintText: hintText ?? "", // Hint text
        hintStyle: hintStyle ??
            Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.textColor, fontSize: 15.sp), // Hint style
        prefixIcon: prefix, // Prefix widget
        suffixIcon: suffix, // Suffix widget
        floatingLabelBehavior: isLabelEnabled
            ? FloatingLabelBehavior.always // Always show label if enabled
            : FloatingLabelBehavior.never, // Never show label if disabled
        isDense: true, // Compact the text field appearance
        contentPadding: contentPadding ??
            EdgeInsets.only(
                left: 24.0.w, top: 14.h, right: 12.w, bottom: 14.h), // Padding inside the field
        filled: filled, // Fill color toggle
        fillColor: fillColor ?? AppColors.textColor.withOpacity(0.08), // Background fill color
        border: borderDecoration ??
            OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: AppColors.borderColor,
                  width: 1,
                )), // Default border decoration
        focusedBorder: borderDecoration ??
            OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: AppColors.borderColor,
                  width: 1,
                )), // Border when focused
      );
}
