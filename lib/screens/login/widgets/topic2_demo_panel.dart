import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// ============================================================================
/// [Topic2DemoPanel] - Phòng thí nghiệm thực hành tương tác trực quan cho Chủ đề 2:
/// "TỔ CHỨC BỐ CỤC LINH HOẠT VÀ XỬ LÝ KHÔNG GIAN"
///
/// Bao gồm 4 khu vực demo tương tác trực tiếp phục vụ bài thuyết trình 15 phút:
/// 1. Demo Main Axis, Cross Axis và các thuộc tính căn chỉnh (Row & Column).
/// 2. Demo Expanded vs Flexible (So sánh tight fit vs loose fit & flex factor).
/// 3. Demo Stack và Positioned (Điều chỉnh toạ độ xếp chồng theo trục Z).
/// 4. Demo Nguyên nhân Overflow và cách xử lý (Nội dung / Kích thước thay đổi).
/// ============================================================================
class Topic2DemoPanel extends StatefulWidget {
  const Topic2DemoPanel({super.key});

  @override
  State<Topic2DemoPanel> createState() => _Topic2DemoPanelState();
}

class _Topic2DemoPanelState extends State<Topic2DemoPanel> {
  // --- TRẠNG THÁI DEMO 1: MAIN AXIS & CROSS AXIS ---
  bool _isRowLayout = true;
  MainAxisAlignment _selectedMainAxis = MainAxisAlignment.center;
  CrossAxisAlignment _selectedCrossAxis = CrossAxisAlignment.center;

  // --- TRẠNG THÁI DEMO 2: EXPANDED VS FLEXIBLE ---
  bool _useExpanded = true;
  int _flexFactor = 2;

  // --- TRẠNG THÁI DEMO 3: STACK & POSITIONED ---
  double _positionedTop = 15;
  double _positionedLeft = 20;

  // --- TRẠNG THÁI DEMO 4: OVERFLOW LAB ---
  bool _isLongText = false;
  bool _applyRowFix = true;
  double _columnHeight = 180.0;
  bool _applyColumnScrollFix = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        _buildSectionHeader(
          number: '1',
          title: 'Main Axis & Cross Axis',
          subtitle: 'Trục chính, trục phụ và các thuộc tính căn chỉnh',
        ),
        _buildMainCrossAxisDemo(),

        const SizedBox(height: 24),

        _buildSectionHeader(
          number: '2',
          title: 'Expanded vs Flexible',
          subtitle: 'Phân chia không gian: Tight Fit (ép kín) vs Loose Fit (co giãn tự do)',
        ),
        _buildExpandedFlexibleDemo(),

        const SizedBox(height: 24),

        _buildSectionHeader(
          number: '3',
          title: 'Stack & Positioned',
          subtitle: 'Bố cục xếp chồng lớp theo trục Z và định vị toạ độ chính xác',
        ),
        _buildStackPositionedDemo(),

        const SizedBox(height: 24),

        _buildSectionHeader(
          number: '4',
          title: 'Thử nghiệm Overflow & Khắc phục',
          subtitle: 'Demo phản ứng khi Nội dung thay đổi hoặc Kích thước thay đổi',
        ),
        _buildOverflowLabDemo(),

