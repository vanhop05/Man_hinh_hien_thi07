import 'package:flutter/material.dart';

/// Bảng màu chuẩn cho toàn bộ ứng dụng Đăng Nhập
/// Áp dụng phong cách Ngân hàng số / Fintech hiện đại (Modern Banking)
class AppColors {
  // Màu chủ đạo (Primary & Secondary)
  static const Color primary = Color(0xFF0F4C81); 
  static const Color primaryDark = Color(0xFF0A3156);
  static const Color primaryLight = Color(0xFF2E6CA4);
  static const Color accent = Color(0xFF00B4D8); 
  // Màu nền & Bề mặt
  static const Color background = Color(0xFFF4F6F9); 
  static const Color surface = Color(0xFFFFFFFF); 
  static const Color cardShadow = Color(0x14000000);

  // Màu chữ (Typography)
  static const Color textPrimary = Color(0xFF1D2939);
  static const Color textSecondary = Color(0xFF667085); 
  static const Color textHint = Color(0xFF98A2B3);
  static const Color textWhite = Color(0xFFFFFFFF);

  // Trạng thái (Status & Feedback)
  static const Color success = Color(0xFF12B76A); 
  static const Color error = Color(0xFFF04438);
  static const Color warning = Color(0xFFF79009); 
  static const Color info = Color(0xFF2E90FA); 

  // Màu viền và ngăn cách
  static const Color border = Color(0xFFE4E7EC);
  static const Color focusedBorder = Color(0xFF0F4C81);

  // Gradient trang trí
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF0F4C81), Color(0xFF1D6FBA)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF8FAFC)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
