import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pilar_presence_app/app/style/app_color.dart';
import 'package:pilar_presence_app/constant.dart';

class CustomTextArea extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool disabled;
  final EdgeInsetsGeometry margin;
  final bool obsecureText;
  final Widget? suffixIcon;
  final BuildContext context;
  CustomTextArea({
    required this.controller,
    required this.label,
    required this.hint,
    required this.context,
    this.disabled = false,
    this.margin = const EdgeInsets.only(bottom: 16),
    this.obsecureText = false,
    this.suffixIcon,
  });

  @override
  State<CustomTextArea> createState() => _CustomTextAreaState();
}

class _CustomTextAreaState extends State<CustomTextArea> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
        // margin: widget.margin,
        decoration: BoxDecoration(
          color: (widget.disabled == false)
              ? Colors.transparent
              : AppColor.primaryExtraSoft,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
        ),
        child: TextField(
          readOnly: widget.disabled,
          obscureText: widget.obsecureText,
          cursorHeight: 20,
          style: TextStyle(
            fontSize: Constant.textSize(context: context, fontSize: 14),
          ),
          maxLines: 8,
          controller: widget.controller,
          decoration: InputDecoration(
            suffixIcon: widget.suffixIcon ?? const SizedBox(),
            label: Text(
              widget.label,
              style: TextStyle(
                color: AppColor.secondarySoft,
                fontSize: Constant.textSize(context: context, fontSize: 14),
              ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: InputBorder.none,
            hintText: widget.hint,
            hintStyle: TextStyle(
              fontSize: Constant.textSize(context: context, fontSize: 14),
              fontWeight: FontWeight.w500,
              color: AppColor.secondarySoft,
            ),
          ),
        ),
      ),
    );
  }
}
