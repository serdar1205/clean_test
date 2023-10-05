import 'package:clean_test/core/constants/strings.dart';
import 'package:clean_test/core/error/exception.dart';
import 'package:clean_test/data/datasource/rempote_data_source.dart';
import 'package:clean_test/data/model/weather_model.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import '../../helpers/dummy_data/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';
import 'package:http/http.dart' as http;

void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImpl =
        WeatherRemoteDataSourceImpl(client: mockHttpClient);
  });

  const testCityName = 'New York';

  group('get current weather', () {
    
    test('should return weather model when the response code is 200', () async {
      //arrange
      when(mockHttpClient
              .get(Uri.parse(Urls.currentWeatherByName(testCityName))))
          .thenAnswer((_) async => http.Response(
                readJson('helpers/dummy_data/dummy_weather_response.json'),
                200,
              ));

      //act
      final result =
          await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

      //assert
     // expect(result, isA<WeatherModel>);
      // Create a matcher that matches WeatherModel objects.
      final matcher = isA<WeatherModel>();

      // Use the matcher with the expect() function.
      expect(result, matcher);
    });

    test(
      'should throw a server exception when the response code is 404 or other',
          () async {
        //arrange
        when(
          mockHttpClient.get( Uri.parse(Urls.currentWeatherByName(testCityName))),
        ).thenAnswer(
                (_) async => http.Response('Not found',404)
        );

        //act
        final result = weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

        //assert
        expect(result, throwsA(isA<ServerException>()));

      },
    );

  });
}
