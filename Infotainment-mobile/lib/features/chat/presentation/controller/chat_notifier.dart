import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infotainment_mobile_app/features/chat/presentation/widget/chat_bubble.dart';
import 'package:infotainment_mobile_app/features/chat/presentation/widget/feedback_dialog.dart';

class ChatNotifier extends Notifier<List<Widget>> {
  late final List<Widget> messages;

  @override
  List<Widget> build() {
    messages = [];
    emulateChat();
    return [];
  }

  void emulateChat() async {
    await Future.delayed(const Duration(milliseconds: 500));
    state = [...state, _chatMessages[0]];

    await Future.delayed(const Duration(milliseconds: 2000));
    state = [...state, _chatMessages[1]];

    await Future.delayed(const Duration(milliseconds: 1000));
    state = [
      ...state,
      FeedbackDialog(
        onAccept: () async {
          await Future.delayed(const Duration(milliseconds: 1500));
          state = [...state, _chatMessages[2]];
        },
        onDecline: () async {
          await Future.delayed(const Duration(milliseconds: 1500));
          state = [...state, _chatMessages[2]];
        },
      ),
    ];
  }

  final _chatMessages = [
    const ChatBubble(
      isUserMessage: true,
      message: 'Hello, I have a problem with my DPF filter. Error code: MB65635543.',
    ),
    const ChatBubble(
      isUserMessage: false,
      message:
          'Hello Christian,\nThank you for a question. Try to drive your car above 120km/h for a couple of kilometers.',
    ),
    const ChatBubble(
      isUserMessage: false,
      message:
          'Great news! We are glad that problem is solved. Thank you for contacting us and have a safe trip.',
    ),
  ];
}

final chatNotifierProvider = NotifierProvider<ChatNotifier, List<Widget>>(
  () => ChatNotifier(),
);
