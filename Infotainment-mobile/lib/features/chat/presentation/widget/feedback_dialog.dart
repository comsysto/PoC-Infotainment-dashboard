import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infotainment_mobile_app/core/style/style_extensions.dart';
import 'package:infotainment_mobile_app/features/chat/presentation/widget/action_button.dart';

class FeedbackDialog extends HookConsumerWidget {
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const FeedbackDialog({
    super.key,
    required this.onAccept,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAnswered = useState(false);

    return isAnswered.value
        ? const AnsweredForm()
        : QuestionForm(
            onAccept: () {
              isAnswered.value = true;
              onAccept();
            },
            onDecline: () {
              isAnswered.value = true;
              onDecline();
            },
          );
  }
}

class QuestionForm extends StatelessWidget {
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const QuestionForm({
    super.key,
    required this.onAccept,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: context.colorPersonalBubble,
      ),
      child: Column(
        children: [
          Icon(
            Icons.help_outline_rounded,
            color: context.colorPrimary,
            size: 38,
          ),
          Text(
            'Question',
            style: context.textFeedbackTitle,
          ),
          const SizedBox(height: 10),
          Text(
            'Did the proposal above solve your problem?\nPlease provide us the feedback.',
            textAlign: TextAlign.center,
            style: context.textFeedbackText,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ActionButton.secondary(
                  context: context,
                  label: 'No',
                  onPressed: onDecline,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: ActionButton.primary(
                  context: context,
                  label: 'Yes',
                  onPressed: onAccept,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class AnsweredForm extends StatelessWidget {
  const AnsweredForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: context.colorFormAnswer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle_outline_rounded,
            size: 38,
            color: context.colorSuccess,
          ),
          const SizedBox(width: 10),
          Text(
            'Thank you for your feedback.\nProblem is resolved!',
            style: context.textFeedbackText.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
