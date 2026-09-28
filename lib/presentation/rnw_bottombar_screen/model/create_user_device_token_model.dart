class CreateUserDeviceTokenModel {
  Data? data;
  String? message;

  CreateUserDeviceTokenModel({this.data, this.message});

  CreateUserDeviceTokenModel.fromJson(Map<String, dynamic> json) {
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
  String? type;
  String? token;
  String? createdBy;
  String? createdDate;
  String? updatedBy;
  String? updatedDate;
  int? id;

  Data(
      {this.mobileNo,
      this.type,
      this.token,
      this.createdBy,
      this.createdDate,
      this.updatedBy,
      this.updatedDate,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    mobileNo = json['mobile_no'];
    type = json['type'];
    token = json['token'];
    createdBy = json['created_by'].toString();
    createdDate = json['created_date'].toString();
    updatedBy = json['updated_by'].toString();
    updatedDate = json['updated_date'].toString();
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mobile_no'] = mobileNo;
    data['type'] = type;
    data['token'] = token;
    data['created_by'] = createdBy;
    data['created_date'] = createdDate;
    data['updated_by'] = updatedBy;
    data['updated_date'] = updatedDate;
    data['id'] = id;
    return data;
  }
}
