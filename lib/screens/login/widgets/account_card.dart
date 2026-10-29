import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_assets.dart';

/// ============================================================================
/// [AccountCard] - Thẻ hiển thị thông tin tài khoản người dùng
/// Áp dụng lý thuyết:
/// 1. Row: Main Axis (ngang) & Cross Axis (dọc), căn chỉnh crossAxisAlignment.center
/// 2. Stack & Positioned: Đặt chấm trạng thái "Đang hoạt động" (Online Badge) đè lên góc Avatar
/// 3. Expanded vs Flexible: Bọc thông tin Text bằng Expanded để tự co giãn và chống lỗi
///    "A RenderFlex overflowed by xxx pixels on the right" khi tên người dùng quá dài!
/// ============================================================================
class AccountCard extends StatelessWidget {
  final String accountName;
  final String accountNumber;
  final VoidCallback? onSwitchAccount;

  const AccountCard({
    super.key,
    this.accountName = AppStrings.defaultAccountName,
    this.accountNumber = AppStrings.defaultAccountNumber,
    this.onSwitchAccount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        // Main Axis (ngang): Bắt đầu từ mép trái
        mainAxisAlignment: MainAxisAlignment.start,
        // Cross Axis (dọc): Căn giữa toàn bộ thành phần theo chiều cao thẻ
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // -------------------------------------------------------------
          // LÝ THUYẾT: STACK VÀ POSITIONED
          // Ghim chấm tròn xanh lá cây thể hiện Online status ở góc Avatar
          // -------------------------------------------------------------
          Stack(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: AppColors.primaryLight.withValues(alpha: 0.15),
                child: const Icon(
                  AppAssets.userAvatar,
                  color: AppColors.primary,
                  size: 28,
                ),
              ),
              Positioned(
                bottom: 1,
                right: 1,
                child: Container(
                  width: 13,
                  height: 13,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.surface,
                      width: 2.2,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(width: 14),

          // --------------------------------------------------------------------
          // LÝ THUYẾT: EXPANDED VÀ XỬ LÝ NGUYÊN NHÂN GÂY OVERFLOW
          // Giải thích: Row có chiều rộng giới hạn. Nếu không bọc Expanded, khi
          // accountName dài hơn chiều rộng khả dụng, Flutter sẽ báo lỗi:
          // "A RenderFlex overflowed by xxx pixels on the right".
          // Expanded ép Column này chiếm trọn không gian còn lại (fit: FlexFit.tight)
          // và kết hợp TextOverflow.ellipsis để chữ tự động rút gọn dấu '...' an toàn.
          // --------------------------------------------------------------------
          Expanded(
            child: Column(
              // Cross Axis của Column (ngang): Căn lề trái toàn bộ chữ
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  accountName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis, // Rút gọn bằng dấu ... khi tràn chữ
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.credit_card_rounded,
                      size: 13,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      accountNumber,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Nút bấm "Đổi tài khoản" (Switch Account Button)
          InkWell(
            onTap: onSwitchAccount,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.2),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    AppAssets.switchUser,
                    size: 14,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 4),
                  Text(
                    AppStrings.switchAccount,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
