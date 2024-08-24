import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/func/permission.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/widgets/loader.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: determinePosition(),
        builder: (context, snap) {
          if (snap.hasData) {
            return BlocProvider<WeatherBloc>(
              create: (context) => WeatherBloc()
                ..add(
                  FetchWeather(snap.data as Position),
                ),
              child: const HomeScreen(),
            );
          } else {
            return const Scaffold(
              backgroundColor: Colors.black,
              body: AppLoader(),
            );
          }
        },
      ),
    );
  }
}
