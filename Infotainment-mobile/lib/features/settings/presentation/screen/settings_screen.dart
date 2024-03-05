import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infotainment_mobile_app/core/style/style_extensions.dart';
import 'package:infotainment_mobile_app/features/settings/presentation/utils/dialog_utils.dart';
import 'package:infotainment_mobile_app/features/settings/presentation/widget/option_card.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressController = useTextEditingController();
    final portController = useTextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [context.colorGradientBegin, context.colorGradientEnd],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: Text(
                    'Settings',
                    style: context.textTitle,
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(height: 40),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/images/profile.jpg',
                    width: 150,
                  ),
                ),
                const SizedBox(height: 20),
                Text('Johannes Becker', style: context.textSubtitle),
                const SizedBox(height: 20),
                const OptionCard(
                  icon: Icons.home_rounded,
                  title: 'Manage your virtual garage',
                  description: 'Add or remove vehicles to garage',
                ),
                const SizedBox(height: 20),
                const OptionCard(
                  icon: Icons.quiz_rounded,
                  title: 'FAQ',
                  description: 'Discover the most frequent questions here',
                ),
                const SizedBox(height: 20),
                OptionCard(
                  icon: Icons.alternate_email_rounded,
                  title: 'Contact',
                  description: 'Feel free to contact us, we are here for you',
                  onPressed: () => showConfigDialog(context, ref, addressController, portController),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
