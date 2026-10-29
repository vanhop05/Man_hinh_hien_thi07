import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_assets.dart';

/// ============================================================================
/// [LoginHeader] - Phần đầu trang Đăng Nhập
/// Áp dụng lý thuyết:
/// 1. Column: Main Axis (dọc) & Cross Axis (ngang), căn chỉnh crossAxisAlignment.center
/// 2. Stack & Positioned: Xếp chồng icon chiếc khiên bảo mật lên góc Logo ngân hàng
/// 3. Flexible / SizedBox: Giữ khoảng cách co giãn hài hòa
/// ============================================================================
class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize.min: Chỉ chiếm đúng chiều cao vừa đủ của các con,
      // không chiếm toàn bộ màn hình -> Giúp tránh lỗi unbounded height khi cuộn.
      mainAxisSize: MainAxisSize.min,

      // crossAxisAlignment.center: Căn giữa tất cả các thành phần theo trục ngang (Cross Axis của Column)
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // -------------------------------------------------------------
        // VÍ DỤ MINH HỌA LÝ THUYẾT: STACK VÀ POSITIONED
        // Xếp chồng icon bảo mật (Shield) lên góc Logo tròn của Ngân hàng
        // -------------------------------------------------------------
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Lớp 1: Khối tròn chứa Logo Ngân hàng
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  AppAssets.bankLogo,
                  color: AppColors.textWhite,
                  size: 38,
                ),
              ),
            ),

            // Lớp 2: Positioned ghim icon chiếc khiên xác thực ở góc dưới bên phải
            Positioned(
              bottom: -2,
              right: -2,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: const Icon(
                  AppAssets.shieldSecure,
                  color: AppColors.success,
                  size: 18,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Tên thương hiệu ứng dụng
        Text(
          AppStrings.appTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDark,
                letterSpacing: 0.5,
              ),
        ),

        const SizedBox(height: 6),

        // Lời chào và Slogan - Sử dụng Padding để tạo khoảng cách hợp lý
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            AppStrings.appSlogan,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.3,
                ),
          ),
        ),
      ],
    );
  }
}
