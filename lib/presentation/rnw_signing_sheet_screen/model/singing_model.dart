class BatchDetailsModel {
  List<BatchData>? data;
  String? message;

  BatchDetailsModel({this.data, this.message});

  BatchDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BatchData>[];
      json['data'].forEach((v) {
        data!.add(BatchData.fromJson(v));
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

class BatchData {
  int? id;
  int? batchId;
  String? name;
  String? sequence;
  String? type;
  String? duration;
  String? marks;
  Null? plannedStartDate;
  List<BatchSingingSheets>? batchSingingSheets;
  List<BatchStudentMarks>? batchStudentMarks;

  BatchData(
      {this.id,
      this.batchId,
      this.name,
      this.sequence,
      this.type,
      this.duration,
      this.marks,
      this.plannedStartDate,
      this.batchSingingSheets,
      this.batchStudentMarks});

  BatchData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    batchId = json['batch_id'];
    name = json['name'];
    sequence = json['sequence'];
    type = json['type'];
    duration = json['duration'];
    marks = json['marks'];
    plannedStartDate = json['planned_start_date'];
    if (json['batchSingingSheets'] != null) {
      batchSingingSheets = <BatchSingingSheets>[];
      json['batchSingingSheets'].forEach((v) {
        batchSingingSheets!.add(BatchSingingSheets.fromJson(v));
      });
    }
    if (json['batchStudentMarks'] != null) {
      batchStudentMarks = <BatchStudentMarks>[];
      json['batchStudentMarks'].forEach((v) {
        batchStudentMarks!.add(BatchStudentMarks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['batch_id'] = batchId;
    data['name'] = name;
    data['sequence'] = sequence;
    data['type'] = type;
    data['duration'] = duration;
    data['marks'] = marks;
    data['planned_start_date'] = plannedStartDate;
    if (batchSingingSheets != null) {
      data['batchSingingSheets'] =
          batchSingingSheets!.map((v) => v.toJson()).toList();
    }
    if (batchStudentMarks != null) {
      data['batchStudentMarks'] =
          batchStudentMarks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BatchSingingSheets {
  int? id;
  int? batchId;
  String? description;
  String? notes;
  List<BatchFacultyAttendances>? batchFacultyAttendances;

  BatchSingingSheets(
      {this.id,
      this.batchId,
      this.description,
      this.notes,
      this.batchFacultyAttendances});

  BatchSingingSheets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    batchId = json['batch_id'];
    description = json['description'];
    notes = json['notes'].toString();
    if (json['batchFacultyAttendances'] != null) {
      batchFacultyAttendances = <BatchFacultyAttendances>[];
      json['batchFacultyAttendances'].forEach((v) {
        batchFacultyAttendances!.add(BatchFacultyAttendances.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['batch_id'] = batchId;
    data['description'] = description;
    data['notes'] = notes;
    if (batchFacultyAttendances != null) {
      data['batchFacultyAttendances'] =
          batchFacultyAttendances!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BatchFacultyAttendances {
  int? id;
  int? batchSingingSheetId;
  String? actualDate;
  List<BatchStudentAttendances>? batchStudentAttendances;

  BatchFacultyAttendances(
      {this.id,
      this.batchSingingSheetId,
      this.actualDate,
      this.batchStudentAttendances});

  BatchFacultyAttendances.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    batchSingingSheetId = json['batch_singing_sheet_id'];
    actualDate = json['actual_date'];
    if (json['batchStudentAttendances'] != null) {
      batchStudentAttendances = <BatchStudentAttendances>[];
      json['batchStudentAttendances'].forEach((v) {
        batchStudentAttendances!.add(BatchStudentAttendances.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['batch_singing_sheet_id'] = batchSingingSheetId;
    data['actual_date'] = actualDate;
    if (batchStudentAttendances != null) {
      data['batchStudentAttendances'] =
          batchStudentAttendances!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BatchStudentAttendances {
  int? id;
  int? admissionId;
  int? batchSingingSheetId;
  bool? isPresent;
  String? feedback;
  Admission? admission;
  // List<Null>? examPaperStudents;

  BatchStudentAttendances({
    this.id,
    this.admissionId,
    this.batchSingingSheetId,
    this.isPresent,
    this.feedback,
    this.admission,
    // this.examPaperStudents
  });

  BatchStudentAttendances.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    admissionId = json['admission_id'];
    batchSingingSheetId = json['batch_singing_sheet_id'];
    isPresent = json['is_present'];
    feedback = json['feedback'];
    admission = json['admission'] != null
        ? Admission.fromJson(json['admission'])
        : null;
    // if (json['examPaperStudents'] != null) {
    //   examPaperStudents = <Null>[];
    //   json['examPaperStudents'].forEach((v) {
    //     examPaperStudents!.add(Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['admission_id'] = admissionId;
    data['batch_singing_sheet_id'] = batchSingingSheetId;
    data['is_present'] = isPresent;
    data['feedback'] = feedback;
    if (admission != null) {
      data['admission'] = admission!.toJson();
    }
    // if (examPaperStudents != null) {
    //   data['examPaperStudents'] =
    //       examPaperStudents!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Admission {
  int? id;
  String? status;

  Admission({this.id, this.status});

  Admission.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    return data;
  }
}

class BatchStudentMarks {
  int? id;
  int? admissionId;
  int? batchId;
  int? batchSingingSheetId;
  String? totalMarks;
  String? marks;
  String? remarks;
  String? submissionLink;

  BatchStudentMarks(
      {this.id,
      this.admissionId,
      this.batchId,
      this.batchSingingSheetId,
      this.totalMarks,
      this.marks,
      this.remarks,
      this.submissionLink});

  BatchStudentMarks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    admissionId = json['admission_id'];
    batchId = json['batch_id'];
    batchSingingSheetId = json['batch_singing_sheet_id'];
    totalMarks = json['total_marks'].toString();
    marks = json['marks'];
    remarks = json['remarks'] ?? '';
    submissionLink = json['submission_link'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['admission_id'] = admissionId;
    data['batch_id'] = batchId;
    data['batch_singing_sheet_id'] = batchSingingSheetId;
    data['total_marks'] = totalMarks;
    data['marks'] = marks;
    data['remarks'] = remarks;
    data['submission_link'] = submissionLink;
    return data;
  }
}


// class BatchDetailsModel {
//   List<BatchData>? data;
//   String? message;

//   BatchDetailsModel({this.data, this.message});

//   BatchDetailsModel.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <BatchData>[];
//       json['data'].forEach((v) {
//         data!.add(BatchData.fromJson(v));
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

// class BatchData {
//   int? id;
//   int? batchId;
//   String? name;
//   String? sequence;
//   String? type;
//   String? duration;
//   String? marks;
//   String? plannedStartDate;
//   List<BatchSingingSheets>? batchSingingSheets;
//   List<BatchStudentMarks>? batchStudentMarks;

//   BatchData(
//       {this.id,
//       this.batchId,
//       this.name,
//       this.sequence,
//       this.type,
//       this.duration,
//       this.marks,
//       this.plannedStartDate,
//       this.batchSingingSheets,
//       this.batchStudentMarks});

//   BatchData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     batchId = json['batch_id'];
//     name = json['name'];
//     sequence = json['sequence'];
//     type = json['type'];
//     duration = json['duration'];
//     marks = json['marks'];
//     plannedStartDate = json['planned_start_date'];
//     if (json['batchSingingSheets'] != null) {
//       batchSingingSheets = <BatchSingingSheets>[];
//       json['batchSingingSheets'].forEach((v) {
//         batchSingingSheets!.add(BatchSingingSheets.fromJson(v));
//       });
//     }
//     if (json['Batch_student_marks'] != null) {
//       batchStudentMarks = <BatchStudentMarks>[];
//       json['Batch_student_marks'].forEach((v) {
//         batchStudentMarks!.add(BatchStudentMarks.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['batch_id'] = batchId;
//     data['name'] = name;
//     data['sequence'] = sequence;
//     data['type'] = type;
//     data['duration'] = duration;
//     data['marks'] = marks;
//     data['planned_start_date'] = plannedStartDate;
//     if (batchSingingSheets != null) {
//       data['batchSingingSheets'] =
//           batchSingingSheets!.map((v) => v.toJson()).toList();
//     }
//     if (batchStudentMarks != null) {
//       data['Batch_student_marks'] =
//           batchStudentMarks!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class BatchSingingSheets {
//   int? id;
//   int? batchId;
//   String? description;
//   String? sequence;
//   String? notes;
//   String? duration;
//   List<BatchFacultyAttendances>? batchFacultyAttendances;

//   BatchSingingSheets(
//       {this.id,
//       this.batchId,
//       this.description,
//       this.sequence,
//       this.notes,
//       this.duration,
//       this.batchFacultyAttendances});

//   BatchSingingSheets.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     batchId = json['batch_id'];
//     description = json['description'];
//     sequence = json['sequence'];
//     notes = json['notes'];
//     duration = json['duration'];
//     if (json['batchFacultyAttendances'] != null) {
//       batchFacultyAttendances = <BatchFacultyAttendances>[];
//       json['batchFacultyAttendances'].forEach((v) {
//         batchFacultyAttendances!.add(BatchFacultyAttendances.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['batch_id'] = batchId;
//     data['description'] = description;
//     data['sequence'] = sequence;
//     data['notes'] = notes;
//     data['duration'] = duration;
//     if (batchFacultyAttendances != null) {
//       data['batchFacultyAttendances'] =
//           batchFacultyAttendances!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class BatchFacultyAttendances {
//   int? id;
//   int? batchSingingSheetId;
//   String? actualDate;
//   List<BatchStudentAttendances>? batchStudentAttendances;

//   BatchFacultyAttendances(
//       {this.id,
//       this.batchSingingSheetId,
//       this.actualDate,
//       this.batchStudentAttendances});

//   BatchFacultyAttendances.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     batchSingingSheetId = json['batch_singing_sheet_id'];
//     actualDate = json['actual_date'];
//     if (json['batchStudentAttendances'] != null) {
//       batchStudentAttendances = <BatchStudentAttendances>[];
//       json['batchStudentAttendances'].forEach((v) {
//         batchStudentAttendances!.add(BatchStudentAttendances.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['batch_singing_sheet_id'] = batchSingingSheetId;
//     data['actual_date'] = actualDate;
//     if (batchStudentAttendances != null) {
//       data['batchStudentAttendances'] =
//           batchStudentAttendances!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class BatchStudentAttendances {
//   int? id;
//   int? admissionId;
//   int? batchSingingSheetId;
//   bool? isPresent;
//   String? feedback;
//   Admission? admission;

//   BatchStudentAttendances(
//       {this.id,
//       this.admissionId,
//       this.batchSingingSheetId,
//       this.isPresent,
//       this.feedback,
//       this.admission});

//   BatchStudentAttendances.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     admissionId = json['admission_id'];
//     batchSingingSheetId = json['batch_singing_sheet_id'];
//     isPresent = json['is_present'];
//     feedback = json['feedback'];
//     admission = json['admission'] != null
//         ? Admission.fromJson(json['admission'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['admission_id'] = admissionId;
//     data['batch_singing_sheet_id'] = batchSingingSheetId;
//     data['is_present'] = isPresent;
//     data['feedback'] = feedback;
//     if (admission != null) {
//       data['admission'] = admission!.toJson();
//     }
//     return data;
//   }
// }

// class Admission {
//   int? id;
//   String? status;

//   Admission({this.id, this.status});

//   Admission.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     status = json['status'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['status'] = status;
//     return data;
//   }
// }

// class BatchStudentMarks {
//   int? id;
//   int? admissionId;
//   int? batchId;
//   int? batchSingingSheetId;
//   int? totalMarks;
//   String? marks;
//   String? examportalTestToken;
//   String? examportalTestId;
//   String? submissionLink;

//   BatchStudentMarks(
//       {this.id,
//       this.admissionId,
//       this.batchId,
//       this.batchSingingSheetId,
//       this.totalMarks,
//       this.marks,
//       this.examportalTestToken,
//       this.examportalTestId,
//       this.submissionLink});

//   BatchStudentMarks.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     admissionId = json['admission_id'];
//     batchId = json['batch_id'];
//     batchSingingSheetId = json['batch_singing_sheet_id'];
//     totalMarks = json['total_marks'];
//     marks = json['marks'];
//     examportalTestToken = json['examportal_test_token'];
//     examportalTestId = json['examportal_test_id'];
//     submissionLink = json['submission_link'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['admission_id'] = admissionId;
//     data['batch_id'] = batchId;
//     data['batch_singing_sheet_id'] = batchSingingSheetId;
//     data['total_marks'] = totalMarks;
//     data['marks'] = marks;
//     data['examportal_test_token'] = examportalTestToken;
//     data['examportal_test_id'] = examportalTestId;
//     data['submission_link'] = submissionLink;
//     return data;
//   }
// }
