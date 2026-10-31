import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_assets.dart';
import 'widgets/login_header.dart';
import 'widgets/account_card.dart';
import 'widgets/password_field.dart';
import 'widgets/login_button.dart';
import 'widgets/face_id_button.dart';
import 'widgets/login_options_row.dart';
import 'widgets/login_footer.dart';

/// ============================================================================
/// [LoginScreen] - Màn hình Đăng Nhập chuẩn mực
/// 
/// Áp dụng đầy đủ và trọn vẹn Cơ sở Lý thuyết & Yêu cầu thực hành Chủ đề 2:
/// 1. MAIN AXIS, CROSS AXIS VÀ CÁC THUỘC TÍNH CĂN CHỈNH:
///    - Column: Trục chính (Main Axis) dọc, Trục phụ (Cross Axis) ngang.
///      Dùng `crossAxisAlignment: CrossAxisAlignment.stretch` để kéo giãn đều các phần tử.
///    - Row trong các widget con: Tùy biến `mainAxisAlignment` (spaceBetween, spaceEvenly, start)
///      và `crossAxisAlignment: CrossAxisAlignment.center` để căn chỉnh hoàn hảo.
///
/// 2. EXPANDED, FLEXIBLE, STACK VÀ POSITIONED:
///    - `Expanded`: Bọc `LoginButton` trong Row để chiếm trọn không gian ưu tiên;
///      bọc thông tin văn bản trong `AccountCard` để tự động dãn theo chiều ngang.
///    - `Flexible`: Sử dụng trong `LoginOptionsRow` với `fit: FlexFit.loose` giúp 2 nút
///      tùy chọn phụ thích ứng tự do theo kích thước nhãn văn bản.
///    - `Stack` & `Positioned`:
///      + Trong `LoginHeader`: Xếp chồng biểu tượng bảo mật lên góc Logo ngân hàng.
///      + Trong `AccountCard`: Ghim chấm trạng thái Online ở góc Avatar.
///      + Trong `FaceIdButton`: Ghim khung viền máy quét sinh trắc học ở 2 góc đối xứng.
///
/// 3. NGUYÊN NHÂN GÂY OVERFLOW VÀ CÁCH XỬ LÝ:
///    - Tràn viền ngang: Tên người dùng quá dài -> Xử lý bằng `Expanded` + `TextOverflow.ellipsis`.
///    - Tràn viền dọc: Bàn phím ảo đẩy giao diện lên khi gõ mật khẩu hoặc khi xoay ngang máy
///      -> Xử lý triệt để bằng bộ 4:
///      `LayoutBuilder` + `SingleChildScrollView` + `ConstrainedBox(minHeight)` + `IntrinsicHeight`.
///
/// 4. YÊU CẦU THỰC HÀNH & PHẢN ỨNG KHI KÍCH THƯỚC / NỘI DUNG THAY ĐỔI:
///    - Phân chia không gian nhiều thành phần với 7 widgets độc lập và `Spacer()`.
///    - Kích thước thay đổi: Tự co giãn theo màn hình (Desktop/Web/Tablet giới hạn max 440px căn giữa,
///      Mobile trải rộng tự nhiên).
///    - Nội dung thay đổi: Bấm nút "Đổi tài khoản" trên thẻ để chứng minh tên dài tự co gọn bằng `...`.
/// ============================================================================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  // Trạng thái tài khoản: Minh họa bố cục phản ứng khi nội dung thay đổi
  int _accountIndex = 0;

  String get _currentAccountName {
    switch (_accountIndex) {
      case 1:
        return AppStrings.subAccountName;
      case 2:
        return AppStrings.longAccountName;
      default:
        return AppStrings.defaultAccountName;
    }
  }

  String get _currentAccountNumber {
    switch (_accountIndex) {
      case 1:
        return AppStrings.subAccountNumber;
      case 2:
        return AppStrings.longAccountNumber;
      default:
        return AppStrings.defaultAccountNumber;
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.passwordRequired),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle_outline, color: AppColors.textWhite),
                SizedBox(width: 10),
                Text('Đăng nhập thành công! Chào mừng trở lại.'),
              ],
            ),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0.5,
        centerTitle: true,
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(AppAssets.bankLogo, color: AppColors.primary, size: 22),
            SizedBox(width: 8),
            Text(
              AppStrings.appTitle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDark,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Hỗ trợ khách hàng',
            icon: const Icon(AppAssets.hotline, color: AppColors.primary, size: 20),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Tổng đài hỗ trợ 24/7: 1900 6868'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        // ---------------------------------------------------------------------
        // LÝ THUYẾT: BỐ CỤC PHẢN ỨNG KHI KÍCH THƯỚC THAY ĐỔI (RESPONSIVE)
        // LayoutBuilder cung cấp BoxConstraints (maxWidth, maxHeight).
        // - Màn hình lớn (Tablet, PC, Xoay ngang > 600px): Giới hạn khung 440px căn giữa.
        // - Màn hình điện thoại (< 600px): Co giãn tự nhiên theo chiều ngang.
        // ---------------------------------------------------------------------
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isWideScreen = constraints.maxWidth > 600;
            final double horizontalPadding = isWideScreen ? 32.0 : 20.0;
            final double maxFormWidth = isWideScreen ? 440.0 : double.infinity;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxFormWidth),
                // -------------------------------------------------------------
                // LÝ THUYẾT: XỬ LÝ TRIỆT ĐỂ LỖI OVERFLOW TRỤC DỌC (BOTTOM OVERFLOW)
                // Khi bàn phím ảo bật lên hoặc trên màn hình chiều cao thấp:
                // SingleChildScrollView + ConstrainedBox(minHeight) + IntrinsicHeight
                // đảm bảo:
                // 1. Màn hình bình thường: Spacer() bung ra đẩy Footer xuống đáy.
                // 2. Mở bàn phím: Spacer() co lại, toàn bộ trang tự cuộn mượt mà,
                //    KHÔNG BAO GIỜ bị lỗi dải sọc vàng đen!
                // -------------------------------------------------------------
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 16.0,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 32.0, // Trừ padding trên dưới
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        // Main Axis (Dọc): Bắt đầu từ đỉnh xuống
                        mainAxisAlignment: MainAxisAlignment.start,
                        // Cross Axis (Ngang): Kéo giãn các widget con đều theo chiều ngang
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 12),

                          // 1. Header (Logo, Tên ngân hàng, Slogan)
                          // Áp dụng: Column (crossAxisAlignment.center) & Stack + Positioned
                          const LoginHeader(),

                          const SizedBox(height: 24),

                          // 2. Thẻ tài khoản (Account Card)
                          // Áp dụng: Row, Stack + Positioned, Expanded chống overflow khi tên dài.
                          // Phản ứng khi nội dung thay đổi: Nhấn "Đổi tài khoản" để toggle tên ngắn / dài!
                          AccountCard(
                            accountName: _currentAccountName,
                            accountNumber: _currentAccountNumber,
                            onSwitchAccount: () {
                              setState(() {
                                _accountIndex = (_accountIndex + 1) % 3;
                              });
                            },
                          ),

                          const SizedBox(height: 18),

                          // 3. Ô nhập mật khẩu (Password Field)
                          // Tác nhân kích hoạt bàn phím ảo để kiểm chứng cơ chế chống Overflow dọc
                          PasswordField(
                            controller: _passwordController,
                            onSubmitted: (_) => _handleLogin(),
                          ),

                          const SizedBox(height: 20),

                          // 4. Hàng nút Đăng Nhập + Face ID
                          // Áp dụng: Phân chia không gian với Row + Expanded + Kích thước cố định
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Nút Đăng nhập chính chiếm trọn không gian khả dụng còn lại
                              Expanded(
                                child: LoginButton(
                                  isLoading: _isLoading,
                                  onPressed: _handleLogin,
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Nút sinh trắc học cố định kích thước 52x52 (áp dụng Stack & Positioned)
                              const FaceIdButton(),
                            ],
                          ),

                          const SizedBox(height: 14),

                          // 5. Hàng tùy chọn phụ trợ (Quên mật khẩu / Smart OTP)
                          // Áp dụng: Row (mainAxisAlignment: spaceBetween) & Flexible(fit: loose)
                          const LoginOptionsRow(),

                          // ---------------------------------------------------
                          // LÝ THUYẾT: PHÂN CHIA KHÔNG GIAN HỢP LÝ VỚI SPACER()
                          // Tự động chiếm trọn khoảng trống dư thừa để đẩy Footer
                          // xuống sát mép dưới màn hình.
                          // ---------------------------------------------------
                          const Spacer(),

                          const SizedBox(height: 24),

                          // 6. Chân trang (Login Footer)
                          // Áp dụng: Row (mainAxisAlignment: spaceEvenly)
                          const LoginFooter(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
