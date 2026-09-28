class VerifyOTPModel {
  Data? data;
  String? message;

  VerifyOTPModel({this.data, this.message});

  VerifyOTPModel.fromJson(Map<String, dynamic> json) {
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
  String? mobileNo;
  String? deviceToken;
  String? type;
  String? auth;
  String? createdDate;
  int? id;
  String? token;

  Data(
      {this.mobileNo,
      this.deviceToken,
      this.type,
      this.auth,
      this.createdDate,
      this.id,
      this.token});

  Data.fromJson(Map<String, dynamic> json) {
    mobileNo = json['mobile_no'];
    deviceToken = json['device_token'];
    type = json['type'];
    auth = json['auth'];
    createdDate = json['created_date'];
    id = json['id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mobile_no'] = mobileNo;
    data['device_token'] = deviceToken;
    data['type'] = type;
    data['auth'] = auth;
    data['created_date'] = createdDate;
    data['id'] = id;
    data['token'] = token;
    return data;
  }
}
