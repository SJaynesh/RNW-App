class MarkReadModel {
  final MarkReadResponseData? data;
  final String? message;

  MarkReadModel({
    this.data,
    this.message,
  });

  factory MarkReadModel.fromJson(Map<String, dynamic> json) {
    return MarkReadModel(
      data: json['data'] != null
          ? MarkReadResponseData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
      'message': message,
    };
  }
}

class MarkReadResponseData {
  final List<dynamic>? generatedMaps;
  final List<dynamic>? raw;
  final int? affected;

  MarkReadResponseData({
    this.generatedMaps,
    this.raw,
    this.affected,
  });

  factory MarkReadResponseData.fromJson(Map<String, dynamic> json) {
    return MarkReadResponseData(
      generatedMaps: json['generatedMaps'] as List<dynamic>?,
      raw: json['raw'] as List<dynamic>?,
      affected: json['affected'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'generatedMaps': generatedMaps,
      'raw': raw,
      'affected': affected,
    };
  }
}