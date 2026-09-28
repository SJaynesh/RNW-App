class HelpCenterItem {
  final String title;
  final String phoneNumber;
  final String icon;

  HelpCenterItem({
    required this.title,
    required this.phoneNumber,
    required this.icon,
  });

  factory HelpCenterItem.fromJson(Map<String, dynamic> json) {
    return HelpCenterItem(
      title: json['title'] ?? 'No Title',
      phoneNumber: json['phoneNumber'] ?? 'No Number',
      icon: json['icon'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'phoneNumber': phoneNumber,
      'icon': icon,
    };
  }
}
