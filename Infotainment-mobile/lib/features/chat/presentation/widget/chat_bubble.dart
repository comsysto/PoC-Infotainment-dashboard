import 'package:flutter/material.dart';
import 'package:infotainment_mobile_app/core/style/style_extensions.dart';

class ChatBubble extends StatelessWidget {
  final bool isUserMessage;
  final String message;

  const ChatBubble({
    super.key,
    required this.isUserMessage,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        constraints: BoxConstraints(maxWidth: screenWidth / 2),
        decoration: BoxDecoration(
          borderRadius: isUserMessage
              ? const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
          color: isUserMessage ? context.colorPersonalBubble : context.colorMechanicBubble,
        ),
        child: Text(
          message,
          style: context.textBubble.copyWith(color: isUserMessage ? Colors.black : Colors.white),
        ),
      ),
    );
  }
}
