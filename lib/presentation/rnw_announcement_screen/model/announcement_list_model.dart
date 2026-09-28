class AnnouncementModel {
  AnnouncementData? data;
  String? message;

  AnnouncementModel({this.data, this.message});

  AnnouncementModel.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? AnnouncementData.fromJson(json['data']) : null;
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

class AnnouncementData {
  List<AnnouncementRow>? rows;
  int? count;

  AnnouncementData({this.rows, this.count});

  AnnouncementData.fromJson(Map<String, dynamic> json) {
    if (json['rows'] != null) {
      rows = <AnnouncementRow>[];
      json['rows'].forEach((v) {
        rows!.add(AnnouncementRow.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (rows != null) {
      data['rows'] = rows!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    return data;
  }
}

class AnnouncementRow {
  int? id;
  int? admissionId;
  int? announcementId;
  bool? isRead;
  String? isReadDate;
  bool? isAcknowledge;
  String? isAcknowledgeDate;
  String? assignDate;
  AnnouncementDetail? announcement;

  AnnouncementRow({
    this.id,
    this.admissionId,
    this.announcementId,
    this.isRead,
    this.isReadDate,
    this.isAcknowledge,
    this.isAcknowledgeDate,
    this.assignDate,
    this.announcement,
  });

  AnnouncementRow.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    admissionId = json['admission_id'];
    announcementId = json['announcement_id'];
    isRead = json['is_read'];
    isReadDate = json['is_read_date'];
    isAcknowledge = json['is_acknowledge'];
    isAcknowledgeDate = json['is_acknowledge_date'];
    assignDate = json['assign_date'];
    announcement = json['announcement'] != null
        ? AnnouncementDetail.fromJson(json['announcement'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['admission_id'] = admissionId;
    data['announcement_id'] = announcementId;
    data['is_read'] = isRead;
    data['is_read_date'] = isReadDate;
    data['is_acknowledge'] = isAcknowledge;
    data['is_acknowledge_date'] = isAcknowledgeDate;
    data['assign_date'] = assignDate;
    if (announcement != null) {
      data['announcement'] = announcement!.toJson();
    }
    return data;
  }
}

class AnnouncementDetail {
  int? id;
  String? title;
  String? description;
  String? date;
  String? attachment;

  AnnouncementDetail({this.id, this.title, this.description, this.date, this.attachment});

  AnnouncementDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
    attachment = json['attachment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['date'] = date;
    data['attachment'] = attachment;
    return data;
  }
}

// class AnnouncementModel {
//   AnnouncementData? data;
//   String? message;

//   AnnouncementModel({this.data, this.message});

//   AnnouncementModel.fromJson(Map<String, dynamic> json) {
//     data = json['data'] != null ? AnnouncementData.fromJson(json['data']) : null;
//     message = json['message'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     data['message'] = message;
//     return data;
//   }
// }

// class AnnouncementData {
//   List<Announcement>? rows;
//   int? count;

//   AnnouncementData({this.rows, this.count});

//   AnnouncementData.fromJson(Map<String, dynamic> json) {
//     if (json['rows'] != null) {
//       rows = <Announcement>[];
//       json['rows'].forEach((v) {
//         rows!.add(Announcement.fromJson(v));
//       });
//     }
//     count = json['count'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (rows != null) {
//       data['rows'] = rows!.map((v) => v.toJson()).toList();
//     }
//     data['count'] = count;
//     return data;
//   }
// }

// class Announcement {
//   // Add your actual announcement fields here
//   // For example:
//   int? id;
//   String? title;
//   String? description;
//   String? date;

//   Announcement({this.id, this.title, this.description, this.date});

//   Announcement.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     description = json['description'];
//     date = json['date'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['title'] = title;
//     data['description'] = description;
//     data['date'] = date;
//     return data;
//   }
// }
