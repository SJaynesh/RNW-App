class StudentAttendanceModel {
  Data? data;
  String? message;

  StudentAttendanceModel({this.data, this.message});

  StudentAttendanceModel.fromJson(Map<String, dynamic> json) {
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
  List<Rows>? rows;
  int? present;
  int? absent;
  int? leave;
  int? totalCount;

  Data({this.rows, this.present, this.absent, this.leave, this.totalCount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['rows'] != null) {
      rows = <Rows>[];
      json['rows'].forEach((v) {
        rows!.add(Rows.fromJson(v));
      });
    }
    present = json['present'];
    absent = json['absent'];
    leave = json['leave'];
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (rows != null) {
      data['rows'] = rows!.map((v) => v.toJson()).toList();
    }
    data['present'] = present;
    data['absent'] = absent;
    data['leave'] = leave;
    data['totalCount'] = totalCount;
    return data;
  }
}

class Rows {
  String? date;
  List<Attendance>? attendance;

  Rows({this.date, this.attendance});

  Rows.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['attendance'] != null) {
      attendance = <Attendance>[];
      json['attendance'].forEach((v) {
        attendance!.add(Attendance.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    if (attendance != null) {
      data['attendance'] = attendance!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attendance {
  bool? present;
  bool? absent;
  bool? leave;

  Attendance({this.present, this.absent, this.leave});

  Attendance.fromJson(Map<String, dynamic> json) {
    present = json['present'];
    absent = json['absent'];
    leave = json['leave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['present'] = present;
    data['absent'] = absent;
    data['leave'] = leave;
    return data;
  }
}
