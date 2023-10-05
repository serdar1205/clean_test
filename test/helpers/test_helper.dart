import 'package:clean_test/data/datasource/rempote_data_source.dart';
import 'package:clean_test/domain/repository/weather_repository.dart';
import 'package:clean_test/domain/usecase/get_current_weather.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

// Annotation which generates the cat.mocks.dart library and the MockCat class.
@GenerateNiceMocks([
  MockSpec<WeatherRepository>(),
  MockSpec<http.Client>(as: #MockHttpClient),
  MockSpec<WeatherRemoteDataSource>(),
  MockSpec<GetCurrentWeatherUseCase>()
])


void main() {

}