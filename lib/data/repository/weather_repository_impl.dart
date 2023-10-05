import 'dart:io';

import 'package:clean_test/core/error/failure.dart';
import 'package:clean_test/domain/entitiy/weather.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../domain/repository/weather_repository.dart';
import '../datasource/rempote_data_source.dart';

class WeatherRepositoryImpl extends WeatherRepository {

  final WeatherRemoteDataSource weatherRemoteDataSource;
  WeatherRepositoryImpl({required this.weatherRemoteDataSource});

  @override
  Future < Either < Failure, WeatherEntity >> getCurrentWeather(String cityName) async {
    try {
      final result = await weatherRemoteDataSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
