import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';

/// ============================================================================
/// [LoginOptionsRow] - Hàng tùy chọn phụ trợ dưới nút Đăng Nhập
/// Áp dụng lý thuyết:
/// 1. Row:
///    - Trục chính (Main Axis - ngang): mainAxisAlignment.spaceBetween đẩy 2 nút về 2 mép
///    - Trục phụ (Cross Axis - dọc): crossAxisAlignment.center căn đều theo phương thẳng đứng
/// 2. Flexible:
///    - Bọc 2 nút bằng Flexible(fit: FlexFit.loose) để khi cỡ chữ hệ thống tăng lên (Text Scale Factor),
///      các nút tự điều chỉnh kích thước theo nội dung mà không gây lỗi tràn chiều ngang (Horizontal Overflow).
/// ============================================================================
class LoginOptionsRow extends StatelessWidget {
  final VoidCallback? onForgotPassword;
  final VoidCallback? onActivateOtp;

  const LoginOptionsRow({
    super.key,
    this.onForgotPassword,
    this.onActivateOtp,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment.spaceBetween: Phân bổ khoảng trống ở giữa, đẩy 2 widget con sang 2 bên
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // crossAxisAlignment.center: Căn giữa theo chiều cao của hàng
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // -------------------------------------------------------------
        // LÝ THUYẾT: FLEXIBLE VỚI FIT LOOSE
        // Cho phép nút co giãn tự do theo kích cỡ chữ mà không bắt buộc chiếm hết
        // -------------------------------------------------------------
        Flexible(
          child: TextButton(
            onPressed: onForgotPassword ??
                () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Chức năng: Lấy lại mật khẩu qua OTP')),
                  );
                },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 36),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              AppStrings.forgotPassword,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryLight,
              ),
            ),
          ),
        ),

        const SizedBox(width: 12),

        Flexible(
          child: TextButton.icon(
            onPressed: onActivateOtp ??
                () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Chức năng: Đăng ký / Kích hoạt Smart OTP')),
                  );
                },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 36),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            icon: const Icon(
              Icons.shield_outlined,
              size: 15,
              color: AppColors.textSecondary,
            ),
            label: const Text(
              AppStrings.activateSmartOtp,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
