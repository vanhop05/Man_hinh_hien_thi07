import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';

/// ============================================================================
/// [LoginButton] - Nút đăng nhập chính của ứng dụng
/// Áp dụng lý thuyết:
/// 1. Phân chia không gian (Space Allocation):
///    Khi đặt trong Row cùng với [FaceIdButton], nút này được bọc bằng Expanded(flex: 4)
///    để chiếm phần lớn diện tích ngang, nhường phần nhỏ cho nút sinh trắc học.
/// 2. Hiệu ứng Gradient và Shadow đem lại trải nghiệm giao diện cao cấp.
/// ============================================================================
class LoginButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final String text;

  const LoginButton({
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.text = AppStrings.loginButton,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52, // Chiều cao chuẩn công thái học cho nút bấm trên di động
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: onPressed != null ? AppColors.primaryGradient : null,
          color: onPressed == null ? AppColors.border : null,
          borderRadius: BorderRadius.circular(14),
          boxShadow: onPressed != null
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: isLoading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: AppColors.textWhite,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      text,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                        color: AppColors.textWhite,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                      color: AppColors.textWhite,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
