import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/transformers.dart';
import '../../domain/entitiy/weather.dart';
import '../../domain/usecase/get_current_weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';


class WeatherBloc extends Bloc<WeatherEvent,WeatherState> {

  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;
  WeatherBloc(this._getCurrentWeatherUseCase) : super(WeatherEmpty()) {
    on<OnCityChanged>(
          (event, emit) async {

        emit(WeatherLoading());

        final result = await _getCurrentWeatherUseCase.execute(event.cityName);
        result.fold(
              (failure) {
            emit(WeatherLoadFailure(failure.message));
          },
              (data) {
            emit(WeatherLoaded(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}
EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}