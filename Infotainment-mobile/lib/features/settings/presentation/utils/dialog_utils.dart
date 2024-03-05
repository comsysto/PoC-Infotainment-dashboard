import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infotainment_mobile_app/common/data/datasource/globals.dart';
import 'package:infotainment_mobile_app/core/di/di.dart';

void showConfigDialog(
  final BuildContext context,
  final WidgetRef ref,
  final TextEditingController addressController,
  final TextEditingController portController,
) async {
  await showDialog(
    context: context,
    builder: (cotnext) {
      return AlertDialog(
        title: const Text('Enter IP address'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: addressController,
              decoration: const InputDecoration(hintText: 'e.g. 192.168.63.65'),
            ),
            TextField(
              controller: portController,
              decoration: const InputDecoration(hintText: 'Port: e.g. 4355'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (addressController.text.isNotEmpty && portController.text.isNotEmpty) {
                ipAddress = addressController.text;
                portNum = portController.text;
                ref.read(networkConfigProvider.notifier).setConfig(ipAddress: ipAddress, port: portNum);
              } else if (addressController.text.isNotEmpty) {
                ipAddress = addressController.text;
                ref.read(networkConfigProvider.notifier).setConfig(ipAddress: ipAddress);
              } else if (portController.text.isNotEmpty) {
                portNum = portController.text;
                ref.read(networkConfigProvider.notifier).setConfig(port: portNum);
              }
              Navigator.of(context).pop();
            },
            child: const Text('Set'),
          ),
        ],
      );
    },
  );
}
