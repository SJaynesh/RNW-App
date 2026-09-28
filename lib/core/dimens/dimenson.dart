import 'package:rnw_institue/utils/app_export.dart';

/// Creates a `SizedBox` with a responsive height.
/// 
/// The [height] parameter specifies the height of the `SizedBox`. 
/// The height is converted to a responsive value using the `.h` extension,
/// which likely adapts the size based on screen dimensions or device pixel density.
/// 
/// Example:
/// ```dart
/// buildSizedBoxH(20); // Creates a SizedBox with responsive height
/// ```
Widget buildSizedBoxH(double height) {
  return SizedBox(height: height.h);
}

/// Creates a `SizedBox` with a responsive width.
/// 
/// The [width] parameter specifies the width of the `SizedBox`. 
/// The width is converted to a responsive value using the `.w` extension,
/// which likely adapts the size based on screen dimensions or device pixel density.
/// 
/// Example:
/// ```dart
/// buildSizedboxW(15); // Creates a SizedBox with responsive width
/// ```
Widget buildSizedboxW(double width) {
  return SizedBox(width: width.w);
}
