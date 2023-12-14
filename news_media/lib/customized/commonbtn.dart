import 'package:NewsToYou/customized/app_colors.dart';
import 'package:flutter/material.dart';

//common button widget
class CommonBtn extends StatelessWidget {
  const CommonBtn({
    Key? key,
    this.height,
    this.width,
    this.radius,
    this.onPressed,
    this.text,
  }) : super(key: key);

  //caption
  final String? text;

  final double? height;

  final double? width;

  final double? radius;

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(

        minimumSize: Size(width ?? double.infinity, height ?? double.infinity),

        foregroundColor: AppColors.defaulttextcolor,
        backgroundColor: Color(0xFF56C596),
        elevation: 8.0,
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(7.0)),
        ),
      ),
      child: Text(
        text ?? "",
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}