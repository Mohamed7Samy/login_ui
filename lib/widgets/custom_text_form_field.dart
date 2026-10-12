// import 'package:flutter/material.dart';
// import 'package:inst_meters/theme/app_colors.dart';
// import 'package:inst_meters/widgets/app_text_styles.dart';

// class CustomTextFormField extends StatefulWidget {
//   const CustomTextFormField({
//     super.key,
//     this.label,
//     this.isPassword = false,
//     this.prefixIcon,
//     this.validator,
//     this.controller,
//     this.title,
//     this.maxLines = 1,
//     this.hintText,
//   });
//   final String? label, title, hintText;
//   final String? prefixIcon;
//   final bool isPassword;
//   final int maxLines;
//   final TextEditingController? controller;
//   final String? Function(String?)? validator;
//   @override
//   State<CustomTextFormField> createState() => _CustomTextFormFieldState();
// }

// class _CustomTextFormFieldState extends State<CustomTextFormField> {
//   late bool passwordEnabled = widget.isPassword;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Column(
//         spacing: 5,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (widget.title != null)
//             Text(
//               widget.title!,
//               style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 16),
//             ),
//           TextFormField(
//             maxLines: widget.maxLines,
//             controller: widget.controller,
//             onTapOutside: (event) {
//               FocusScope.of(context).unfocus();
//             },
//             style: Theme.of(context).textTheme.labelMedium,
//             obscureText: passwordEnabled,
//             validator: widget.validator,
//             decoration: InputDecoration(
//               hintStyle: AppTextStyles.styleS16W500(color: Theme.of(context).hintColor),
//               hintText: widget.hintText,
//               labelText: widget.label,
//               contentPadding: EdgeInsets.all(2),
//               labelStyle:
//                   AppTextStyles.styleS16W500(color: Theme.of(context).hoverColor),
//               prefixIcon: widget.prefixIcon != null
//                   ? Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Image.asset(
//                         widget.prefixIcon!,
                        
//                       ),
//                     )
//                   : null,
//               suffixIcon: widget.isPassword
//                   ? InkWell(
//                       onTap: () {
//                         passwordEnabled = !passwordEnabled;
//                         setState(() {});
//                       },
//                       child: Icon(
//                         passwordEnabled ? Icons.visibility_off : Icons.remove_red_eye,
//                         color: Theme.of(context).hoverColor,
//                       ),
//                     )
//                   : null,
//               errorStyle: AppTextStyles.styleS14W400(color: AppColors.errorColor),
//               border: _buildBorder(),
//               enabledBorder: _buildBorder(),
//               focusedBorder: _buildBorder(),
//               errorBorder: _buildBorder(color: AppColors.errorColor),
//               focusedErrorBorder: _buildBorder(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   InputBorder _buildBorder({Color? color}) {
//     return OutlineInputBorder(
//       borderRadius: BorderRadius.circular(16),
//       borderSide: BorderSide(color: color ?? Theme.of(context).dividerColor),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:inst_meters/theme/app_colors.dart';
import 'package:inst_meters/widgets/app_text_styles.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.label,
    this.isPassword = false,
    this.prefixIcon,
    this.validator,
    this.controller,
    this.title,
    this.maxLines = 1,
    this.hintText,
  });

  final String? label;
  final String? title;
  final String? hintText;
  final String? prefixIcon;
  final bool isPassword;
  final int maxLines;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool passwordEnabled = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                widget.title!,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 16),
              ),
            ),
          Directionality(
  textDirection: TextDirection.ltr,
            child: TextFormField(
             
              maxLines: widget.maxLines,
              controller: widget.controller,
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              style: Theme.of(context).textTheme.labelMedium,
              obscureText: passwordEnabled,
              validator: widget.validator,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                floatingLabelAlignment: FloatingLabelAlignment.center,
alignLabelWithHint: true,
                hintText: widget.hintText,
                hintStyle: AppTextStyles.styleS16W500(color: AppColors.mainColors),
                labelText: widget.label,
                labelStyle: AppTextStyles.styleS16W500(color: AppColors.mainColors),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            
                
            suffixIcon: widget.isPassword
          ? IconButton(
              onPressed: () {
                setState(() {
                  passwordEnabled = !passwordEnabled;
                });
              },
              icon: Icon(
                passwordEnabled ? Icons.visibility_off : Icons.visibility,
                color: AppColors.lightSecTextColor,
              ),
            )
          : null,
            
               
                prefixIcon: widget.prefixIcon != null
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Image.asset(
                widget.prefixIcon!,
                width: 22,
                height: 22,
                fit: BoxFit.contain,
              ),
            )
          : null,
      prefixIconConstraints: const BoxConstraints(
        minWidth: 40,
        minHeight: 40,
      ),
            
                errorStyle: AppTextStyles.styleS14W400(color: AppColors.errorColor),
                border: _buildBorder(),
                enabledBorder: _buildBorder(),
                focusedBorder: _buildBorder(),
                errorBorder: _buildBorder(color: AppColors.errorColor),
                focusedErrorBorder: _buildBorder(color: AppColors.errorColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputBorder _buildBorder({Color? color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: color ?? Theme.of(context).dividerColor,
      ),
    );
  }
}