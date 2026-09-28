class StudentListModel {
  List<Data>? data;
  String? message;

  StudentListModel({this.data, this.message});

  StudentListModel.fromJson(Map<String, dynamic> json) {
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
  int? grId;
  String? enrollmentNumber;
  String? branchCode;
  String? firstName;
  String? middleName;
  String? lastName;
  String? courseCategory;
  Package? package;
  List<Subcourse>? subcourse;
  String? image;

  Data(
      {this.id,
      this.grId,
      this.enrollmentNumber,
      this.branchCode,
      this.firstName,
      this.middleName,
      this.lastName,
      this.courseCategory,
      this.package,
      this.subcourse,
      this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    grId = json['gr_id'];
    enrollmentNumber = json['enrollment_number'];
    branchCode = json['branch_code'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    courseCategory = json['course_category'];
    package =
        json['package'] != null ? Package.fromJson(json['package']) : null;
    if (json['subcourse'] != null) {
      subcourse = <Subcourse>[];
      json['subcourse'].forEach((v) {
        subcourse!.add(Subcourse.fromJson(v));
      });
    }
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['gr_id'] = grId;
    data['enrollment_number'] = enrollmentNumber;
    data['branch_code'] = branchCode;
    data['first_name'] = firstName;
    data['middle_name'] = middleName;
    data['last_name'] = lastName;
    data['course_category'] = courseCategory;
    if (package != null) {
      data['package'] = package!.toJson();
    }
    if (subcourse != null) {
      data['subcourse'] = subcourse!.map((v) => v.toJson()).toList();
    }
    data['image'] = image;
    return data;
  }
}

class Package {
  int? id;
  String? name;

  Package({this.id, this.name});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Subcourse {
  int? id;
  int? subcourseId;
  Package? subcourse;

  Subcourse({this.id, this.subcourseId, this.subcourse});

  Subcourse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subcourseId = json['subcourse_id'];
    subcourse =
        json['subcourse'] != null ? Package.fromJson(json['subcourse']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subcourse_id'] = subcourseId;
    if (subcourse != null) {
      data['subcourse'] = subcourse!.toJson();
    }
    return data;
  }
}


// class StudentListModel {
//   List<Data>? data;
//   String? message;

//   StudentListModel({this.data, this.message});

//   StudentListModel.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(Data.fromJson(v));
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

// class Data {
//   int? id;
//   int? grId;
//   int? packageId;
//   int? startingCourseId;
//   String? courseCategory;
//   String? enrollmentNumber;
//   String? firstName;
//   String? middleName;
//   String? lastName;
//   String? admissionAmount;
//   Package? package;
//   List<AdmissionSubcourses>? admissionSubcourses;
//   List<AdmissionDocuments>? admissionDocuments;

//   Data(
//       {this.id,
//       this.grId,
//       this.packageId,
//       this.startingCourseId,
//       this.courseCategory,
//       this.enrollmentNumber,
//       this.firstName,
//       this.middleName,
//       this.lastName,
//       this.admissionAmount,
//       this.package,
//       this.admissionSubcourses,
//       this.admissionDocuments});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     grId = json['gr_id'];
//     packageId = json['package_id'];
//     startingCourseId = json['starting_course_id'];
//     courseCategory = json['course_category'];
//     enrollmentNumber = json['enrollment_number'];
//     firstName = json['first_name'];
//     middleName = json['middle_name'];
//     lastName = json['last_name'];
//     admissionAmount = json['admission_amount'];
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
//     data['admission_amount'] = admissionAmount;
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
//       this.subcourse});

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
