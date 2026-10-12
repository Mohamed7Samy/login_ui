import 'package:flutter/material.dart';
import 'package:inst_meters/theme/app_colors.dart';

class CustomMainButton extends StatelessWidget {
  const CustomMainButton({super.key, required this.isLoading, this.onPressed, required this.label, this.image,});
  final bool isLoading;
  final Function()? onPressed;
  final String label;
   final Widget? image;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 24),
      width: double.infinity,
      height: 56,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.logColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: isLoading ? CircularProgressIndicator()  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(label),
                  if (image != null) ...[
                    image!,
                    const SizedBox(width: 10),
                  ],
                 
                ],
              ),
      ),
    );
  }
}
