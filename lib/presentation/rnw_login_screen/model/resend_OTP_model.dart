class ReSendModel {
  Data? data;
  String? message;

  ReSendModel({this.data, this.message});

  ReSendModel.fromJson(Map<String, dynamic> json) {
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
  String? oTP;

  Data({this.oTP});

  Data.fromJson(Map<String, dynamic> json) {
    oTP = json['OTP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OTP'] = oTP;
    return data;
  }
}
