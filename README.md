# DNT Digital Banking - Màn hình Đăng Nhập
> **Chủ đề 2:** Tổ chức bố cục linh hoạt và xử lý không gian trong Flutter.

---

## 1. Cấu trúc thư mục

```text
lib/
├── main.dart
├── core/
│   ├── constants/
│   │   ├── app_colors.dart      # Bảng màu chuẩn Fintech
│   │   ├── app_strings.dart     # Chuỗi văn bản hiển thị
│   │   └── app_assets.dart      # Quản lý Icons hệ thống
│   └── theme/
│       └── app_theme.dart       # Thiết lập ThemeData (Material 3)
└── screens/
    └── login/
        ├── login_screen.dart    # Màn hình chính & xử lý Responsive
        └── widgets/
            ├── login_header.dart       # Logo, tên app, slogan
            ├── account_card.dart       # Thẻ người dùng (chống tràn ngang)
            ├── password_field.dart     # Ô mật khẩu (kích hoạt bàn phím ảo)
            ├── login_button.dart       # Nút đăng nhập chính
            ├── face_id_button.dart     # Nút sinh trắc học Face ID
            ├── login_options_row.dart  # Quên mật khẩu & Smart OTP
            └── login_footer.dart       # Hotline, ATM, Trợ giúp
```

---

## 2. Kiến thức lý thuyết cốt lõi áp dụng

| Lý thuyết | Vị trí áp dụng | Cách thức hoạt động |
| :--- | :--- | :--- |
| **Main / Cross Axis** | `LoginScreen`, `LoginOptionsRow`, `LoginFooter` | • `Column`: Main axis (dọc), Cross axis (ngang - `stretch`).<br>• `Row`: Căn chỉnh linh hoạt với `spaceBetween`, `spaceEvenly` và `center`. |
| **Expanded & Flexible** | `AccountCard`, hàng nút đăng nhập, `LoginOptionsRow` | • **`Expanded`**: Ép nút đăng nhập và text tên chiếm trọn không gian ưu tiên.<br>• **`Flexible(fit: loose)`**: Giúp 2 nút tùy chọn phụ tự co giãn theo nội dung. |
| **Stack & Positioned** | `LoginHeader`, `AccountCard`, `FaceIdButton` | • Ghim icon chiếc khiên bảo mật đè lên góc Logo.<br>• Ghim chấm xanh Online Status đè lên Avatar.<br>• Định vị 2 góc khung ngắm quét Face ID. |
| **Chống Overflow ngang** | `AccountCard` | Dùng **`Expanded`** + **`TextOverflow.ellipsis`** (`maxLines: 1`) để tên dài tự co thành `...` mà không vỡ viền. |
| **Chống Overflow dọc** | `LoginScreen` | Dùng bộ tứ **`LayoutBuilder` + `SingleChildScrollView` + `ConstrainedBox` + `IntrinsicHeight`** giúp tự cuộn khi bàn phím ảo bật lên. |
| **Phân chia không gian** | `LoginScreen` | Dùng **`Spacer()`** đẩy Footer sát đáy màn hình; tự co giãn khi màn hình thay đổi. |
| **Responsive UI** | `LoginScreen` | Trên Tablet / PC (`maxWidth > 600px`), form tự giới hạn 440px căn giữa; trên Mobile trải rộng tự nhiên. |

---

## 3. Hướng dẫn chạy dự án

```bash
# Di chuyển vào thư mục dự án
cd chu_de_tuan12

# Chạy trên trình duyệt Web (Chrome)
flutter run -d chrome

# Hoặc chạy trên ứng dụng máy tính Windows
flutter run -d windows
```
