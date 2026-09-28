class SubmissionLinkModel {
  Data? data;
  String? message;

  SubmissionLinkModel({this.data, this.message});

  SubmissionLinkModel.fromJson(Map<String, dynamic> json) {
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
  int? affected;

  Data({this.affected});

  Data.fromJson(Map<String, dynamic> json) {
    affected = json['affected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['affected'] = affected;
    return data;
  }
}
