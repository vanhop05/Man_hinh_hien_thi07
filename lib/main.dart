import 'package:flutter/material.dart';
import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'screens/login/login_screen.dart';

/// ============================================================================
/// BÀI TẬP / ĐỒ ÁN: CHỦ ĐỀ 2 - TỔ CHỨC BỐ CỤC LINH HOẠT VÀ XỬ LÝ KHÔNG GIAN
/// 
/// Kiến trúc thư mục tuân thủ tuyệt đối cấu trúc yêu cầu:
/// lib/
/// ├── main.dart
/// ├── core/
/// │   ├── constants/
/// │   │   ├── app_colors.dart
/// │   │   ├── app_strings.dart
/// │   │   └── app_assets.dart
/// │   └── theme/
/// │       └── app_theme.dart
/// └── screens/
///     └── login/
///         ├── login_screen.dart
///         └── widgets/
///             ├── login_header.dart
///             ├── account_card.dart
///             ├── password_field.dart
///             ├── login_button.dart
///             ├── login_options_row.dart
///             ├── face_id_button.dart
///             └── login_footer.dart
/// ============================================================================
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const LoginScreen(),
    );
  }
}
