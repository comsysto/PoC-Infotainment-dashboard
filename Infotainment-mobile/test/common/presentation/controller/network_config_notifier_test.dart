import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infotainment_mobile_app/common/presentation/controller/network_config_notifier.dart';

ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );

  addTearDown(container.dispose);

  return container;
}

void main() {
  late NotifierProvider<NetworkConfigNotifier, String> networkConfigProvider;

  setUp(() {
    networkConfigProvider = NotifierProvider<NetworkConfigNotifier, String>(
      () => NetworkConfigNotifier(),
    );
  });

  test('should return default IP address on initialisation', () {
    //arrange
    final container = createContainer();
    //act
    final result = container.read(networkConfigProvider);
    //assert
    expect(result, '192.168.14.144:56035');
  });

  test('should successfully set network config', () {
    //arrange
    final container = createContainer();
    //act
    container.read(networkConfigProvider.notifier).setConfig(ipAddress: '127.0.0.1', port: '6563');
    final result = container.read(networkConfigProvider);
    //assert
    expect(result, '127.0.0.1:6563');
  });
}
