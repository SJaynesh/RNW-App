import 'package:rnw_institue/generated/l10n.dart';

class StudentDetailsModel {
  List<StudentData>? data;
  String? message;

  StudentDetailsModel({this.data, this.message});

  StudentDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <StudentData>[];
      json['data'].forEach((v) {
        data!.add(StudentData.fromJson(v));
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

class StudentData {
  String? firstName;
  String? middleName;
  String? branchCode;
  int? branchid;
  String? lastName;
  String? image;
  int? grId;
  dynamic course;
  List<bool>? upskillCourse;
  String? contact;
  String? status;
  String? fees;
  String? discountAmount;
  String? paidAmount;
  String? payableAmount;
  int? admissionId;
  ParentMobileNo? parentMobileNo;
  String? branchName;
  String? facultyName;
  String? hOD;
  String? courseType;
  String? placementurl;
  List<int?>? batchId;
  int? announcementNo;
  bool? isNewAnnouncement;

  StudentData({
    this.firstName,
    this.middleName,
    this.branchCode,
    this.branchid,
    this.lastName,
    this.image,
    this.grId,
    this.course,
    this.upskillCourse,
    this.contact,
    this.status,
    this.fees,
    this.discountAmount,
    this.paidAmount,
    this.payableAmount,
    this.admissionId,
    this.parentMobileNo,
    this.branchName,
    this.facultyName,
    this.hOD,
    this.courseType,
    this.placementurl,
    this.batchId,
    this.announcementNo,
    this.isNewAnnouncement,
  });

  StudentData.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    middleName = json['middle_name'];
    branchCode = json['branch_code'];
    branchid = json['branch_id'];
    lastName = json['last_name'];
    image = json['image'];
    grId = json['gr_id'];

    if (json['course'] is String) {
      course = json['course'] ?? Lang.current.lbl_n_a;
    } else if (json['course'] is List) {
      course = List<String>.from(json['course'] ?? [Lang.current.lbl_n_a]);
    }

    upskillCourse = (json['upskill_course'] as List?)?.cast<bool>();
    contact = json['contact'];
    status = json['status'];
    fees = json['fees'];
    discountAmount = json['discount_amount'];
    paidAmount = json['paid_amount'];
    payableAmount = json['payable_amount'];
    admissionId = json['admission_id'];
    parentMobileNo = json['parent_mobile_no'] != null
        ? ParentMobileNo.fromJson(json['parent_mobile_no'])
        : null;
    branchName = json['branch_name'];
    facultyName = json['faculty_name'];
    hOD = json['HOD'];
    courseType = json['course_type'];
    placementurl = json['placement_url'];
    batchId = (json['batch_id'] as List?)?.map((e) => e as int?).toList();
    announcementNo = json['announcement_no'];
    isNewAnnouncement = json['is_new_announcement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['middle_name'] = middleName;
    data['last_name'] = lastName;
    data['image'] = image;
    data['gr_id'] = grId;
    data['course'] = course;
    data['upskill_course'] = upskillCourse;
    data['contact'] = contact;
    data['status'] = status;
    data['fees'] = fees;
    data['discount_amount'] = discountAmount;
    data['paid_amount'] = paidAmount;
    data['payable_amount'] = payableAmount;
    data['admission_id'] = admissionId;
    if (parentMobileNo != null) {
      data['parent_mobile_no'] = parentMobileNo!.toJson();
    }
    data['branch_name'] = branchName;
    data['branch_id'] = branchid;
    data['faculty_name'] = facultyName;
    data['HOD'] = hOD;
    data['course_type'] = courseType;
    data['placement_url'] = placementurl;
    data['batch_id'] = batchId;
    data['announcement_no'] = announcementNo;
    data['is_new_announcement'] = isNewAnnouncement;
    return data;
  }
}

class ParentMobileNo {
  String? fatherMobileNo;
  String? motherMobileNo;

  ParentMobileNo({this.fatherMobileNo, this.motherMobileNo});

  ParentMobileNo.fromJson(Map<String, dynamic> json) {
    fatherMobileNo = json['father_mobile_no'];
    motherMobileNo = json['mother_mobile_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['father_mobile_no'] = fatherMobileNo;
    data['mother_mobile_no'] = motherMobileNo;
    return data;
  }
}


// class StudentDetailsModel {
//   List<StudentData>? data;
//   String? message;

//   StudentDetailsModel({this.data, this.message});

//   StudentDetailsModel.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <StudentData>[];
//       json['data'].forEach((v) {
//         data!.add(StudentData.fromJson(v));
//       });
//     }
//     message = json['message'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['message'] = message;
//     return data;
//   }
// }

// class StudentData {
//   int? id;
//   int? grId;
//   int? packageId;
//   int? startingCourseId;
//   String? courseCategory;
//   String? enrollmentNumber;
//   String? firstName;
//   String? middleName;
//   String? lastName;
//   String? email;
//   String? mobileNo;
//   String? fatherMobileNo;
//   String? motherMobileNo;
//   String? admissionAmount;
//   String? status;
//   String? studentPerformance;
//   Branch? branch;
//   Package? package;
//   List<AdmissionSubcourses>? admissionSubcourses;
//   List<AdmissionDocuments>? admissionDocuments;

//   StudentData(
//       {this.id,
//       this.grId,
//       this.packageId,
//       this.startingCourseId,
//       this.courseCategory,
//       this.enrollmentNumber,
//       this.firstName,
//       this.middleName,
//       this.lastName,
//       this.email,
//       this.mobileNo,
//       this.fatherMobileNo,
//       this.motherMobileNo,
//       this.admissionAmount,
//       this.status,
//       this.studentPerformance,
//       this.branch,
//       this.package,
//       this.admissionSubcourses,
//       this.admissionDocuments});

//   StudentData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     grId = json['gr_id'];
//     packageId = json['package_id'];
//     startingCourseId = json['starting_course_id'];
//     courseCategory = json['course_category'];
//     enrollmentNumber = json['enrollment_number'];
//     firstName = json['first_name'];
//     middleName = json['middle_name'];
//     lastName = json['last_name'];
//     email = json['email'];
//     mobileNo = json['mobile_no'];
//     fatherMobileNo = json['father_mobile_no'];
//     motherMobileNo = json['mother_mobile_no'];
//     admissionAmount = json['admission_amount'];
//     status = json['status'];
//     studentPerformance = json['student_performance'];
//     branch = json['branch'] != null ? Branch.fromJson(json['branch']) : null;
//     package =
//         json['package'] != null ? Package.fromJson(json['package']) : null;
//     if (json['admission_subcourses'] != null) {
//       admissionSubcourses = <AdmissionSubcourses>[];
//       json['admission_subcourses'].forEach((v) {
//         admissionSubcourses!.add(AdmissionSubcourses.fromJson(v));
//       });
//     }
//     if (json['admission_documents'] != null) {
//       admissionDocuments = <AdmissionDocuments>[];
//       json['admission_documents'].forEach((v) {
//         admissionDocuments!.add(AdmissionDocuments.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['gr_id'] = grId;
//     data['package_id'] = packageId;
//     data['starting_course_id'] = startingCourseId;
//     data['course_category'] = courseCategory;
//     data['enrollment_number'] = enrollmentNumber;
//     data['first_name'] = firstName;
//     data['middle_name'] = middleName;
//     data['last_name'] = lastName;
//     data['email'] = email;
//     data['mobile_no'] = mobileNo;
//     data['father_mobile_no'] = fatherMobileNo;
//     data['mother_mobile_no'] = motherMobileNo;
//     data['admission_amount'] = admissionAmount;
//     data['status'] = status;
//     data['student_performance'] = studentPerformance;
//     if (branch != null) {
//       data['branch'] = branch!.toJson();
//     }
//     if (package != null) {
//       data['package'] = package!.toJson();
//     }
//     if (admissionSubcourses != null) {
//       data['admission_subcourses'] =
//           admissionSubcourses!.map((v) => v.toJson()).toList();
//     }
//     if (admissionDocuments != null) {
//       data['admission_documents'] =
//           admissionDocuments!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Branch {
//   int? id;
//   String? name;
//   String? code;
//   String? examportalUrl;

//   Branch({this.id, this.name, this.code, this.examportalUrl});

//   Branch.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     code = json['code'];
//     examportalUrl = json['examportal_url'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['code'] = code;
//     data['examportal_url'] = examportalUrl;
//     return data;
//   }
// }

// class Package {
//   int? id;
//   int? courseConfigId;
//   int? departmentId;
//   int? subdepartmentId;
//   String? name;
//   String? code;
//   bool? careerCourse;
//   int? total;
//   String? duration;
//   int? installment;
//   bool? status;
//   String? createdBy;
//   String? createdDate;
//   String? updatedBy;
//   String? updatedDate;
//   String? banner;
//   String? eligibility;
//   String? brochureLink;
//   String? description;
//   bool? upskillCourse;

//   Package(
//       {this.id,
//       this.courseConfigId,
//       this.departmentId,
//       this.subdepartmentId,
//       this.name,
//       this.code,
//       this.careerCourse,
//       this.total,
//       this.duration,
//       this.installment,
//       this.status,
//       this.createdBy,
//       this.createdDate,
//       this.updatedBy,
//       this.updatedDate,
//       this.banner,
//       this.eligibility,
//       this.brochureLink,
//       this.description,
//       this.upskillCourse});

//   Package.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     courseConfigId = json['course_config_id'];
//     departmentId = json['department_id'];
//     subdepartmentId = json['subdepartment_id'];
//     name = json['name'];
//     code = json['code'];
//     careerCourse = json['career_course'];
//     total = json['total'];
//     duration = json['duration'];
//     installment = json['installment'];
//     status = json['status'];
//     createdBy = json['created_by'];
//     createdDate = json['created_date'];
//     updatedBy = json['updated_by'];
//     updatedDate = json['updated_date'];
//     banner = json['banner'];
//     eligibility = json['eligibility'];
//     brochureLink = json['brochure_link'];
//     description = json['description'];
//     upskillCourse = json['upskill_course'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['course_config_id'] = courseConfigId;
//     data['department_id'] = departmentId;
//     data['subdepartment_id'] = subdepartmentId;
//     data['name'] = name;
//     data['code'] = code;
//     data['career_course'] = careerCourse;
//     data['total'] = total;
//     data['duration'] = duration;
//     data['installment'] = installment;
//     data['status'] = status;
//     data['created_by'] = createdBy;
//     data['created_date'] = createdDate;
//     data['updated_by'] = updatedBy;
//     data['updated_date'] = updatedDate;
//     data['banner'] = banner;
//     data['eligibility'] = eligibility;
//     data['brochure_link'] = brochureLink;
//     data['description'] = description;
//     data['upskill_course'] = upskillCourse;
//     return data;
//   }
// }

// class AdmissionSubcourses {
//   int? id;
//   int? admissionId;
//   int? batchId;
//   int? courseId;
//   int? packageId;
//   int? subcourseId;
//   int? userId;
//   String? courseCategory;
//   String? subcourseStatus;
//   String? assignedDate;
//   String? completedDate;
//   String? createdBy;
//   String? createdDate;
//   String? updatedBy;
//   String? updatedDate;
//   String? grade;
//   String? subcoursePerformance;
//   String? subcourseRatio;
//   String? obtainMarks;
//   String? totalMarks;
//   Subcourse? subcourse;
//   Batch? batch;

//   AdmissionSubcourses(
//       {this.id,
//       this.admissionId,
//       this.batchId,
//       this.courseId,
//       this.packageId,
//       this.subcourseId,
//       this.userId,
//       this.courseCategory,
//       this.subcourseStatus,
//       this.assignedDate,
//       this.completedDate,
//       this.createdBy,
//       this.createdDate,
//       this.updatedBy,
//       this.updatedDate,
//       this.grade,
//       this.subcoursePerformance,
//       this.subcourseRatio,
//       this.obtainMarks,
//       this.totalMarks,
//       this.subcourse,
//       this.batch});

//   AdmissionSubcourses.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     admissionId = json['admission_id'];
//     batchId = json['batch_id'];
//     courseId = json['course_id'];
//     packageId = json['package_id'];
//     subcourseId = json['subcourse_id'];
//     userId = json['user_id'];
//     courseCategory = json['course_category'];
//     subcourseStatus = json['subcourse_status'];
//     assignedDate = json['assigned_date'];
//     completedDate = json['completed_date'];
//     createdBy = json['created_by'];
//     createdDate = json['created_date'];
//     updatedBy = json['updated_by'];
//     updatedDate = json['updated_date'];
//     grade = json['grade'];
//     subcoursePerformance = json['subcourse_performance'];
//     subcourseRatio = json['subcourse_ratio'];
//     obtainMarks = json['obtain_marks'];
//     totalMarks = json['total_marks'];
//     subcourse = json['subcourse'] != null
//         ? Subcourse.fromJson(json['subcourse'])
//         : null;
//     batch = json['batch'] != null ? Batch.fromJson(json['batch']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['admission_id'] = admissionId;
//     data['batch_id'] = batchId;
//     data['course_id'] = courseId;
//     data['package_id'] = packageId;
//     data['subcourse_id'] = subcourseId;
//     data['user_id'] = userId;
//     data['course_category'] = courseCategory;
//     data['subcourse_status'] = subcourseStatus;
//     data['assigned_date'] = assignedDate;
//     data['completed_date'] = completedDate;
//     data['created_by'] = createdBy;
//     data['created_date'] = createdDate;
//     data['updated_by'] = updatedBy;
//     data['updated_date'] = updatedDate;
//     data['grade'] = grade;
//     data['subcourse_performance'] = subcoursePerformance;
//     data['subcourse_ratio'] = subcourseRatio;
//     data['obtain_marks'] = obtainMarks;
//     data['total_marks'] = totalMarks;
//     if (subcourse != null) {
//       data['subcourse'] = subcourse!.toJson();
//     }
//     if (batch != null) {
//       data['batch'] = batch!.toJson();
//     }
//     return data;
//   }
// }

// class Subcourse {
//   int? id;
//   int? courseId;
//   int? courseConfigId;
//   String? name;
//   String? code;
//   bool? careerCourse;
//   int? total;
//   String? duration;
//   int? installment;
//   String? shiningSheet;
//   bool? status;
//   String? createdBy;
//   String? createdDate;
//   String? updatedBy;
//   String? updatedDate;
//   String? banner;
//   String? eligibility;
//   String? brochureLink;
//   String? description;
//   bool? upskillCourse;
//   int? ePHigh;
//   int? ePMedium;
//   int? ePLow;

//   Subcourse(
//       {this.id,
//       this.courseId,
//       this.courseConfigId,
//       this.name,
//       this.code,
//       this.careerCourse,
//       this.total,
//       this.duration,
//       this.installment,
//       this.shiningSheet,
//       this.status,
//       this.createdBy,
//       this.createdDate,
//       this.updatedBy,
//       this.updatedDate,
//       this.banner,
//       this.eligibility,
//       this.brochureLink,
//       this.description,
//       this.upskillCourse,
//       this.ePHigh,
//       this.ePMedium,
//       this.ePLow});

//   Subcourse.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     courseId = json['course_id'];
//     courseConfigId = json['course_config_id'];
//     name = json['name'];
//     code = json['code'];
//     careerCourse = json['career_course'];
//     total = json['total'];
//     duration = json['duration'];
//     installment = json['installment'];
//     shiningSheet = json['shining_sheet'];
//     status = json['status'];
//     createdBy = json['created_by'];
//     createdDate = json['created_date'];
//     updatedBy = json['updated_by'];
//     updatedDate = json['updated_date'];
//     banner = json['banner'];
//     eligibility = json['eligibility'];
//     brochureLink = json['brochure_link'];
//     description = json['description'];
//     upskillCourse = json['upskill_course'];
//     ePHigh = json['e_p_high'];
//     ePMedium = json['e_p_medium'];
//     ePLow = json['e_p_low'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['course_id'] = courseId;
//     data['course_config_id'] = courseConfigId;
//     data['name'] = name;
//     data['code'] = code;
//     data['career_course'] = careerCourse;
//     data['total'] = total;
//     data['duration'] = duration;
//     data['installment'] = installment;
//     data['shining_sheet'] = shiningSheet;
//     data['status'] = status;
//     data['created_by'] = createdBy;
//     data['created_date'] = createdDate;
//     data['updated_by'] = updatedBy;
//     data['updated_date'] = updatedDate;
//     data['banner'] = banner;
//     data['eligibility'] = eligibility;
//     data['brochure_link'] = brochureLink;
//     data['description'] = description;
//     data['upskill_course'] = upskillCourse;
//     data['e_p_high'] = ePHigh;
//     data['e_p_medium'] = ePMedium;
//     data['e_p_low'] = ePLow;
//     return data;
//   }
// }

// class Batch {
//   int? id;
//   int? branchId;
//   int? courseId;
//   int? subcourseId;
//   int? userId;
//   int? branchInfrastructureId;
//   String? code;
//   String? name;
//   String? duration;
//   String? batchesStatus;
//   bool? status;
//   String? createdBy;
//   String? createdDate;
//   String? updatedBy;
//   String? updatedDate;
//   String? startDate;
//   String? endDate;
//   String? batchTime;
//   bool? dayOne;
//   bool? dayTwo;
//   bool? dayThree;
//   bool? dayFour;
//   bool? dayFive;
//   bool? daySix;
//   bool? daySeven;
//   int? templateId;
//   int? numberOfDays;
//   String? examportalBranchId;
//   String? completedDate;
//   String? actualAcademicDate;

//   Batch(
//       {this.id,
//       this.branchId,
//       this.courseId,
//       this.subcourseId,
//       this.userId,
//       this.branchInfrastructureId,
//       this.code,
//       this.name,
//       this.duration,
//       this.batchesStatus,
//       this.status,
//       this.createdBy,
//       this.createdDate,
//       this.updatedBy,
//       this.updatedDate,
//       this.startDate,
//       this.endDate,
//       this.batchTime,
//       this.dayOne,
//       this.dayTwo,
//       this.dayThree,
//       this.dayFour,
//       this.dayFive,
//       this.daySix,
//       this.daySeven,
//       this.templateId,
//       this.numberOfDays,
//       this.examportalBranchId,
//       this.completedDate,
//       this.actualAcademicDate});

//   Batch.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     branchId = json['branch_id'];
//     courseId = json['course_id'];
//     subcourseId = json['subcourse_id'];
//     userId = json['user_id'];
//     branchInfrastructureId = json['branch_infrastructure_id'];
//     code = json['code'];
//     name = json['name'];
//     duration = json['duration'];
//     batchesStatus = json['batches_status'];
//     status = json['status'];
//     createdBy = json['created_by'];
//     createdDate = json['created_date'];
//     updatedBy = json['updated_by'];
//     updatedDate = json['updatedDate'];
//     startDate = json['start_date'];
//     endDate = json['end_date'];
//     batchTime = json['batch_time'];
//     dayOne = json['day_one'];
//     dayTwo = json['day_two'];
//     dayThree = json['day_three'];
//     dayFour = json['day_four'];
//     dayFive = json['day_five'];
//     daySix = json['day_six'];
//     daySeven = json['day_seven'];
//     templateId = json['template_id'];
//     numberOfDays = json['number_of_days'];
//     examportalBranchId = json['examportal_branch_id'];
//     completedDate = json['completed_date'];
//     actualAcademicDate = json['actual_academic_date'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['branch_id'] = branchId;
//     data['course_id'] = courseId;
//     data['subcourse_id'] = subcourseId;
//     data['user_id'] = userId;
//     data['branch_infrastructure_id'] = branchInfrastructureId;
//     data['code'] = code;
//     data['name'] = name;
//     data['duration'] = duration;
//     data['batches_status'] = batchesStatus;
//     data['status'] = status;
//     data['created_by'] = createdBy;
//     data['created_date'] = createdDate;
//     data['updated_by'] = updatedBy;
//     data['updatedDate'] = updatedDate;
//     data['start_date'] = startDate;
//     data['end_date'] = endDate;
//     data['batch_time'] = batchTime;
//     data['day_one'] = dayOne;
//     data['day_two'] = dayTwo;
//     data['day_three'] = dayThree;
//     data['day_four'] = dayFour;
//     data['day_five'] = dayFive;
//     data['day_six'] = daySix;
//     data['day_seven'] = daySeven;
//     data['template_id'] = templateId;
//     data['number_of_days'] = numberOfDays;
//     data['examportal_branch_id'] = examportalBranchId;
//     data['completed_date'] = completedDate;
//     data['actual_academic_date'] = actualAcademicDate;
//     return data;
//   }
// }

// class AdmissionDocuments {
//   int? id;
//   int? admissionId;
//   String? photos;
//   String? aadharCard;
//   String? form;
//   String? createdBy;
//   String? createdDate;
//   String? updatedBy;
//   String? updatedDate;
//   String? lastPassingMarksheet;

//   AdmissionDocuments(
//       {this.id,
//       this.admissionId,
//       this.photos,
//       this.aadharCard,
//       this.form,
//       this.createdBy,
//       this.createdDate,
//       this.updatedBy,
//       this.updatedDate,
//       this.lastPassingMarksheet});

//   AdmissionDocuments.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     admissionId = json['admission_id'];
//     photos = json['photos'];
//     aadharCard = json['aadhar_card'];
//     form = json['form'];
//     createdBy = json['created_by'];
//     createdDate = json['created_date'];
//     updatedBy = json['updated_by'];
//     updatedDate = json['updated_date'];
//     lastPassingMarksheet = json['last_passing_marksheet'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['admission_id'] = admissionId;
//     data['photos'] = photos;
//     data['aadhar_card'] = aadharCard;
//     data['form'] = form;
//     data['created_by'] = createdBy;
//     data['created_date'] = createdDate;
//     data['updated_by'] = updatedBy;
//     data['updated_date'] = updatedDate;
//     data['last_passing_marksheet'] = lastPassingMarksheet;
//     return data;
//   }
// }
