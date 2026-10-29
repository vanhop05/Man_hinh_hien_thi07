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
import 'widgets/topic2_demo_panel.dart';

/// ============================================================================
/// [LoginScreen] - Màn hình chính triển khai trọn vẹn:
/// CHỦ ĐỀ 2: TỔ CHỨC BỐ CỤC LINH HOẠT VÀ XỬ LÝ KHÔNG GIAN
///
/// Tích hợp 2 chế độ hiển thị:
/// 1. Màn hình Đăng Nhập thực tế (Gồm 7 widgets thành phần theo đúng cấu trúc đề bài).
/// 2. Phòng Demo tương tác Chủ đề 2 (Trực quan hoá Main/Cross axis, Expanded vs Flexible,
///    Stack & Positioned, và Thử nghiệm Overflow khi kích thước / nội dung thay đổi).
/// ============================================================================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  // Chế độ xem: 0 = Màn hình Đăng nhập (Thực hành), 1 = Phòng Demo Chủ đề 2 (Lý thuyết tương tác)
  int _currentTabIndex = 0;

  // --- TRẠNG THÁI DEMO TRÊN MÀN HÌNH ĐĂNG NHẬP ---
  bool _isLongNameDemo = false; // Demo nội dung thay đổi (Tên siêu dài)
  bool _simulateOverflowBug = false; // Demo so sánh: Layout lỗi vs Layout chuẩn

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
      appBar: _buildDemoAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            // Thanh chuyển đổi chế độ thuyết trình (Presentation Switcher)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: AppColors.surface,
              child: SizedBox(
                width: double.infinity,
                child: SegmentedButton<int>(
                  segments: const [
                    ButtonSegment<int>(
                      value: 0,
                      icon: Icon(Icons.phone_android_rounded, size: 18),
                      label: Text('Màn hình Đăng nhập', style: TextStyle(fontSize: 12.5)),
                    ),
                    ButtonSegment<int>(
                      value: 1,
                      icon: Icon(Icons.science_rounded, size: 18),
                      label: Text('Demo Bố cục Chủ đề 2', style: TextStyle(fontSize: 12.5)),
                    ),
                  ],
                  selected: {_currentTabIndex},
                  onSelectionChanged: (Set<int> newSelection) {
                    setState(() {
                      _currentTabIndex = newSelection.first;
                    });
                  },
                  style: ButtonStyle(
                    visualDensity: VisualDensity.compact,
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ),
            ),

            // Thân giao diện theo Tab đã chọn
            Expanded(
              child: _currentTabIndex == 0
                  ? _buildLoginScreenView()
                  : const Topic2DemoPanel(),
            ),
          ],
        ),
      ),
    );
  }

  /// Giao diện Màn hình Đăng nhập hoàn chỉnh (Ứng dụng thực tế)
  Widget _buildLoginScreenView() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // =====================================================================
        // LÝ THUYẾT: BỐ CỤC LINH HOẠT & PHÂN CHIA KHÔNG GIAN HỢP LÝ
        // - Trên màn hình rộng (Tablet / Landscape > 600px): Giới hạn độ rộng Form
        //   tối đa 460px và căn giữa.
        // - Trên màn hình điện thoại (< 600px): Co giãn tối đa theo chiều ngang.
        // =====================================================================
        final bool isWideScreen = constraints.maxWidth > 600;
        final double horizontalPadding = isWideScreen ? 32.0 : 20.0;
        final double maxFormWidth = isWideScreen ? 460.0 : double.infinity;

        // Nếu bật demo mô phỏng lỗi overflow để trình chiếu:
        if (_simulateOverflowBug) {
          return _buildBuggyLayout();
        }

        // =====================================================================
        // GIẢI PHÁP CHUẨN TRỊ TRIỆT ĐỂ OVERFLOW:
        // LayoutBuilder + SingleChildScrollView + ConstrainedBox + IntrinsicHeight
        // - Màn hình cao: Spacer() tự bung đẩy Footer xuống sát đáy.
        // - Bật bàn phím ảo hoặc màn hình nhỏ: Tự cuộn mượt mà, KHÔNG OVERFLOW!
        // =====================================================================
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxFormWidth),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 16.0,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 32.0,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 8),

                      // 1. Header (Logo, Tên ngân hàng, Slogan)
                      const LoginHeader(),

                      const SizedBox(height: 22),

                      // 2. Thẻ tài khoản (Account Card)
                      // Minh họa Expanded & TextOverflow khi tên dài
                      AccountCard(
                        accountName: _isLongNameDemo
                            ? AppStrings.longAccountNameDemo
                            : AppStrings.defaultAccountName,
                        onSwitchAccount: () {
                          setState(() {
                            _isLongNameDemo = !_isLongNameDemo;
                          });
                        },
                      ),

                      const SizedBox(height: 18),

                      // 3. Ô nhập mật khẩu (Password Field)
                      // Tương tác trực tiếp với bàn phím ảo
                      PasswordField(
                        controller: _passwordController,
                        onSubmitted: (_) => _handleLogin(),
                      ),

                      const SizedBox(height: 20),

                      // 4. Hàng nút Đăng Nhập + Face ID
                      // Minh họa Phân chia không gian: Expanded(flex: 4) + Fixed 52x52
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: LoginButton(
                              isLoading: _isLoading,
                              onPressed: _handleLogin,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const FaceIdButton(),
                        ],
                      ),

                      const SizedBox(height: 14),

                      // 5. Hàng tùy chọn phụ trợ (Quên mật khẩu / Smart OTP)
                      // Minh họa Row với MainAxisAlignment.spaceBetween & Flexible
                      const LoginOptionsRow(),

                      // Spacer đẩy Footer xuống đáy khi đủ chiều cao
                      const Spacer(),

                      const SizedBox(height: 24),

                      // 6. Chân trang (Footer)
                      const LoginFooter(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// AppBar tích hợp các nút Demo phục vụ buổi thuyết trình 15 phút
  PreferredSizeWidget _buildDemoAppBar() {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0.5,
      title: const Row(
        children: [
          Icon(Icons.dashboard_customize_rounded, color: AppColors.primary, size: 20),
          SizedBox(width: 8),
          Text(
            'Chủ đề 2: Bố cục & Không gian',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
      actions: [
        if (_currentTabIndex == 0) ...[
          // Nút đổi tên ngắn/dài để demo TextOverflow
          IconButton(
            tooltip: AppStrings.toggleLongName,
            icon: Icon(
              _isLongNameDemo ? Icons.text_snippet : Icons.text_snippet_outlined,
              color: _isLongNameDemo ? AppColors.warning : AppColors.textSecondary,
            ),
            onPressed: () {
              setState(() {
                _isLongNameDemo = !_isLongNameDemo;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    _isLongNameDemo
                        ? 'Đã bật Tên dài để kiểm tra Expanded & Ellipsis'
                        : 'Đã hoàn lại Tên mặc định',
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),

          // Nút mô phỏng layout lỗi khi chưa áp dụng giải pháp chống Overflow
          IconButton(
            tooltip: AppStrings.toggleOverflowFix,
            icon: Icon(
              _simulateOverflowBug ? Icons.bug_report : Icons.bug_report_outlined,
              color: _simulateOverflowBug ? AppColors.error : AppColors.textSecondary,
            ),
            onPressed: () {
              setState(() {
                _simulateOverflowBug = !_simulateOverflowBug;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    _simulateOverflowBug
                        ? 'Đang mô phỏng Bố cục LỖI (Bấm vào ô mật khẩu để kích hoạt bàn phím xem lỗi tràn)'
                        : 'Đã quay về Bố cục CHUẨN (Kháng tràn viền 100%)',
                  ),
                  backgroundColor:
                      _simulateOverflowBug ? AppColors.error : AppColors.success,
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ],

        // Nút mở Bảng tóm tắt lý thuyết nhanh
        IconButton(
          tooltip: AppStrings.theoryCheatSheet,
          icon: const Icon(AppAssets.theory, color: AppColors.primary),
          onPressed: () => _showTheoryModal(context),
        ),
      ],
    );
  }

  /// Layout mô phỏng lỗi khi lập trình viên KHÔNG áp dụng giải pháp SingleChildScrollView.
  Widget _buildBuggyLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.error),
            ),
            child: const Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: AppColors.error, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'ĐANG DEMO LỖI: Column cố định không có Scroll. Bấm vào ô mật khẩu bên dưới để kích hoạt bàn phím và xem lỗi Overflow!',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const LoginHeader(),
          const SizedBox(height: 20),
          AccountCard(
            accountName: _isLongNameDemo
                ? AppStrings.longAccountNameDemo
                : AppStrings.defaultAccountName,
          ),
          const SizedBox(height: 16),
          PasswordField(controller: _passwordController),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: LoginButton(onPressed: _handleLogin)),
              const SizedBox(width: 12),
              const FaceIdButton(),
            ],
          ),
          const SizedBox(height: 12),
          const LoginOptionsRow(),
          const Spacer(),
          const LoginFooter(),
        ],
      ),
    );
  }

  /// Modal BottomSheet tóm tắt toàn bộ lý thuyết Chủ đề 2 phục vụ bài thuyết trình
  void _showTheoryModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.75,
          maxChildSize: 0.95,
          minChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) {
            return ListView(
              controller: scrollController,
              padding: const EdgeInsets.all(20),
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'CHỦ ĐỀ 2: TỔ CHỨC BỐ CỤC LINH HOẠT VÀ XỬ LÝ KHÔNG GIAN',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                _buildTheoryItem(
                  title: '1. Main Axis & Cross Axis và thuộc tính căn chỉnh',
                  desc:
                      '• Row: Trục chính (Main Axis) là chiều ngang, Trục phụ (Cross Axis) là chiều dọc.\n'
                      '• Column: Trục chính (Main Axis) là chiều dọc, Trục phụ (Cross Axis) là chiều ngang.\n'
                      '• mainAxisAlignment: start, center, end, spaceBetween, spaceAround, spaceEvenly.\n'
                      '• crossAxisAlignment: start, center, end, stretch.',
                ),
                _buildTheoryItem(
                  title: '2. Expanded, Flexible, Stack và Positioned',
                  desc:
                      '• Expanded (fit: FlexFit.tight): Ép widget con phải lấp đầy toàn bộ khoảng trống còn lại dọc theo Main Axis.\n'
                      '• Flexible (fit: FlexFit.loose): Cho phép co giãn theo không gian nhưng không ép phải chiếm hết.\n'
                      '• Stack & Positioned: Xếp chồng widget theo chiều sâu (trục Z). Positioned định vị chính xác toạ độ top, bottom, left, right.',
                ),
                _buildTheoryItem(
                  title: '3. Nguyên nhân Overflow & Cách xử lý',
                  desc:
                      '• Nguyên nhân 1: Nội dung con trong Row/Column vượt quá kích thước cha -> Khắc phục: Dùng Expanded/Flexible kết hợp TextOverflow.ellipsis hoặc Wrap.\n'
                      '• Nguyên nhân 2: Bàn phím ảo xuất hiện đẩy Column vượt quá chiều cao màn hình -> Khắc phục: Sử dụng bộ 4 LayoutBuilder + SingleChildScrollView + ConstrainedBox + IntrinsicHeight.',
                ),
                _buildTheoryItem(
                  title: '4. Yêu cầu thực hành và demo (15 phút/nhóm)',
                  desc:
                      '• Bố cục nhiều thành phần: Triển khai 7 widgets hoàn chỉnh phân chia không gian tối ưu trong Màn hình Đăng nhập.\n'
                      '• Demo phản ứng khi kích thước hoặc nội dung thay đổi: Bấm Tab "Demo Bố cục Chủ đề 2" để trực tiếp tương tác với các thanh trượt và nút bấm.',
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildTheoryItem({required String title, required String desc}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDark,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            desc,
            style: const TextStyle(
              fontSize: 12.5,
              color: AppColors.textPrimary,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}
