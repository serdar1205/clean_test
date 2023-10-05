import 'package:dartz/dartz.dart';
import 'package:clean_test/core/error/failure.dart';
import 'package:clean_test/domain/entitiy/weather.dart';

abstract class WeatherRepository{
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String city);
}