import 'dart:io';

import 'package:clean_test/core/error/exception.dart';
import 'package:clean_test/core/error/failure.dart';
import 'package:clean_test/data/model/weather_model.dart';
import 'package:clean_test/data/repository/weather_repository_impl.dart';
import 'package:clean_test/domain/entitiy/weather.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../helpers/test_helper.mocks.dart';

void main(){
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(
      weatherRemoteDataSource: mockWeatherRemoteDataSource,
    );
  });

  const testWeatherModel = WeatherModel(
    cityName: 'Zocca',
    main: 'Rain',
    description: 'moderate rain',
    iconCode: '10d',
    temperature: 298.48,
    pressure: 1015,
    humidity: 64,
  );

  const testWeatherEntity = WeatherEntity(
    cityName: 'Zocca',
    main: 'Rain',
    description: 'moderate rain',
    iconCode: '10d',
    temperature: 298.48,
    pressure: 1015,
    humidity: 64,
  );

  const testCityName = 'Zocca';

  group('get current weather', () {

    test(
      'should return current weather when a call to data source is successful',
          () async {
        // arrange
        when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
            .thenAnswer((_) async => testWeatherModel);

        // act
        final result = await weatherRepositoryImpl.getCurrentWeather(testCityName);

        // assert
        expect(result, equals(const Right(testWeatherEntity)));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
          () async {
        // arrange
        when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
            .thenThrow(ServerException());

        // act
        final result = await weatherRepositoryImpl.getCurrentWeather(testCityName);

        // assert
        expect(result, equals(const Left(ServerFailure('An error has occurred'))));
      },
    );

    test(
      'should return connection failure when the device has no internet',
          () async {
        // arrange
        when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
            .thenThrow(const SocketException('Failed to connect to the network'));

        // act
        final result = await weatherRepositoryImpl.getCurrentWeather(testCityName);

        // assert
        expect(result, equals(const Left(ConnectionFailure('Failed to connect to the network'))));
      },
    );

  });

}