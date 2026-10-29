import 'package:flutter/material.dart';

/// Quản lý biểu tượng (Icons) và đường dẫn tài nguyên (Assets)
/// Sử dụng Icons vector chuẩn Flutter để ứng dụng chạy ngay lập tức không phụ thuộc file ngoài
class AppAssets {
  // Biểu tượng ứng dụng & thương hiệu
  static const IconData bankLogo = Icons.account_balance_rounded;
  static const IconData shieldSecure = Icons.verified_user_rounded;

  // Biểu tượng người dùng & thẻ tài khoản
  static const IconData userAvatar = Icons.person_rounded;
  static const IconData switchUser = Icons.swap_horiz_rounded;
  static const IconData checkVerified = Icons.check_circle_rounded;

  // Biểu tượng ô nhập liệu & bảo mật
  static const IconData lock = Icons.lock_outline_rounded;
  static const IconData eyeOpen = Icons.visibility_outlined;
  static const IconData eyeClosed = Icons.visibility_off_outlined;

  // Biểu tượng sinh trắc học
  static const IconData faceId = Icons.face_retouching_natural_rounded;
  static const IconData fingerprint = Icons.fingerprint_rounded;

  // Biểu tượng footer & tiện ích
  static const IconData hotline = Icons.headset_mic_rounded;
  static const IconData branchAtm = Icons.location_on_outlined;
  static const IconData help = Icons.help_outline_rounded;
  static const IconData info = Icons.info_outline_rounded;

  // Biểu tượng thanh công cụ demo
  static const IconData theory = Icons.menu_book_rounded;
  static const IconData bugReport = Icons.bug_report_rounded;
  static const IconData textFormat = Icons.text_fields_rounded;
}
