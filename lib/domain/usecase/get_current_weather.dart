import 'package:clean_test/core/error/failure.dart';
import 'package:clean_test/domain/entitiy/weather.dart';
import 'package:clean_test/domain/repository/weather_repository.dart';
import 'package:dartz/dartz.dart';

class GetCurrentWeatherUseCase{
  final WeatherRepository weatherRepository;

  GetCurrentWeatherUseCase(this.weatherRepository);

  Future<Either<Failure, WeatherEntity>> execute(String cityName){
    return weatherRepository.getCurrentWeather(cityName);
  }

}