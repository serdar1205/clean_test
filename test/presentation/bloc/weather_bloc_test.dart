import 'package:bloc_test/bloc_test.dart';
import 'package:clean_test/domain/entitiy/weather.dart';
import 'package:clean_test/presentation/bloc/weather_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc = WeatherBloc(mockGetCurrentWeatherUseCase);
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

  const testCityName = 'Zocca';

  test('initial state should be empty',
      () => expect(weatherBloc.state, WeatherEmpty()));

  blocTest<WeatherBloc, WeatherState>(
    'should emit [WeatherLoading, WeatherLoaded] when data is gotten successfully',
    build: () {
      when(mockGetCurrentWeatherUseCase.execute(testCityName))
          .thenAnswer((_) async => const Right(testWeatherDetail));
      return weatherBloc;
    },
    act: (bloc) {
      return bloc.add(const OnCityChanged(testCityName));
    },
    wait: const Duration(milliseconds: 500),

    expect: () => [
      WeatherLoading(),
      const WeatherLoaded(testWeatherDetail),
    ],
  );
}
