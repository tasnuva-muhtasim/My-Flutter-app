import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';  // Add this import for DateFormat
import 'weather_model.dart';

class WeatherService {
  static const String _apiKey = 'bd5e378503939ddaee76f12ad7a97608';  // Replace with your actual API key
  static const String _baseUrl = 'http://api.openweathermap.org/data/2.5';

  static Future<Weather> fetchCurrentWeather(String location) async {
    final response = await http.get(Uri.parse('$_baseUrl/weather?q=$location&appid=$_apiKey&units=metric'));
    final data = jsonDecode(response.body);

    List<Forecast> forecast = await fetchForecast(location);

    return Weather(
      cityName: data['name'],
      temperature: data['main']['temp'].toDouble(),
      description: data['weather'][0]['description'],
      icon: data['weather'][0]['icon'],
      windSpeed: data['wind']['speed'].toDouble(),
      humidity: data['main']['humidity'].toInt(),
      forecast: forecast,
      airQualityIndex: await fetchAirQualityIndex(data['coord']['lat'], data['coord']['lon']),
    );
  }

  static Future<List<Forecast>> fetchForecast(String location) async {
    final response = await http.get(Uri.parse('$_baseUrl/forecast/daily?q=$location&appid=$_apiKey&units=metric&cnt=7'));
    final data = jsonDecode(response.body)['list'];

    return data.map<Forecast>((day) {
      return Forecast(
        day: DateFormat('EEEE').format(DateTime.fromMillisecondsSinceEpoch(day['dt'] * 1000)),
        temperature: day['temp']['day'].toDouble(),
        description: day['weather'][0]['description'],
        icon: day['weather'][0]['icon'],
      );
    }).toList();
  }

  static Future<int> fetchAirQualityIndex(double lat, double lon) async {
    final response = await http.get(Uri.parse('$_baseUrl/air_pollution?lat=$lat&lon=$lon&appid=$_apiKey'));
    final data = jsonDecode(response.body)['list'][0]['main']['aqi'];

    return data.toInt();
  }
}
