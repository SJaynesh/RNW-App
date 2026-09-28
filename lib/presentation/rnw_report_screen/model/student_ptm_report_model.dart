class StudentPtmReportModel {
  List<DataListModel>? data;
  String? message;

  StudentPtmReportModel({this.data, this.message});

  StudentPtmReportModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataListModel>[];
      json['data'].forEach((v) {
        data!.add(DataListModel.fromJson(v));
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

class DataListModel {
  int? id;
  StudentInfo? studentInfo;
  BehaviorRatings? behaviorRatings;
  Attendance? attendance;
  CourseDetails? courseDetails;
  List<Performance>? performance;
  String? remarks;
  ParentInfo? parentInfo;
  List<StatsData>? statsData;

  DataListModel(
      {this.id,
      this.studentInfo,
      this.behaviorRatings,
      this.attendance,
      this.courseDetails,
      this.performance,
      this.remarks,
      this.parentInfo,
      this.statsData});

  DataListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentInfo = json['student_info'] != null ? StudentInfo.fromJson(json['student_info']) : null;
    behaviorRatings = json['behavior_ratings'] != null ? BehaviorRatings.fromJson(json['behavior_ratings']) : null;
    attendance = json['attendance'] != null ? Attendance.fromJson(json['attendance']) : null;
    courseDetails = json['course_details'] != null ? CourseDetails.fromJson(json['course_details']) : null;
    if (json['performance'] != null) {
      performance = <Performance>[];
      json['performance'].forEach((v) {
        performance!.add(Performance.fromJson(v));
      });
    }
    remarks = json['remarks'];
    parentInfo = json['parent_info'] != null ? ParentInfo.fromJson(json['parent_info']) : null;
    if (json['stats_data'] != null) {
      statsData = <StatsData>[];
      json['stats_data'].forEach((v) {
        statsData!.add(StatsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (studentInfo != null) {
      data['student_info'] = studentInfo!.toJson();
    }
    if (behaviorRatings != null) {
      data['behavior_ratings'] = behaviorRatings!.toJson();
    }
    if (attendance != null) {
      data['attendance'] = attendance!.toJson();
    }
    if (courseDetails != null) {
      data['course_details'] = courseDetails!.toJson();
    }
    if (performance != null) {
      data['performance'] = performance!.map((v) => v.toJson()).toList();
    }
    data['remarks'] = remarks;
    if (parentInfo != null) {
      data['parent_info'] = parentInfo!.toJson();
    }
    if (statsData != null) {
      data['stats_data'] = statsData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StudentInfo {
  String? name;
  int? grId;
  String? faculty;
  String? batchTime;
  String? course;
  String? parentNo;
  String? uniform;
  String? discipline;

  StudentInfo(
      {this.name, this.grId, this.faculty, this.batchTime, this.course, this.parentNo, this.uniform, this.discipline});

  StudentInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    grId = json['gr_id'];
    faculty = json['faculty'];
    batchTime = json['batch_time'];
    course = json['course'];
    parentNo = json['parent_no'];
    uniform = json['uniform'];
    discipline = json['discipline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['gr_id'] = grId;
    data['faculty'] = faculty;
    data['batch_time'] = batchTime;
    data['course'] = course;
    data['parent_no'] = parentNo;
    data['uniform'] = uniform;
    data['discipline'] = discipline;
    return data;
  }
}

class BehaviorRatings {
  String? behaviorWithFaculty;
  String? behaviorWithOtherTeam;
  String? behaviorWithOtherStudent;

  BehaviorRatings({this.behaviorWithFaculty, this.behaviorWithOtherTeam, this.behaviorWithOtherStudent});

  BehaviorRatings.fromJson(Map<String, dynamic> json) {
    behaviorWithFaculty = json['behavior_with_faculty'];
    behaviorWithOtherTeam = json['behavior_with_other_team'];
    behaviorWithOtherStudent = json['behavior_with_other_student'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['behavior_with_faculty'] = behaviorWithFaculty;
    data['behavior_with_other_team'] = behaviorWithOtherTeam;
    data['behavior_with_other_student'] = behaviorWithOtherStudent;
    return data;
  }
}

class Attendance {
  int? totalDays;
  int? presentDays;
  String? performance;

  Attendance({this.totalDays, this.presentDays, this.performance});

  Attendance.fromJson(Map<String, dynamic> json) {
    totalDays = json['total_days'];
    presentDays = json['present_days'];
    performance = json['performance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_days'] = totalDays;
    data['present_days'] = presentDays;
    data['performance'] = performance;
    return data;
  }
}

class CourseDetails {
  List<String>? completedCourses;
  List<String>? runningSoftware;

  CourseDetails({this.completedCourses, this.runningSoftware});

  CourseDetails.fromJson(Map<String, dynamic> json) {
    completedCourses = json['completed_courses'].cast<String>();
    runningSoftware = json['running_software'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['completed_courses'] = completedCourses;
    data['running_software'] = runningSoftware;
    return data;
  }
}

class Performance {
  String? subjects;
  int? workingDays;
  int? presentDays;
  String? performance;

  Performance({this.subjects, this.workingDays, this.presentDays, this.performance});

  Performance.fromJson(Map<String, dynamic> json) {
    subjects = json['subjects'];
    workingDays = json['working_days'];
    presentDays = json['present_days'];
    performance = json['performance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subjects'] = subjects;
    data['working_days'] = workingDays;
    data['present_days'] = presentDays;
    data['performance'] = performance;
    return data;
  }
}

class ParentInfo {
  String? name;
  String? relation;
  String? contactNumber;

  ParentInfo({this.name, this.relation, this.contactNumber});

  ParentInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    relation = json['relation'];
    contactNumber = json['contact_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['relation'] = relation;
    data['contact_number'] = contactNumber;
    return data;
  }
}

class StatsData {
  String? actualDate;
  int? totalDays;
  int? attendanceDays;
  int? totalMarks;
  int? marks;
  String? overallPercentage;

  StatsData(
      {this.actualDate, this.totalDays, this.attendanceDays, this.totalMarks, this.marks, this.overallPercentage});

  StatsData.fromJson(Map<String, dynamic> json) {
    actualDate = json['actual_date'];
    totalDays = json['total_days'];
    attendanceDays = json['attendance_days'];
    totalMarks = json['total_marks'];
    marks = json['marks'];
    overallPercentage = json['overall_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['actual_date'] = actualDate;
    data['total_days'] = totalDays;
    data['attendance_days'] = attendanceDays;
    data['total_marks'] = totalMarks;
    data['marks'] = marks;
    data['overall_percentage'] = overallPercentage;
    return data;
  }
}
