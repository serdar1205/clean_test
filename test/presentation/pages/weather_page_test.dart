
import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:clean_test/domain/entitiy/weather.dart';
import 'package:clean_test/presentation/bloc/weather_bloc.dart';
import 'package:clean_test/presentation/views/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent,WeatherState> implements WeatherBloc {  }

void main() {

  late MockWeatherBloc mockWeatherBloc;

  setUp((){
    mockWeatherBloc = MockWeatherBloc();
    HttpOverrides.global = null;
  });


  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WeatherBloc>(
      create: (context) => mockWeatherBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const testWeather = WeatherEntity(
    cityName: 'Zocca',
    main: 'Rain',
    description: 'moderate rain',
    iconCode: '10d',
    temperature: 298.48,
    pressure: 1015,
    humidity: 64,
  );


  testWidgets(
    'text field should trigger state to change from empty to loading',
        (widgetTester) async {
      //arrange
      when(()=> mockWeatherBloc.state).thenReturn(WeatherEmpty());

      //act
      await widgetTester.pumpWidget(_makeTestableWidget(const WeatherPage()));
      var textField = find.byType(TextField);
      expect(textField, findsOneWidget);
      await widgetTester.enterText(textField, 'Zocca');
      await widgetTester.pump();
      expect(find.text('Zocca'),findsOneWidget);
    },
  );


  testWidgets(
    'should show progress indicator when state is loading',
        (widgetTester) async {
      //arrange
      when(()=> mockWeatherBloc.state).thenReturn(WeatherLoading());

      //act
      await widgetTester.pumpWidget(_makeTestableWidget(const WeatherPage()));

      //assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  //
  // testWidgets(
  //   'should show widget contain weather data when state is weather loaded',
  //       (widgetTester) async {
  //     //arrange
  //     when(()=> mockWeatherBloc.state).thenReturn(const WeatherLoaded(testWeather));
  //
  //     //act
  //     await widgetTester.pumpWidget(_makeTestableWidget(const WeatherPage()));
  //
  //     //assert
  //     expect(find.byKey(const Key('weather_data')), findsOneWidget);
  //   },
  // );




}