import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infotainment/core/style/style_extensions.dart';
import 'package:infotainment/features/fuel/fuel_level_indicator.dart';
import 'package:infotainment/features/indicators/presentation/widget/gearbox_mode.dart';
import 'package:infotainment/features/indicators/presentation/widget/vehicle_indicators.dart';
import 'package:infotainment/features/tachometer/presentation/widget/blinkers.dart';
import 'package:infotainment/features/tachometer/presentation/widget/rpm_counter.dart';
import 'package:infotainment/features/tachometer/presentation/widget/speed_indicator.dart';
import 'package:infotainment/features/time_and_weather/presentation/widget/day_weather_info.dart';
import 'package:infotainment/features/trip_information/presentation/widget/current_trip_info.dart';

class MainTachoScreen extends ConsumerWidget {
  const MainTachoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [context.colors.backgroundBegin, context.colors.backgroundEnd],
          ),
        ),
        child: const SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DayWeatherInfo(),
                    RPMCounter(),
                    Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 15),
                      child: Row(
                        children: [
                          FuelLevelIndicator(),
                          Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Blinkers(),
                    SpeedIndicator(),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    VehicleIndicators(),
                    CurrentTripInfo(),
                    GearboxMode(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
