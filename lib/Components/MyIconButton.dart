import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final VoidCallback onPresses;
  final double size;

  const MyIconButton({Key? key, this.iconColor = Colors.white, required this.iconData , required this.onPresses, this.size = 22}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Material(
        color: Colors.transparent,
        child: IconButton(
            icon: Icon(iconData,color: iconColor,size: size),
            onPressed: onPresses
        ),
      ),
    );
  }
}
