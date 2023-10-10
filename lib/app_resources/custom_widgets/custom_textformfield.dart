import 'package:flutter/material.dart';
import 'package:kulfii_app/app_resources/app_colors.dart';
import 'package:kulfii_app/app_resources/app_dimension.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      this.hintText,
      this.initialValue,
      this.hintTextFontSize,
      this.onChanged});
  Function(String)? onChanged;
  String? initialValue;
  final String? hintText;
  double? hintTextFontSize;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: hintTextFontSize, color: Colors.grey),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
            horizontal: AppDimension.px10, vertical: AppDimension.px10),
        counter: SizedBox.shrink(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.black, width: 1.0),
        ),
      ),
    );
    ;
  }
}
