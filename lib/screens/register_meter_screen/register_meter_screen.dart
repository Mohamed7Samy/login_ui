import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inst_meters/theme/app_colors.dart';
import 'package:inst_meters/widgets/app_text_styles.dart';
import 'package:inst_meters/widgets/custom_main_button.dart';

class RegisterMeterScreen extends StatefulWidget {
  const RegisterMeterScreen({
    super.key,
    this.meterTitle = "عداد الشقة ٣ · مبنى ١٢",
    this.statusLabel = "غير مسجل",
  });
  static const String routeName = "/registerMeterScreen";

  final String meterTitle;
  final String statusLabel;

  @override
  State<RegisterMeterScreen> createState() => _RegisterMeterScreenState();
}

class _RegisterMeterScreenState extends State<RegisterMeterScreen> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController meterNumberController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    addressController.dispose();
    meterNumberController.dispose();
    super.dispose();
  }

  Future<void> onTakePhoto() async {
    
  }

  Future<void> onScanQr() async {
    
  }

  Future<void> onSave() async {
    FocusScope.of(context).unfocus();
    if (!_formState.currentState!.validate()) return;

    setState(() => isLoading = true);
    
    if (!mounted) return;
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formState,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    _Header(),
                    SizedBox(height: 26.h),
                    _MeterBanner(
                      title: widget.meterTitle,
                      status: widget.statusLabel,
                    ),
                    SizedBox(height: 14.h),

                    // صورة العداد
                    const _FieldLabel("صورة العداد المركب *"),
                    _PhotoPickerBox(onTap: onTakePhoto),
                    SizedBox(height: 14.h),

                    // العنوان
                    const _FieldLabel("العنوان ومكان التركيب *"),
                    TextFormField(
                      controller: addressController,
                      minLines: 1,
                      maxLines: 3,
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      style: AppTextStyles.styleS14W400(
                        color: AppColors.mainColors,
                      ).copyWith(fontSize: 14.sp),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "أدخل العنوان وحدد مكان العداد داخل المنزل أو الموقع.";
                        }
                        return null;
                      },
                      decoration: _inputDecoration(
                        hintText: "الشارع، المبنى، الطابق ومكان العداد داخل الموقع",
                        icon: Icons.location_on_outlined,
                        verticalPadding: 22.h,
                      ),
                    ),
                    SizedBox(height: 14.h),

                    // رمز QR
                    const _FieldLabel("رمز العداد *"),
                    _ScanQrButton(onTap: onScanQr),
                    SizedBox(height: 14.h),

                    // رقم العداد
                    const _FieldLabel("رقم العداد *"),
                    TextFormField(
                      controller: meterNumberController,
                      keyboardType: TextInputType.text,
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      style: AppTextStyles.styleS14W400(
                        color: AppColors.mainColors,
                      ).copyWith(fontSize: 14.sp),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "يرجي ادخال رقم العداد!!";
                        }
                        return null;
                      },
                      decoration: _inputDecoration(
                        hintText: "أدخل الرقم المطبوع على العداد",
                        icon: Icons.tag,
                        verticalPadding: 18.h,
                      ),
                    ),
                    SizedBox(height: 18.h),

                    Text(
                      "الحقول بعلامة * مطلوبة لإتمام التسجيل.",
                      style: AppTextStyles.styleS14W400(
                        color: AppColors.lightSecTextColor,
                      ).copyWith(fontSize: 12.sp),
                    ),

                    // الزرار: LTR عشان الأيقونة تبقى يمين النص زي التصميم
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: CustomMainButton(
                        isLoading: isLoading,
                        label: "حفظ التسجيل",
                        image: const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.check,
                            color: AppColors.whiteColor,
                            size: 22,
                          ),
                        ),
                        onPressed: onSave,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // الأيقونة في suffix لأن الصفحة RTL (فتظهر على الشمال زي التصميم)
  InputDecoration _inputDecoration({
    required String hintText,
    required IconData icon,
    required double verticalPadding,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: AppColors.surfaceColor,
      hintText: hintText,
      hintStyle: AppTextStyles.styleS14W400(
        color: AppColors.lightSecTextColor,
      ).copyWith(fontSize: 14.sp),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: verticalPadding,
      ),
      suffixIcon: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Icon(icon, color: AppColors.lightSecTextColor, size: 22),
      ),
      suffixIconConstraints: BoxConstraints(minWidth: 46.w, minHeight: 40),
      errorStyle: AppTextStyles.styleS14W400(
        color: AppColors.errorDarkColor,
      ).copyWith(fontSize: 12.sp),
      border: _buildBorder(),
      enabledBorder: _buildBorder(),
      focusedBorder: _buildBorder(color: AppColors.logColor),
      errorBorder: _buildBorder(color: AppColors.errorDarkColor),
      focusedErrorBorder: _buildBorder(color: AppColors.errorDarkColor),
    );
  }

  OutlineInputBorder _buildBorder({Color color = AppColors.borderColor}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: color),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _HeaderIconButton(
          icon: Icons.arrow_forward,
          color: AppColors.mainColors,
          onTap: () => Navigator.of(context).maybePop(),
        ),
        SizedBox(width: 14.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "تسجيل العداد",
                style: AppTextStyles.styleS22W700(
                  color: AppColors.mainColors,
                ).copyWith(fontSize: 24.sp),
              ),
              SizedBox(height: 4.h),
              Text(
                "الخطوة ١ من ٢ · إدخال البيانات",
                style: AppTextStyles.styleS14W400(
                  color: AppColors.lightSecTextColor,
                ),
              ),
            ],
          ),
        ),
        _HeaderIconButton(
          icon: Icons.help_outline,
          color: AppColors.lightSecTextColor,
          onTap: () {},
        ),
      ],
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceColor,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: SizedBox(
          width: 42.w,
          height: 42.w,
          child: Icon(icon, color: color, size: 22),
        ),
      ),
    );
  }
}

