import 'package:clean_test/data/model/weather_model.dart';
import 'package:clean_test/domain/entitiy/weather.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import '../../helpers/dummy_data/json_reader.dart';

void main() {
  const testWeatherModel = WeatherModel(
    cityName: 'Zocca',
    main: 'Rain',
    description: 'moderate rain',
    iconCode: '10d',
    temperature: 298.48,
    pressure: 1015,
    humidity: 64,
  );

  test('should be a subclass of weather entity', () async {
//assert
    expect(testWeatherModel, isA<WeatherEntity>());
  });

  test('should return a valid model from json', () async {
    //arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('helpers/dummy_data/dummy_weather_response.json'),
    );

    //act
    final result = WeatherModel.fromJson(jsonMap);

    //assert
    expect(result, equals(testWeatherModel));
  });

  test(
    'should return a json map containing proper data',
    () async {
      // act
      final result = testWeatherModel.toJson();

      // assert
      final expectedJsonMap = {
        'weather': [
          {
            'main': 'Rain', 'description': 'moderate rain', 'icon': '10d'
          }
        ],
        'main': {
          'temp': 298.48, 'pressure': 1015, 'humidity': 64
        },
        'name': 'Zocca',
      };

      expect(result, equals(expectedJsonMap));
    },
  );
}
