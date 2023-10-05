import 'package:clean_test/domain/entitiy/weather.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:clean_test/domain/usecase/get_current_weather.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  GetCurrentWeatherUseCase? getCurrentWeatherUseCase;
  MockWeatherRepository? mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase = GetCurrentWeatherUseCase(mockWeatherRepository!);
  });

  const testWeatherDetail = WeatherEntity(
    cityName: 'Zocca',
    main: 'Rain',
    description: 'moderate rain',
    iconCode: '10d',
    temperature: 298.48,
    pressure: 1015,
    humidity: 64,
  );

  const testCityName = 'New York';

  test('should get current weather detail from the repository, ', () async {
    //arrange
    when(mockWeatherRepository!.getCurrentWeather(testCityName))
        .thenAnswer((_) async => const Right(testWeatherDetail));

    //act
    final result = await getCurrentWeatherUseCase!.execute(testCityName);

    //assert
    expect(result, const Right(testWeatherDetail));
  });
}
