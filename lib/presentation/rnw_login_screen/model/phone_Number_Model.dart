class PhoneNumberModel {
  Data? data;
  String? message;

  PhoneNumberModel({this.data, this.message});

  PhoneNumberModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  String? otp;

  Data({this.otp});

  Data.fromJson(Map<String, dynamic> json) {
    otp = json['OTP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OTP'] = otp;
    return data;
  }
}
