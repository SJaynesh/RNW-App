class BatchesModel {
  List<BatchData>? data;
  String? message;

  BatchesModel({this.data, this.message});

  BatchesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BatchData>[];
      json['data'].forEach((v) {
        data!.add(new BatchData.fromJson(v));
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

  BatchData(
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

  BatchData.fromJson(Map<String, dynamic> json) {
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
