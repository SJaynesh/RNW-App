class BannersModel {
  List<Data>? data;
  String? message;

  BannersModel({this.data, this.message});

  BannersModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  int? id;
  String? frontBanner;
  String? createdBy;
  String? createdDate;
  String? updatedBy;
  String? updatedDate;

  Data(
      {this.id,
      this.frontBanner,
      this.createdBy,
      this.createdDate,
      this.updatedBy,
      this.updatedDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    frontBanner = json['front_banner'];
    createdBy = json['created_by'];
    createdDate = json['created_date'];
    updatedBy = json['updated_by'];
    updatedDate = json['updated_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['front_banner'] = frontBanner;
    data['created_by'] = createdBy;
    data['created_date'] = createdDate;
    data['updated_by'] = updatedBy;
    data['updated_date'] = updatedDate;
    return data;
  }
}
