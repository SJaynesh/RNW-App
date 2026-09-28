class FeeDetailsModel {
  List<Data>? data;
  String? message;

  FeeDetailsModel({this.data, this.message});

  FeeDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null && json['data'] is List) {
      data = <Data>[];
      for (var v in json['data']) {
        if (v != null) {
          data!.add(Data.fromJson(v));
        }
      }
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
  int? admissionId;
  int? branchId;
  int? invoiceId;
  String? installmentDate;
  String? commitmentDate;
  String? installmentNo;
  String? dueAmount;
  String? payAmount;
  String? admissionStatus;
  String? chequeStatus;
  bool? sendSmsStudent;
  bool? sendEmailParents;
  String? createdBy;
  String? createdDate;
  String? updatedBy;
  String? updatedDate;
  String? status;
  bool? sendEmailStudent;
  bool? sendSmsParents;
  String? installmentAmount;

  Data(
      {this.id,
      this.admissionId,
      this.branchId,
      this.invoiceId,
      this.installmentDate,
      this.commitmentDate,
      this.installmentNo,
      this.dueAmount,
      this.payAmount,
      this.admissionStatus,
      this.chequeStatus,
      this.sendSmsStudent,
      this.sendEmailParents,
      this.createdBy,
      this.createdDate,
      this.updatedBy,
      this.updatedDate,
      this.status,
      this.sendEmailStudent,
      this.sendSmsParents,
      this.installmentAmount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    admissionId = json['admission_id'];
    branchId = json['branch_id'];
    invoiceId = json['invoice_id'];
    installmentDate = json['installment_date'];
    commitmentDate = json['commitment_date'];
    installmentNo = json['installment_no'];
    dueAmount = json['due_amount'];
    payAmount = json['pay_amount'];
    admissionStatus = json['admission_status'];
    chequeStatus = json['cheque_status'];
    sendSmsStudent = json['send_sms_student'];
    sendEmailParents = json['send_email_parents'];
    createdBy = json['created_by'];
    createdDate = json['created_date'];
    updatedBy = json['updated_by'];
    updatedDate = json['updated_date'];
    status = json['status'];
    sendEmailStudent = json['send_email_student'];
    sendSmsParents = json['send_sms_parents'];
    installmentAmount = json['installment_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['admission_id'] = admissionId;
    data['branch_id'] = branchId;
    data['invoice_id'] = invoiceId;
    data['installment_date'] = installmentDate;
    data['commitment_date'] = commitmentDate;
    data['installment_no'] = installmentNo;
    data['due_amount'] = dueAmount;
    data['pay_amount'] = payAmount;
    data['admission_status'] = admissionStatus;
    data['cheque_status'] = chequeStatus;
    data['send_sms_student'] = sendSmsStudent;
    data['send_email_parents'] = sendEmailParents;
    data['created_by'] = createdBy;
    data['created_date'] = createdDate;
    data['updated_by'] = updatedBy;
    data['updated_date'] = updatedDate;
    data['status'] = status;
    data['send_email_student'] = sendEmailStudent;
    data['send_sms_parents'] = sendSmsParents;
    data['installment_amount'] = installmentAmount;
    return data;
  }
}
