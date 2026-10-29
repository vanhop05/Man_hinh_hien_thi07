import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_assets.dart';

/// ============================================================================
/// [PasswordField] - Ô nhập mật khẩu đăng nhập
/// Áp dụng lý thuyết:
/// 1. Tương tác với Bàn phím ảo (Virtual Keyboard):
///    Khi người dùng focus vào ô này, bàn phím hệ thống xuất hiện đẩy giao diện lên.
///    Đây chính là NGUYÊN NHÂN CHÍNH gây ra lỗi Overflow phổ biến nhất trong Flutter:
///    "A RenderFlex overflowed by xxx pixels on the bottom".
/// 2. Bố cục Input Field chuẩn Material 3 với prefixIcon và suffixIcon căn chỉnh trục ngang
/// ============================================================================
class PasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? errorText;

  const PasswordField({
    super.key,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.errorText,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Nhãn tiêu đề (Label) phía trên ô nhập
        const Text(
          AppStrings.passwordLabel,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),

        const SizedBox(height: 8),

        // Trường nhập liệu mật khẩu
        TextField(
          controller: widget.controller,
          obscureText: _isObscured,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          textInputAction: TextInputAction.done,
          style: const TextStyle(
            fontSize: 15,
            color: AppColors.textPrimary,
            letterSpacing: 1.5,
          ),
          decoration: InputDecoration(
            hintText: AppStrings.passwordHint,
            errorText: widget.errorText,
            prefixIcon: const Icon(
              AppAssets.lock,
              size: 20,
            ),
            // Nút ẩn/hiện mật khẩu
            suffixIcon: IconButton(
              icon: Icon(
                _isObscured ? AppAssets.eyeClosed : AppAssets.eyeOpen,
                size: 20,
              ),
              onPressed: () {
                setState(() {
                  _isObscured = !_isObscured;
                });
              },
              tooltip: _isObscured ? 'Hiện mật khẩu' : 'Ẩn mật khẩu',
            ),
          ),
        ),
      ],
    );
  }
}
