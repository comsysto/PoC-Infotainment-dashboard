import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infotainment_mobile_app/features/chat/presentation/widget/chat_bubble.dart';
import 'package:infotainment_mobile_app/features/chat/presentation/widget/feedback_dialog.dart';

class ChatNotifier extends ChangeNotifier {
  bool isAnswered = false;
  final List<Widget> messages = [];

  void emulateChat() async {
    await Future.delayed(const Duration(milliseconds: 500));
    messages.add(_chatMessages[0]);
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 2000));
    messages.add(_chatMessages[1]);
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 2000));
    messages.add(
      FeedbackDialog(
        onAccept: () async {
          isAnswered = true;
          notifyListeners();

          await Future.delayed(const Duration(milliseconds: 1500));
          messages.add(_chatMessages[2]);
          notifyListeners();
        },
        onDecline: () async {
          isAnswered = true;
          notifyListeners();
          
          await Future.delayed(const Duration(milliseconds: 1500));
          messages.add(_chatMessages[2]);
          notifyListeners();
        },
      ),
    );
    notifyListeners();
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

final chatNotifierProvider = ChangeNotifierProvider<ChatNotifier>(
  (_) {
    final instance = ChatNotifier();
    instance.emulateChat();
    return instance;
  },
);

//TODO: Left this commented out to discuss on PR
/* class ChatNotifier extends Notifier<List<Widget>> {
  late final List<Widget> messages;

  @override
  List<Widget> build() {
    messages = [];
    emulateChat();
    return [];
  }

  void emulateChat() async {
    print("emualtion started");

    await Future.delayed(const Duration(milliseconds: 500));
    state.add(_chatMessages[0]);
    print("first message added");

    await Future.delayed(const Duration(milliseconds: 2000));
    state.add(_chatMessages[1]);
    print("second message added");

    await Future.delayed(const Duration(milliseconds: 1000));
    state.add(_chatMessages[2]);
    print("third message added");
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
    FeedbackDialog(
      onAccept: () {},
      onDecline: () {},
    ),
  ];
}

final chatNotifierProvider = NotifierProvider<ChatNotifier, List<Widget>>(
  () => ChatNotifier(),
); */
