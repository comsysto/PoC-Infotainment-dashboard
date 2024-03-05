import 'package:hooks_riverpod/hooks_riverpod.dart';

class NetworkConfigNotifier extends Notifier<String> {
  @override
  build() {
    return '10.100.3.72:56035';
  }

  void setConfig({final String? ipAddress, final String? port}) {
    state = '${ipAddress ?? '10.100.3.72'}:${port ?? '56035'}';
  }
}
