class StudentwiseattendenceModel {
  List<studentwiseattendenceData>? data;
  String? message;

  StudentwiseattendenceModel({this.data, this.message});

  StudentwiseattendenceModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null && json['data'] is List) {
      data = <studentwiseattendenceData>[];
      json['data'].forEach((v) {
        data!.add(studentwiseattendenceData.fromJson(v));
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

class studentwiseattendenceData {
  String? date;
  List<String>? punches;

  studentwiseattendenceData({this.date, this.punches});

  studentwiseattendenceData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    punches = json['punches'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['punches'] = punches;
    return data;
  }
}
