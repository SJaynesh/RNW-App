class NotificationModel {
  List<Data>? data;
  String? message;

  NotificationModel({this.data, this.message});

  NotificationModel.fromJson(Map<String, dynamic> json) {
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

  NotificationModel copyWith({
    List<Data>? data,
    String? message,
  }) {
    return NotificationModel(
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }
}

class Data {
  int? id;
  int? batchID;
  String? mobileNo;
  String? title;
  String? screenType;
  String? message;
  String? category;
  bool? isRead;
  DateTime? createdDate;

  Data({this.id, this.batchID, this.mobileNo, this.title, this.screenType, this.message, this.category, this.isRead, this.createdDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    batchID = json['batch_id'];
    mobileNo = json['mobile_no'];
    title = json['title'];
    screenType = json['screen_type'];
    message = json['message'];
    category = json['category'];
    isRead = json['is_read'];
    createdDate = json['created_date'] != null ? DateTime.parse(json['created_date']) : json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['batch_id'] = batchID;
    data['mobile_no'] = mobileNo;
    data['title'] = title;
    data['screen_type'] = screenType;
    data['message'] = message;
    data['category'] = category;
    data['is_read'] = isRead;
    data['created_date'] = createdDate;
    return data;
  }

  Data copyWith({
    int? id,
    int? batchID,
    String? title,
    String? screenType,
    String? message,
    String? category,
    DateTime? createdDate,
    String? mobileNo,
    bool? isRead,
  }) {
    return Data(
      id: id ?? this.id,
      batchID: batchID ?? this.batchID,
      title: title ?? this.title,
      screenType: screenType ?? this.screenType,
      message: message ?? this.message,
      category: category ?? this.category,
      createdDate: createdDate ?? this.createdDate,
      mobileNo: mobileNo ?? this.mobileNo,
      isRead: isRead ?? this.isRead,
    );
  }
}
