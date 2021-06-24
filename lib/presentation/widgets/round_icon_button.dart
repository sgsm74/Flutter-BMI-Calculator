import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  const RoundIconButton({Key? key, required this.child, required this.onPress})
      : super(key: key);
  final IconData child;
  final Function() onPress;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(child),
      constraints: BoxConstraints.tightFor(width: 56, height: 56),
      elevation: 6,
      onPressed: onPress,
      shape: CircleBorder(),
      fillColor: Color(0xff4c4f5e),
    );
  }
}
