class FeedbackModel {
  String? subject;
  String? type;
  String? remarks;
  String? feedbackType;

  FeedbackModel({this.subject, this.type, this.remarks, this.feedbackType});

  FeedbackModel.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    type = json['type'];
    remarks = json['remarks'];
    feedbackType = json['feedback_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subject'] = subject;
    data['type'] = type;
    data['remarks'] = remarks;
    data['feedback_type'] = feedbackType;
    return data;
  }
}
