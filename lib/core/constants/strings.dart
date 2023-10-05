class Urls {
  static const String baseUrl =
      'https://api.openweathermap.org/data/2.5';
  static const String apiKey = 'dda2abadc3945126ea26e765cdd07bc2';
  static String currentWeatherByName(String city) =>
      '$baseUrl/weather?q=$city&appid=$apiKey';
  static String weatherIcon(String iconCode) =>
      'http://openweathermap.org/img/wn/$iconCode@2x.png';
}

// class Urls {
//   static const String baseUrl =
//       'http://dataservice.accuweather.com/locations/v1/cities/search';
//   static const String apiKey = '101112';
//   static String currentWeatherByName(String cityName) =>
//
//       '$baseUrl/locations/v1/cities/search?apikey=$apiKey&q=$cityName';
//   static String weatherIcon(String iconCode) =>
//       'http://openweathermap.org/img/wn/$iconCode@2x.png';
// }