class _MeterBanner extends StatelessWidget {
  const _MeterBanner({required this.title, required this.status});
  final String title;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: AppColors.accentSoftColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.styleS16W700(
                color: AppColors.mainColors,
              ).copyWith(fontSize: 17.sp),
            ),
          ),
          Text(
            status,
            style: AppTextStyles.styleS14W700(color: AppColors.accentDarkColor),
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Text(
        text,
        style: AppTextStyles.styleS14W600(
          color: AppColors.mainColors,
        ).copyWith(fontSize: 15.sp),
      ),
    );
  }
}

class _PhotoPickerBox extends StatelessWidget {
  const _PhotoPickerBox({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _DashedBorderPainter(
        color: AppColors.accentBorderColor,
        radius: 12.r,
      ),
      child: Material(
        color: AppColors.accentSoftColor,
        borderRadius: BorderRadius.circular(12.r),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            width: double.infinity,
            height: 125.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.photo_camera_outlined,
                  color: AppColors.logColor,
                  size: 30,
                ),
                SizedBox(height: 10.h),
                Text(
                  "التقط صورة العداد",
                  style: AppTextStyles.styleS16W700(
                    color: AppColors.accentDarkColor,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  "أظهر العداد كاملاً ورقمه بوضوح",
                  style: AppTextStyles.styleS14W400(
                    color: AppColors.lightSecTextColor,
                  ).copyWith(fontSize: 12.sp),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ScanQrButton extends StatelessWidget {
  const _ScanQrButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.whiteColor,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: const BorderSide(color: AppColors.accentBorderColor),
      ),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: double.infinity,
          height: 55.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.qr_code_scanner,
                color: AppColors.logColor,
                size: 22,
              ),
              SizedBox(width: 12.w),
              Text(
                "مسح رمز QR",
                style: AppTextStyles.styleS16W700(
                  color: AppColors.accentDarkColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  _DashedBorderPainter({required this.color, required this.radius});
  final Color color;
  final double radius;
  static const double dashWidth = 5;
  static const double dashGap = 4;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0.5, 0.5, size.width - 1, size.height - 1),
          Radius.circular(radius),
        ),
      );

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter old) =>
      old.color != color || old.radius != radius;
}
