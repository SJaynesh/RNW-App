import 'package:rnw_institue/utils/enum.dart';

extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${this.substring(1)}';
  }

  CourseType? toCourseType() {
    switch (this) {
      case 'single':
        return CourseType.single;
      case 'package':
        return CourseType.package;
      case 'college':
        return CourseType.college;
      default:
        return null;
    }
  }

  UserType? toPerson() {
    switch (this.toLowerCase()) {
      case 'student':
        return UserType.STUDENT;
      case 'parent':
        return UserType.PARENTS;
      default:
        return null;
    }
  }

  CertificateStatus toCertificateStatus() {
    switch (this.toLowerCase()) {
      case 'in_progress':
        return CertificateStatus.inProgress;
      case 'printed':
        return CertificateStatus.printed;
      case 'confirmed':
        return CertificateStatus.confirmed;
      default:
        return CertificateStatus.unknown;
    }
  }
}
