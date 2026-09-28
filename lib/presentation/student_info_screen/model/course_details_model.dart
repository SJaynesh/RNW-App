class CourseDetailsModel {
  List<Data>? data;
  String? message;

  CourseDetailsModel({this.data, this.message});

  CourseDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? courseCategory;
  String? subcourseStatus;
  String? subcoursePerformance;
  String? subcourseStudentAttendance;
  CourseType? coursePackage;
  CourseType? subcourse;
  Course? course;
  Course? batch;

  Data(
      {this.courseCategory,
      this.subcourseStatus,
      this.subcoursePerformance,
      this.subcourseStudentAttendance,
      this.coursePackage,
      this.subcourse,
      this.course,
      this.batch});

  Data.fromJson(Map<String, dynamic> json) {
    courseCategory = json['course_category'];
    subcourseStatus = json['subcourse_status'];
    subcoursePerformance = json['subcourse_performance'];
    subcourseStudentAttendance = json['subcourse_student_attendance'];
    coursePackage =
        json['package'] != null ? CourseType.fromJson(json['package']) : null;
    subcourse = json['subcourse'] != null
        ? CourseType.fromJson(json['subcourse'])
        : null;
    course = json['course'] != null ? Course.fromJson(json['course']) : null;
    batch = json['batch'] != null ? Course.fromJson(json['batch']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['course_category'] = courseCategory;
    data['subcourse_status'] = subcourseStatus;
    data['subcourse_performance'] = subcoursePerformance;
    data['subcourse_student_attendance'] = subcourseStudentAttendance;
    if (coursePackage != null) {
      data['package'] = coursePackage!.toJson();
    }
    if (subcourse != null) {
      data['subcourse'] = subcourse!.toJson();
    }
    if (course != null) {
      data['course'] = course!.toJson();
    }
    if (batch != null) {
      data['batch'] = batch!.toJson();
    }
    return data;
  }
}

class CourseType {
  int? id;
  String? name;
  String? createdDate;
  String? updatedDate;

  CourseType({this.id, this.name, this.createdDate, this.updatedDate});

  CourseType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_date'] = createdDate;
    data['updated_date'] = updatedDate;
    return data;
  }
}

class Course {
  String? name;

  Course({this.name});

  Course.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
