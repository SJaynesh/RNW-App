class CourseFeedbackModel {
  Data? data;
  String? message;

  CourseFeedbackModel({this.data, this.message});

  CourseFeedbackModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  List<String>? generatedMaps;
  List<String>? raw;
  int? affected;

  Data({this.generatedMaps, this.raw, this.affected});

  Data.fromJson(Map<String, dynamic> json) {
    generatedMaps = json['generatedMaps'].cast<String>();
    raw = json['raw'].cast<String>();
    affected = json['affected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['generatedMaps'] = generatedMaps;
    data['raw'] = raw;
    data['affected'] = affected;
    return data;
  }
}