        const SizedBox(height: 32),
      ],
    );
  }

  // ===========================================================================
  // SECTION 1: MAIN AXIS & CROSS AXIS DEMO
  // ===========================================================================
  Widget _buildMainCrossAxisDemo() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          // Nút chọn Row hoặc Column
          Row(
            children: [
              const Text('Loại bố cục: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              ChoiceChip(
                label: const Text('Row (Ngang)'),
                selected: _isRowLayout,
                onSelected: (val) => setState(() => _isRowLayout = true),
              ),
              const SizedBox(width: 8),
              ChoiceChip(
                label: const Text('Column (Dọc)'),
                selected: !_isRowLayout,
                onSelected: (val) => setState(() => _isRowLayout = false),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Bộ chọn MainAxisAlignment
          const Text('MainAxisAlignment (Trục chính):', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _buildChoiceChip(
                'start',
                _selectedMainAxis == MainAxisAlignment.start,
                () => setState(() => _selectedMainAxis = MainAxisAlignment.start),
              ),
              _buildChoiceChip(
                'center',
                _selectedMainAxis == MainAxisAlignment.center,
                () => setState(() => _selectedMainAxis = MainAxisAlignment.center),
              ),
              _buildChoiceChip(
                'end',
                _selectedMainAxis == MainAxisAlignment.end,
                () => setState(() => _selectedMainAxis = MainAxisAlignment.end),
              ),
              _buildChoiceChip(
                'spaceBetween',
                _selectedMainAxis == MainAxisAlignment.spaceBetween,
                () => setState(() => _selectedMainAxis = MainAxisAlignment.spaceBetween),
              ),
              _buildChoiceChip(
                'spaceAround',
                _selectedMainAxis == MainAxisAlignment.spaceAround,
                () => setState(() => _selectedMainAxis = MainAxisAlignment.spaceAround),
              ),
              _buildChoiceChip(
                'spaceEvenly',
                _selectedMainAxis == MainAxisAlignment.spaceEvenly,
                () => setState(() => _selectedMainAxis = MainAxisAlignment.spaceEvenly),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Bộ chọn CrossAxisAlignment
          const Text('CrossAxisAlignment (Trục phụ):', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            children: [
              _buildChoiceChip(
                'start',
                _selectedCrossAxis == CrossAxisAlignment.start,
                () => setState(() => _selectedCrossAxis = CrossAxisAlignment.start),
              ),
              _buildChoiceChip(
                'center',
                _selectedCrossAxis == CrossAxisAlignment.center,
                () => setState(() => _selectedCrossAxis = CrossAxisAlignment.center),
              ),
              _buildChoiceChip(
                'end',
                _selectedCrossAxis == CrossAxisAlignment.end,
                () => setState(() => _selectedCrossAxis = CrossAxisAlignment.end),
              ),
              _buildChoiceChip(
                'stretch',
                _selectedCrossAxis == CrossAxisAlignment.stretch,
                () => setState(() => _selectedCrossAxis = CrossAxisAlignment.stretch),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Sân khấu mô phỏng trực quan
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.25), width: 1.5),
            ),
            child: _isRowLayout
                ? Row(
                    mainAxisAlignment: _selectedMainAxis,
                    crossAxisAlignment: _selectedCrossAxis,
                    children: _buildDemoBoxes(),
                  )
                : Column(
                    mainAxisAlignment: _selectedMainAxis,
                    crossAxisAlignment: _selectedCrossAxis,
                    children: _buildDemoBoxes(),
                  ),
          ),

          const SizedBox(height: 8),
          Text(
            _isRowLayout
                ? '• Row: Main Axis là TRỤC NGANG (X), Cross Axis là TRỤC DỌC (Y).'
                : '• Column: Main Axis là TRỤC DỌC (Y), Cross Axis là TRỤC NGANG (X).',
            style: const TextStyle(fontSize: 11.5, color: AppColors.textSecondary, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    ),
  );
}

  List<Widget> _buildDemoBoxes() {
    return [
      Container(
        width: 44,
        height: 38,
        decoration: BoxDecoration(
          color: const Color(0xFFE63946),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Center(
          child: Text('1', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
      const SizedBox(width: 8, height: 8),
      Container(
        width: 54,
        height: 52,
        decoration: BoxDecoration(
          color: const Color(0xFF2A9D8F),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Center(
          child: Text('2', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
      const SizedBox(width: 8, height: 8),
      Container(
        width: 40,
        height: 34,
        decoration: BoxDecoration(
          color: const Color(0xFFF4A261),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Center(
          child: Text('3', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    ];
  }

  // ===========================================================================
  // SECTION 2: EXPANDED VS FLEXIBLE DEMO
  // ===========================================================================
  Widget _buildExpandedFlexibleDemo() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Row(
            children: [
              const Text('Khối giữa dùng: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              ChoiceChip(
                label: const Text('Expanded (Tight)'),
                selected: _useExpanded,
                onSelected: (val) => setState(() => _useExpanded = true),
              ),
              const SizedBox(width: 8),
              ChoiceChip(
                label: const Text('Flexible (Loose)'),
                selected: !_useExpanded,
                onSelected: (val) => setState(() => _useExpanded = false),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Slider điều chỉnh hệ số flex
          Row(
            children: [
              Text('Hệ số flex khối giữa: $_flexFactor', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
              Expanded(
                child: Slider(
                  value: _flexFactor.toDouble(),
                  min: 1,
                  max: 4,
                  divisions: 3,
                  label: '$_flexFactor',
                  onChanged: (val) => setState(() => _flexFactor = val.toInt()),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Sân khấu mô phỏng
          Container(
            height: 70,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                // Khối 1: Cố định 60px
                Container(
                  width: 60,
                  color: AppColors.primaryLight,
                  child: const Center(
                    child: Text('Cố định\n60px', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                ),

                const SizedBox(width: 8),

                // Khối 2: Expanded hoặc Flexible
                if (_useExpanded)
                  Expanded(
                    flex: _flexFactor,
                    child: Container(
                      color: AppColors.accent,
                      child: Center(
                        child: Text(
                          'Expanded(flex: $_flexFactor)\nÉP LẤP ĐẦY TOÀN BỘ',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
                        ),
                      ),
                    ),
                  )
                else
                  Flexible(
                    flex: _flexFactor,
                    fit: FlexFit.loose,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      color: AppColors.accent,
                      child: Center(
                        child: Text(
                          'Flexible(flex: $_flexFactor)\nCo giãn theo con',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
                        ),
                      ),
                    ),
                  ),

                const SizedBox(width: 8),

                // Khối 3: Expanded flex: 1
                Expanded(
                  flex: 1,
                  child: Container(
                    color: AppColors.primary,
                    child: const Center(
                      child: Text('Expanded\n(flex: 1)', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 10)),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),
          Text(
            _useExpanded
                ? '• Expanded (fit: FlexFit.tight): BẮT BUỘC con phải nở ra chiếm trọn không gian tỉ lệ được chia.'
                : '• Flexible (fit: FlexFit.loose): CHO PHÉP con co giãn tối đa bằng khoảng trống nhưng KHÔNG ép chiếm hết.',
            style: const TextStyle(fontSize: 11.5, color: AppColors.textSecondary, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    ),
  );
}

  // ===========================================================================
  // SECTION 3: STACK & POSITIONED DEMO
  // ===========================================================================
  Widget _buildStackPositionedDemo() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Top: ${_positionedTop.toInt()}px', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                    Slider(
                      value: _positionedTop,
                      min: 0,
                      max: 90,
                      onChanged: (val) => setState(() => _positionedTop = val),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Left: ${_positionedLeft.toInt()}px', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                    Slider(
                      value: _positionedLeft,
                      min: 0,
                      max: 200,
                      onChanged: (val) => setState(() => _positionedLeft = val),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Sân khấu Stack
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: AppColors.cardShadow, blurRadius: 8, offset: Offset(0, 3)),
              ],
            ),
            child: Stack(
              children: [
                // Lớp 1: Nền thẻ ngân hàng (Dưới cùng)
                const Positioned(
                  bottom: 12,
                  left: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('DNT DIGITAL CARD', style: TextStyle(color: Colors.white70, fontSize: 10, letterSpacing: 1.2)),
                      SizedBox(height: 4),
                      Text('**** **** **** 8899', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),

                const Positioned(
                  top: 12,
                  right: 16,
                  child: Icon(Icons.contactless_rounded, color: Colors.white70, size: 24),
                ),

                // Lớp 2: Positioned di động do người dùng điều khiển toạ độ
                Positioned(
                  top: _positionedTop,
                  left: _positionedLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withValues(alpha: 0.25), blurRadius: 6),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.stars_rounded, color: Colors.white, size: 16),
                        SizedBox(width: 4),
                        Text('VIP BADGE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),
          const Text(
            '• Stack xếp chồng các widget theo trục Z (chiều sâu). Positioned định vị chính xác toạ độ top, bottom, left, right.',
            style: TextStyle(fontSize: 11.5, color: AppColors.textSecondary, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    ),
  );
}

  // ===========================================================================
  // SECTION 4: OVERFLOW LAB & FIX DEMO
  // ===========================================================================
  Widget _buildOverflowLabDemo() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          // 4.1 Thử nghiệm ngang: Text dài trong Row
          const Text('4.1 Tràn viền ngang khi nội dung thay đổi (Row Overflow):', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 8),
          Row(
            children: [
              ChoiceChip(
                label: const Text('Nội dung ngắn'),
                selected: !_isLongText,
                onSelected: (val) => setState(() => _isLongText = false),
              ),
              const SizedBox(width: 8),
              ChoiceChip(
                label: const Text('Nội dung SIÊU DÀI'),
                selected: _isLongText,
                onSelected: (val) => setState(() => _isLongText = true),
              ),
            ],
          ),
          const SizedBox(height: 6),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            title: const Text('Bật giải pháp chống Overflow (Expanded + Ellipsis)'),
            value: _applyRowFix,
            onChanged: (val) => setState(() => _applyRowFix = val),
          ),

          // Sân khấu Row Overflow
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                const CircleAvatar(radius: 16, child: Icon(Icons.person, size: 18)),
                const SizedBox(width: 10),

                // So sánh có Expanded vs không có Expanded
                if (_applyRowFix)
                  Expanded(
                    child: Text(
                      _isLongText
                          ? 'NGUYỄN HOÀNG MINH KHANG TRỌNG ĐẠT (NỘI DUNG SIÊU DÀI VƯỢT QUÁ KHẢ NĂNG CHỨA CỦA MÀN HÌNH)'
                          : 'NGUYỄN VĂN AN',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  )
                else
                  Text(
                    _isLongText
                        ? 'NGUYỄN HOÀNG MINH KHANG TRỌNG ĐẠT (NỘI DUNG SIÊU DÀI VƯỢT QUÁ KHẢ NĂNG CHỨA CỦA MÀN HÌNH)'
                        : 'NGUYỄN VĂN AN',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),

                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(6)),
                  child: const Text('Nút', style: TextStyle(color: Colors.white, fontSize: 11)),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // 4.2 Thử nghiệm dọc: Column tràn chiều cao
          const Text('4.2 Tràn viền dọc khi kích thước thay đổi (Column Overflow):', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 4),
          Row(
            children: [
              Text('Chiều cao khung: ${_columnHeight.toInt()}px', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
              Expanded(
                child: Slider(
                  value: _columnHeight,
                  min: 80,
                  max: 220,
                  onChanged: (val) => setState(() => _columnHeight = val),
                ),
              ),
            ],
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            title: const Text('Bật giải pháp cuộn (SingleChildScrollView)'),
            value: _applyColumnScrollFix,
            onChanged: (val) => setState(() => _applyColumnScrollFix = val),
          ),

          // Sân khấu Column Overflow
          Container(
            height: _columnHeight,
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: _applyColumnScrollFix
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: _buildOverflowItems(),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: _buildOverflowItems(),
                  ),
          ),

          const SizedBox(height: 8),
          const Text(
            '• Kéo thanh trượt chiều cao về 80px: Khi TẮT giải pháp, Column sẽ lập tức báo lỗi sọc vàng đen "A RenderFlex overflowed by ... pixels on the bottom". BẬT giải pháp sẽ tự sinh thanh cuộn mượt mà!',
            style: TextStyle(fontSize: 11.5, color: AppColors.error, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ),
  );
}

  List<Widget> _buildOverflowItems() {
    return [
      Container(
        height: 38,
        margin: const EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(color: AppColors.primaryLight.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(6)),
        child: const Center(child: Text('Phần tử 1: Tiêu đề giao dịch', style: TextStyle(fontSize: 12))),
      ),
      Container(
        height: 38,
        margin: const EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(color: AppColors.accent.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(6)),
        child: const Center(child: Text('Phần tử 2: Thông tin chuyển khoản', style: TextStyle(fontSize: 12))),
      ),
      Container(
        height: 38,
        margin: const EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(6)),
        child: const Center(child: Text('Phần tử 3: Xác thực OTP', style: TextStyle(fontSize: 12))),
      ),
      Container(
        height: 38,
        decoration: BoxDecoration(color: AppColors.warning.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(6)),
        child: const Center(child: Text('Phần tử 4: Chữ ký số', style: TextStyle(fontSize: 12))),
      ),
    ];
  }

  Widget _buildSectionHeader({
    required String number,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 4),
            ],
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.primaryDark),
              ),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChoiceChip(String label, bool isSelected, VoidCallback onSelected) {
    return InkWell(
      onTap: onSelected,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
