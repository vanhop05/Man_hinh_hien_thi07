import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_assets.dart';

/// ============================================================================
/// [LoginFooter] - Chân trang ứng dụng (Footer)
/// Áp dụng lý thuyết:
/// 1. Row: mainAxisAlignment.spaceEvenly phân chia khoảng cách đều đặn giữa các nút hỗ trợ.
/// 2. Phân chia không gian hợp lý: Kết hợp Column và Divider tạo cảm giác ngăn nắp.
/// 3. Phối hợp với Spacer() trong LoginScreen: Tự động ghim xuống đáy màn hình khi đủ chỗ,
///    và cuộn mượt mà khi màn hình bị thu nhỏ hoặc mở bàn phím (không bị lỗi Overflow).
/// ============================================================================
class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Đường kẻ ngăn cách mờ
        const Divider(color: AppColors.border, height: 1),

        const SizedBox(height: 14),

        // Hàng tiện ích hỗ trợ khách hàng
        // mainAxisAlignment.spaceEvenly: Chia đều khoảng cách các thành phần trong Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildFooterItem(
              context: context,
              icon: AppAssets.hotline,
              label: AppStrings.hotline,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Gọi tổng đài hỗ trợ: 1900 6868')),
                );
              },
            ),
            _buildDivider(),
            _buildFooterItem(
              context: context,
              icon: AppAssets.branchAtm,
              label: AppStrings.findAtm,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Mở bản đồ tìm kiếm điểm ATM / Chi nhánh')),
                );
              },
            ),
            _buildDivider(),
            _buildFooterItem(
              context: context,
              icon: AppAssets.help,
              label: AppStrings.supportFaq,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Trung tâm Trợ giúp & Câu hỏi thường gặp')),
                );
              },
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Thông tin phiên bản và chủ đề bài học
        const Text(
          AppStrings.appVersion,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            color: AppColors.textHint,
            fontWeight: FontWeight.w400,
          ),
        ),

        const SizedBox(height: 8),
      ],
    );
  }

  /// Widget con hiển thị từng mục trong Footer
  Widget _buildFooterItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 15,
              color: AppColors.primaryLight,
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Vạch phân cách đứng mảnh giữa các mục
  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 14,
      color: AppColors.border,
    );
  }
}
