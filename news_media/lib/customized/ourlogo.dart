import 'package:flutter/material.dart';

class OurLogo extends StatelessWidget{
  const OurLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        //our logo
        Text(
          'NEWS',
          style: TextStyle(
            color: Colors.red,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),

        Text(
          'ToYou',
          style: TextStyle(
            color: Colors.black38,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

}