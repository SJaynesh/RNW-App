class FormValidators {
//========================== Phone validation ==========================================//
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    final RegExp phoneExp = RegExp(r'^\d{10}$');
    if (!phoneExp.hasMatch(value)) {
      return 'Enter a valid 10-digit phone number';
    }
    return null;
  }

//========================== OTP validation ==========================================//
  static String? validateOTP(String? value) {
    if (value == null || value.isEmpty) {
      return 'OTP is required';
    }
    final RegExp otpExp = RegExp(r'^\d{6}$');
    if (!otpExp.hasMatch(value)) {
      return 'Enter a valid 6-digit OTP';
    }
    return null;
  }

//========================== MPIN validation ==========================================//
  static String? validateMPIN(String? value) {
    if (value == null || value.isEmpty) {
      return 'MPIN is required';
    }
    final RegExp mpinExp = RegExp(r'^\d{6}$');
    if (!mpinExp.hasMatch(value)) {
      return 'Enter a valid 6-digit MPIN';
    }
    return null;
  }

  //========================== Feedback validation ==========================================//
  static String? validateFeedback(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter remark';
    }
    return null;
  }
}
