
class UpdateAcknowledgeModel {
  final bool? success;
  final String? message;
  final dynamic data;

  UpdateAcknowledgeModel({
    this.success,
    this.message,
    this.data,
  });

  factory UpdateAcknowledgeModel.fromJson(Map<String, dynamic> json) {
    return UpdateAcknowledgeModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data,
    };
  }
}