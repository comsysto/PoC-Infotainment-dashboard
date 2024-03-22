import 'package:hooks_riverpod/hooks_riverpod.dart';

class NetworkConfigNotifier extends Notifier<String> {
  @override
  build() => '10.100.3.90:56035';

  void setConfig({final String? ipAddress, final String? port}) {
    state = '${ipAddress ?? '10.100.3.90'}:${port ?? '56035'}';
  }
}
