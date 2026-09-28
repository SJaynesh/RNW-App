class CourseModel {
  List<Data>? data;
  String? message;

  CourseModel({this.data, this.message});

  CourseModel.fromJson(Map<String, dynamic> json) {
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
  int? courseConfigId;
  int? departmentId;
  int? subdepartmentId;
  String? name;
  String? code;
  bool? careerCourse;
  int? total;
  String? duration;
  int? installment;
  bool? status;
  String? createdBy;
  String? createdDate;
  String? updatedBy;
  String? updatedDate;
  String? banner;
  String? eligibility;
  String? brochureLink;
  String? description;
  bool? upskillCourse;
  List<AdmissionSubcourses>? admissionSubcourses;

  Data(
      {this.id,
      this.courseConfigId,
      this.departmentId,
      this.subdepartmentId,
      this.name,
      this.code,
      this.careerCourse,
      this.total,
      this.duration,
      this.installment,
      this.status,
      this.createdBy,
      this.createdDate,
      this.updatedBy,
      this.updatedDate,
      this.banner,
      this.eligibility,
      this.brochureLink,
      this.description,
      this.upskillCourse,
      this.admissionSubcourses});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseConfigId = json['course_config_id'];
    departmentId = json['department_id'];
    subdepartmentId = json['subdepartment_id'];
    name = json['name'];
    code = json['code'];
    careerCourse = json['career_course'];
    total = json['total'];
    duration = json['duration'];
    installment = json['installment'];
    status = json['status'];
    createdBy = json['created_by'];
    createdDate = json['created_date'];
    updatedBy = json['updated_by'];
    updatedDate = json['updated_date'];
    banner = json['banner'];
    eligibility = json['eligibility'];
    brochureLink = json['brochure_link'];
    description = json['description'];
    upskillCourse = json['upskill_course'];
    if (json['admission_subcourses'] != null) {
      admissionSubcourses = <AdmissionSubcourses>[];
      json['admission_subcourses'].forEach((v) {
        admissionSubcourses!.add(AdmissionSubcourses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['course_config_id'] = courseConfigId;
    data['department_id'] = departmentId;
    data['subdepartment_id'] = subdepartmentId;
    data['name'] = name;
    data['code'] = code;
    data['career_course'] = careerCourse;
    data['total'] = total;
    data['duration'] = duration;
    data['installment'] = installment;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['created_date'] = createdDate;
    data['updated_by'] = updatedBy;
    data['updated_date'] = updatedDate;
    data['banner'] = banner;
    data['eligibility'] = eligibility;
    data['brochure_link'] = brochureLink;
    data['description'] = description;
    data['upskill_course'] = upskillCourse;
    if (admissionSubcourses != null) {
      data['admission_subcourses'] =
          admissionSubcourses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdmissionSubcourses {
  int? id;
  int? admissionId;
  int? batchId;
  int? courseId;
  int? packageId;
  int? subcourseId;
  int? userId;
  String? courseCategory;
  String? subcourseStatus;
  String? assignedDate;
  String? completedDate;
  String? createdBy;
  String? createdDate;
  String? updatedBy;
  String? updatedDate;
  String? grade;
  String? subcoursePerformance;
  String? subcourseRatio;
  String? obtainMarks;
  String? totalMarks;
  Subcourse? subcourse;
  Batch? batch;

  AdmissionSubcourses(
      {this.id,
      this.admissionId,
      this.batchId,
      this.courseId,
      this.packageId,
      this.subcourseId,
      this.userId,
      this.courseCategory,
      this.subcourseStatus,
      this.assignedDate,
      this.completedDate,
      this.createdBy,
      this.createdDate,
      this.updatedBy,
      this.updatedDate,
      this.grade,
      this.subcoursePerformance,
      this.subcourseRatio,
      this.obtainMarks,
      this.totalMarks,
      this.subcourse,
      this.batch});

  AdmissionSubcourses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    admissionId = json['admission_id'];
    batchId = json['batch_id'];
    courseId = json['course_id'];
    packageId = json['package_id'];
    subcourseId = json['subcourse_id'];
    userId = json['user_id'];
    courseCategory = json['course_category'];
    subcourseStatus = json['subcourse_status'];
    assignedDate = json['assigned_date'];
    completedDate = json['completed_date'];
    createdBy = json['created_by'];
    createdDate = json['created_date'];
    updatedBy = json['updated_by'];
    updatedDate = json['updated_date'];
    grade = json['grade'];
    subcoursePerformance = json['subcourse_performance'];
    subcourseRatio = json['subcourse_ratio'];
    obtainMarks = json['obtain_marks'];
    totalMarks = json['total_marks'];
    subcourse = json['subcourse'] != null
        ? Subcourse.fromJson(json['subcourse'])
        : null;
    batch = json['batch'] != null ? Batch.fromJson(json['batch']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['admission_id'] = admissionId;
    data['batch_id'] = batchId;
    data['course_id'] = courseId;
    data['package_id'] = packageId;
    data['subcourse_id'] = subcourseId;
    data['user_id'] = userId;
    data['course_category'] = courseCategory;
    data['subcourse_status'] = subcourseStatus;
    data['assigned_date'] = assignedDate;
    data['completed_date'] = completedDate;
    data['created_by'] = createdBy;
    data['created_date'] = createdDate;
    data['updated_by'] = updatedBy;
    data['updated_date'] = updatedDate;
    data['grade'] = grade;
    data['subcourse_performance'] = subcoursePerformance;
    data['subcourse_ratio'] = subcourseRatio;
    data['obtain_marks'] = obtainMarks;
    data['total_marks'] = totalMarks;
    if (subcourse != null) {
      data['subcourse'] = subcourse!.toJson();
    }
    if (batch != null) {
      data['batch'] = batch!.toJson();
    }
    return data;
  }
}

class Subcourse {
  int? id;
  int? courseId;
  int? courseConfigId;
  String? name;
  String? code;
  bool? careerCourse;
  int? total;
  String? duration;
  int? installment;
  String? shiningSheet;
  bool? status;
  String? createdBy;
  String? createdDate;
  String? updatedBy;
  String? updatedDate;
  String? banner;
  String? eligibility;
  String? brochureLink;
  String? description;
  bool? upskillCourse;
  int? ePHigh;
  int? ePMedium;
  int? ePLow;

  Subcourse(
      {this.id,
      this.courseId,
      this.courseConfigId,
      this.name,
      this.code,
      this.careerCourse,
      this.total,
      this.duration,
      this.installment,
      this.shiningSheet,
      this.status,
      this.createdBy,
      this.createdDate,
      this.updatedBy,
      this.updatedDate,
      this.banner,
      this.eligibility,
      this.brochureLink,
      this.description,
      this.upskillCourse,
      this.ePHigh,
      this.ePMedium,
      this.ePLow});

  Subcourse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    courseConfigId = json['course_config_id'];
    name = json['name'];
    code = json['code'];
    careerCourse = json['career_course'];
    total = json['total'];
    duration = json['duration'];
    installment = json['installment'];
    shiningSheet = json['shining_sheet'];
    status = json['status'];
    createdBy = json['created_by'];
    createdDate = json['created_date'];
    updatedBy = json['updated_by'];
    updatedDate = json['updated_date'];
    banner = json['banner'];
    eligibility = json['eligibility'];
    brochureLink = json['brochure_link'];
    description = json['description'];
    upskillCourse = json['upskill_course'];
    ePHigh = json['e_p_high'];
    ePMedium = json['e_p_medium'];
    ePLow = json['e_p_low'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['course_id'] = courseId;
    data['course_config_id'] = courseConfigId;
    data['name'] = name;
    data['code'] = code;
    data['career_course'] = careerCourse;
    data['total'] = total;
    data['duration'] = duration;
    data['installment'] = installment;
    data['shining_sheet'] = shiningSheet;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['created_date'] = createdDate;
    data['updated_by'] = updatedBy;
    data['updated_date'] = updatedDate;
    data['banner'] = banner;
    data['eligibility'] = eligibility;
    data['brochure_link'] = brochureLink;
    data['description'] = description;
    data['upskill_course'] = upskillCourse;
    data['e_p_high'] = ePHigh;
    data['e_p_medium'] = ePMedium;
    data['e_p_low'] = ePLow;
    return data;
  }
}

class Batch {
  int? id;
  int? branchId;
  int? courseId;
  int? subcourseId;
  int? userId;
  int? branchInfrastructureId;
  String? code;
  String? name;
  String? duration;
  String? batchesStatus;
  bool? status;
  String? createdBy;
  String? createdDate;
  String? updatedBy;
  String? updatedDate;
  String? startDate;
  String? endDate;
  String? batchTime;
  bool? dayOne;
  bool? dayTwo;
  bool? dayThree;
  bool? dayFour;
  bool? dayFive;
  bool? daySix;
  bool? daySeven;
  int? templateId;
  int? numberOfDays;
  String? examportalBranchId;
  String? completedDate;
  String? actualAcademicDate;

  Batch(
      {this.id,
      this.branchId,
      this.courseId,
      this.subcourseId,
      this.userId,
      this.branchInfrastructureId,
      this.code,
      this.name,
      this.duration,
      this.batchesStatus,
      this.status,
      this.createdBy,
      this.createdDate,
      this.updatedBy,
      this.updatedDate,
      this.startDate,
      this.endDate,
      this.batchTime,
      this.dayOne,
      this.dayTwo,
      this.dayThree,
      this.dayFour,
      this.dayFive,
      this.daySix,
      this.daySeven,
      this.templateId,
      this.numberOfDays,
      this.examportalBranchId,
      this.completedDate,
      this.actualAcademicDate});

  Batch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchId = json['branch_id'];
    courseId = json['course_id'];
    subcourseId = json['subcourse_id'];
    userId = json['user_id'];
    branchInfrastructureId = json['branch_infrastructure_id'];
    code = json['code'];
    name = json['name'];
    duration = json['duration'];
    batchesStatus = json['batches_status'];
    status = json['status'];
    createdBy = json['created_by'];
    createdDate = json['created_date'];
    updatedBy = json['updated_by'];
    updatedDate = json['updatedDate'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    batchTime = json['batch_time'];
    dayOne = json['day_one'];
    dayTwo = json['day_two'];
    dayThree = json['day_three'];
    dayFour = json['day_four'];
    dayFive = json['day_five'];
    daySix = json['day_six'];
    daySeven = json['day_seven'];
    templateId = json['template_id'];
    numberOfDays = json['number_of_days'];
    examportalBranchId = json['examportal_branch_id'];
    completedDate = json['completed_date'];
    actualAcademicDate = json['actual_academic_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['branch_id'] = branchId;
    data['course_id'] = courseId;
    data['subcourse_id'] = subcourseId;
    data['user_id'] = userId;
    data['branch_infrastructure_id'] = branchInfrastructureId;
    data['code'] = code;
    data['name'] = name;
    data['duration'] = duration;
    data['batches_status'] = batchesStatus;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['created_date'] = createdDate;
    data['updated_by'] = updatedBy;
    data['updatedDate'] = updatedDate;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['batch_time'] = batchTime;
    data['day_one'] = dayOne;
    data['day_two'] = dayTwo;
    data['day_three'] = dayThree;
    data['day_four'] = dayFour;
    data['day_five'] = dayFive;
    data['day_six'] = daySix;
    data['day_seven'] = daySeven;
    data['template_id'] = templateId;
    data['number_of_days'] = numberOfDays;
    data['examportal_branch_id'] = examportalBranchId;
    data['completed_date'] = completedDate;
    data['actual_academic_date'] = actualAcademicDate;
    return data;
  }
}
