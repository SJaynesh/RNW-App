class CheckMpinModel {
  Data? data;

  CheckMpinModel({this.data});

  CheckMpinModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  bool? status;
  String? message;
  bool? isMpin;

  Data({this.status, this.message, this.isMpin});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    isMpin = json['is_mpin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['is_mpin'] = isMpin;
    return data;
  }
}
