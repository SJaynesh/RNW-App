class StudentPtmReportRecordModel {
  List<RecordData>? data;
  String? message;

  StudentPtmReportRecordModel({this.data, this.message});

  StudentPtmReportRecordModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <RecordData>[];
      json['data'].forEach((v) {
        data!.add(RecordData.fromJson(v));
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

class RecordData {
  int? recuringId;
  String? studentName;
  String? courseName;
  String? facultyName;
  String? studentImage;

  RecordData({this.recuringId, this.studentName, this.courseName, this.facultyName, this.studentImage});

  RecordData.fromJson(Map<String, dynamic> json) {
    recuringId = json['recuringId'];
    studentName = json['studentName'];
    courseName = json['courseName'];
    facultyName = json['faculty_name'];
    studentImage = json['studentImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['recuringId'] = recuringId;
    data['studentName'] = studentName;
    data['courseName'] = courseName;
    data['faculty_name'] = facultyName;
    data['studentImage'] = studentImage;
    return data;
  }
}
