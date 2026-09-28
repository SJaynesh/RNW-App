import 'dart:developer';

import 'package:rnw_institue/utils/app_export.dart';

class Logger {
  static LogMode _logMode = LogMode.debug;

  static void init(LogMode mode) {
    Logger._logMode = mode;
  }

  static void lOG(dynamic data, {StackTrace? stackTrace}) {
    if (_logMode == LogMode.debug) {
      if (stackTrace == null) {
        log("$data");
      } else {
        log("$data$stackTrace");
      }
    }
  }
}

void showToast(String message, {Color? backgroundColor}) {
  rootScaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      content: Text(message,
          style: GoogleFonts.lato(
              fontSize: 14.sp,
              color: AppColors.whitecolor,
              fontWeight: FontWeight.w400)),
      backgroundColor: backgroundColor ?? AppColors.primaryColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.r)))));
}

enum LogMode { debug, live }
