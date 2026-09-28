// ignore_for_file: constant_identifier_names

enum DrawerOption {
  profile,
  offlineDownloads,
  studyMaterial,
  payments,
  freeTests,
  settings,
  logout,
  tellAFriend,
  helpAndFeedback,
  unknown
}

enum CourseType { single, package, college }

enum UserType { PARENTS, STUDENT }

enum FeedbackType { A, B, C, D }

enum CertificateStatus { inProgress, confirmed, printed, unknown }

extension DrawerOptionExtension on DrawerOption {
  String toValue() {
    switch (this) {
      case DrawerOption.profile:
        return 'Profile';
      case DrawerOption.offlineDownloads:
        return 'Offline Downloads';
      case DrawerOption.studyMaterial:
        return 'Study Material';
      case DrawerOption.payments:
        return 'Payments';
      case DrawerOption.freeTests:
        return 'Free Tests';
      case DrawerOption.settings:
        return 'Settings';
      case DrawerOption.logout:
        return 'Logout';
      case DrawerOption.tellAFriend:
        return 'Tell a Friend';
      case DrawerOption.helpAndFeedback:
        return 'Help And Feedback';
      default:
        return 'unknown';
    }
  }
}

extension CourseTypeExtension on CourseType {
  String toValue() {
    switch (this) {
      case CourseType.single:
        return 'single';
      case CourseType.package:
        return 'package';
      case CourseType.college:
        return 'college';
      default:
        return 'unknown';
    }
  }
}
