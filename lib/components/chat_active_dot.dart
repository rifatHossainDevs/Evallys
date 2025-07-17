import 'package:evalys_main/global/utils/constants.dart';
import 'package:flutter/material.dart';

class ChatActiveDot extends StatelessWidget {
  const ChatActiveDot({
    super.key,
    this.dotColor = successColor,
  });
  final Color dotColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: dotColor,
        shape: BoxShape.circle,
        border: Border.all(
          width: 3,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
