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
      style: ButtonStyle(

        elevation: MaterialStateProperty.all(0),

        minimumSize: MaterialStateProperty.all(
            Size(width ?? double.infinity, height ?? double.infinity)),

        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(radius ?? 6),
            ),
          ),
        ),
      ),
      child: Text(
        text ?? "",
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w300,
          color: Colors.white,
        ),
      ),
    );
  }
}