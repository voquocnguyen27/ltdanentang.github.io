import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_youtube/bloc/weather_bloc_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDaytime(DateTime now, DateTime sunrise) {
      // Giả sử mặt trời mọc vào lúc 6:30 AM
      // và mặt trời lặn vào lúc 6:30 PM
      DateTime sunset = sunrise.add(Duration(hours: 12));

      // So sánh thời gian hiện tại với thời gian mặt trời mọc và lặn
      return now.isAfter(sunrise) && now.isBefore(sunset);
    }
	Widget getWeatherIcon(WeatherBlocSuccess state) {
    final code = state.weather.weatherConditionCode!;
    String inputTime = state.weather.date.toString();
    String inputsunrise = state.weather.sunrise.toString();
    String inputsunset = state.weather.sunset.toString();
    DateTime givenTime = DateTime.parse(inputTime);
    DateTime sunrise = DateTime.parse(inputsunrise);
    DateTime sunset = DateTime.parse(inputsunset);

    bool isDaytime = givenTime.isAfter(sunrise) && givenTime.isBefore(sunset);

    if(isDaytime == true) {
      switch (code) {
        case == 200 || == 201:
          return Image.asset(
            'assets/day_rain_thunder_light.png'
          );
        case > 201 && < 300 :
          return Image.asset(
            'assets/rain_thunder.png'
          );
        case >= 300 && < 400 :
          return Image.asset(
            'assets/rain.png'
          );
        case >= 500 && < 511 :
          return Image.asset(
            'assets/day_rain.png'
          );
        case == 511 :
          return Image.asset(
            'assets/sleet.png'
          );
        case > 511 && < 600 :
          return Image.asset(
            'assets/rain.png'
          );
        case >= 600 && < 700:
          return Image.asset(
            'assets/snow.png'
          );
        case >= 700 && < 771:
          return Image.asset(
            'assets/fog.png'
          );
        case == 781:
          return Image.asset(
            'assets/tornado.png'
          );
        case == 800:
          return Image.asset(
            'assets/day_clear.png'
          );
        case == 801:
          return Image.asset(
            'assets/day_cloud.png'
          );
        case == 802:
          return Image.asset(
            'assets/cloudy.png'
          );
        case == 803 || == 804:
          return Image.asset(
            'assets/overcast.png'
          );
        default:
        return Image.asset(
          'assets/day_clear.png'
        );
      }
		} else{
      switch (code) {
        case == 200 || == 201:
          return Image.asset(
            'assets/night_rain_thunder_light.png'
          );
        case > 201 && < 300 :
          return Image.asset(
            'assets/rain_thunder.png'
          );
        case >= 300 && < 400 :
          return Image.asset(
            'assets/rain.png'
          );
        case >= 500 && < 511 :
          return Image.asset(
            'assets/night_rain.png'
          );
        case == 511 :
          return Image.asset(
            'assets/sleet.png'
          );
        case > 511 && < 600 :
          return Image.asset(
            'assets/rain.png'
          );
        case >= 600 && < 700:
          return Image.asset(
            'assets/snow.png'
          );
        case >= 700 && < 771:
          return Image.asset(
            'assets/fog.png'
          );
        case == 781:
          return Image.asset(
            'assets/tornado.png'
          );
        case == 800:
          return Image.asset(
            'assets/night_clear.png'
          );
        case == 801:
          return Image.asset(
            'assets/night_cloud.png'
          );
        case == 802:
          return Image.asset(
            'assets/cloudy.png'
          );
        case == 803 || == 804:
          return Image.asset(
            'assets/overcast.png'
          );
        default:
        return Image.asset(
          'assets/night_clear.png'
        );
      }
    }
	}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
			backgroundColor: Colors.black,
			extendBodyBehindAppBar: true,
			appBar: AppBar(
				backgroundColor: Colors.transparent,
				elevation: 0,
				systemOverlayStyle: const SystemUiOverlayStyle(
					statusBarBrightness: Brightness.dark
				),
			),
			body: Padding(
				padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
				child: SizedBox(
					height: MediaQuery.of(context).size.height,
					child: Stack(
						children: [
							Align(
								alignment: const AlignmentDirectional(3, -0.3),
								child: Container(
									height: 300,
									width: 300,
									decoration: const BoxDecoration(
										shape: BoxShape.circle,
										color: Colors.deepPurple
									),
								),
							),
							Align(
								alignment: const AlignmentDirectional(-3, -0.3),
								child: Container(
									height: 300 ,
									width: 300, 
									decoration: const BoxDecoration(
										shape: BoxShape.circle,
										color: Color(0xFF673AB7)
									),
								),
							),
							Align(
								alignment: const AlignmentDirectional(0, -1.2),
								child: Container(
									height: 300,
									width: 600,
									decoration: const BoxDecoration(
										color: Color(0xFFFFAB40)
									),
								),
							),
							BackdropFilter(
								filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
								child: Container(
									decoration: const BoxDecoration(color: Colors.transparent),
								),
							),
							BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
								builder: (context, state) {
									if(state is WeatherBlocSuccess) {
										return SizedBox(
											width: MediaQuery.of(context).size.width,
											height: MediaQuery.of(context).size.height,
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: [
													Text(
														'📍 ${state.weather.areaName}',
														style: const TextStyle(
															color: Colors.white,
															fontWeight: FontWeight.w300,
                              fontSize: 15,
														),
													),
													const SizedBox(height: 8),
													Text(
														'${state.weather.country!}',
														style: TextStyle(
															color: Colors.white,
															fontSize: 25,
															fontWeight: FontWeight.bold
														),
													),
                          const SizedBox(height: 30),
                          Center(
                            child: getWeatherIcon(state),
                          ),
                          const SizedBox(height: 30),
													Center(
														child: Text(
															'${state.weather.temperature!.celsius!.toStringAsFixed(1)}°C',
															style: const TextStyle(
																color: Colors.white,
																fontSize: 55,
																fontWeight: FontWeight.w600
															),
														),
													),
													Center(
														child: Text(
															state.weather.weatherMain!.toUpperCase(),
															style: const TextStyle(
																color: Colors.white,
																fontSize: 25,
																fontWeight: FontWeight.w500
															),
														),
													),
													const SizedBox(height: 5),
													Center(
														child: Text(           
															DateFormat('EEEE dd').format(state.weather.date!),
															style: const TextStyle(
																color: Colors.white,
																fontSize: 16,
																fontWeight: FontWeight.w300
															),
														),
													),
													const SizedBox(height: 30),
													Row(
														mainAxisAlignment: MainAxisAlignment.spaceBetween,
														children: [
															Row(
																children: [
																	Image.asset(
																		'assets/11.png',
																		scale: 8,
																	),
																	const SizedBox(width: 5),
																	Column(
																		crossAxisAlignment: CrossAxisAlignment.start,
																		children: [
																			const Text(
																				'Sunrise',
																				style: TextStyle(
																					color: Colors.white,
																					fontWeight: FontWeight.w300
																				),
																			),
																			const SizedBox(height: 3),
																			Text(
																				DateFormat().add_jm().format(state.weather.sunrise!),
																				style: const TextStyle(
																					color: Colors.white,
																					fontWeight: FontWeight.w700
																				),
																			),
																		],
																	)
																],
															),
															Row(
																children: [
																	Image.asset(
																		'assets/12.png',
																		scale: 8,
																	),
																	const SizedBox(width: 5),
																	Column(
																		crossAxisAlignment: CrossAxisAlignment.start,
																		children: [
																			const Text(
																				'Sunset',
																				style: TextStyle(
																					color: Colors.white,
																					fontWeight: FontWeight.w300
																				),
																			),
																			const SizedBox(height: 3),
																			Text(
																				DateFormat().add_jm().format(state.weather.sunset!),
																				style: const TextStyle(
																					color: Colors.white,
																					fontWeight: FontWeight.w700
																				),
																			),
																		],
																	)
																],
															),
														],
													),
													const Padding(
														padding: EdgeInsets.symmetric(vertical: 5.0),
														child: Divider(
															color: Colors.grey,
														),
													),
													Row(
														mainAxisAlignment: MainAxisAlignment.spaceBetween,
														children: [
															Row(
																children: [
																	Image.asset(
																		'assets/13.png',
																		scale: 8,
																	),
																	const SizedBox(width: 5),
																	Column(
																		crossAxisAlignment: CrossAxisAlignment.start,
																		children: [
																			const Text(
																				'Temp Max',
																				style: TextStyle(
																					color: Colors.white,
																					fontWeight: FontWeight.w300
																				),
																			),
																			const SizedBox(height: 3),
																			Text(
																				"${state.weather.tempMax!.celsius!.toStringAsFixed(1)} °C",
																				style: const TextStyle(
																					color: Colors.white,
																					fontWeight: FontWeight.w700
																				),
																			),
																		],
																	)
																]
															),
															Row(
																children: [
																	Image.asset(
																		'assets/14.png',
																		scale: 8,
																	),
																	const SizedBox(width: 5),
																	Column(
																		crossAxisAlignment: CrossAxisAlignment.start,
																		children: [
																			const Text(
																				'Temp Min',
																				style: TextStyle(
																					color: Colors.white,
																					fontWeight: FontWeight.w300
																				),
																			),
																			const SizedBox(height: 3),
																			Text(
																				"${state.weather.tempMin!.celsius!.toStringAsFixed(1)} °C",
																				style: const TextStyle(
																					color: Colors.white,
																					fontWeight: FontWeight.w700
																				),
																			),
																		],
																	)
																]
															)
														],
													),
												],
											),
										);
									} else {
										return Container();
									}
								},
							)
						],
					),
				),
			),
		);
  }
}
