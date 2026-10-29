import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_assets.dart';

/// ============================================================================
/// [FaceIdButton] - Nút đăng nhập sinh trắc học (Face ID / Vân tay)
/// Áp dụng lý thuyết:
/// 1. Stack & Positioned: Tạo hiệu ứng khung quét góc (Scanner Corner Frame) bao quanh
///    icon sinh trắc học, minh họa trực quan việc xếp chồng các thành phần con.
/// 2. Phân chia không gian hợp lý: Kích thước cố định vuông 52x52 cân xứng với [LoginButton].
/// ============================================================================
class FaceIdButton extends StatelessWidget {
  final VoidCallback? onTap;

  const FaceIdButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: AppStrings.faceIdTooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap ??
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Row(
                      children: [
                        Icon(AppAssets.faceId, color: AppColors.textWhite),
                        SizedBox(width: 10),
                        Text('Đang xác thực sinh trắc học Face ID...'),
                      ],
                    ),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
          borderRadius: BorderRadius.circular(14),
          child: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.2),
                width: 1.5,
              ),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.cardShadow,
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // -------------------------------------------------------------
                // LÝ THUYẾT: STACK VÀ POSITIONED
                // Ghim 2 đường viền góc trang trí giả lập khung máy ảnh quét Face ID
                // -------------------------------------------------------------
                // Góc trên - trái
                Positioned(
                  top: 7,
                  left: 7,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: AppColors.accent, width: 2),
                        left: BorderSide(color: AppColors.accent, width: 2),
                      ),
                    ),
                  ),
                ),

                // Góc dưới - phải
                Positioned(
                  bottom: 7,
                  right: 7,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: AppColors.accent, width: 2),
                        right: BorderSide(color: AppColors.accent, width: 2),
                      ),
                    ),
                  ),
                ),

                // Biểu tượng Face ID ở trung tâm
                const Icon(
                  AppAssets.faceId,
                  color: AppColors.primary,
                  size: 26,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
