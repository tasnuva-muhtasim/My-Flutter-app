import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'weather_model.dart';
import 'weather_service.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              Provider.of<WeatherModel>(context, listen: false).fetchWeather('London');
            },
          ),
        ],
      ),
      body: Consumer<WeatherModel>(
        builder: (context, model, child) {
          if (model.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (model.weather == null) {
            return Center(child: Text('Error fetching weather data.'));
          } else {
            return ListView(
              children: [
                ListTile(
                  title: Text(model.weather!.cityName),
                  subtitle: Text('${model.weather!.temperature} °C'),
                  leading: Image.network('http://openweathermap.org/img/w/${model.weather!.icon}.png'),
                  trailing: Text(model.weather!.description),
                ),
                ListTile(
                  title: Text('Humidity: ${model.weather!.humidity}%'),
                  subtitle: Text('Wind Speed: ${model.weather!.windSpeed} m/s'),
                ),
                ListTile(
                  title: Text('Air Quality Index: ${model.weather!.airQualityIndex}'),
                ),
                ...model.weather!.forecast.map((day) {
                  return ListTile(
                    title: Text(day.day),
                    subtitle: Text('${day.temperature} °C'),
                    leading: Image.network('http://openweathermap.org/img/w/${day.icon}.png'),
                    trailing: Text(day.description),
                  );
                }).toList(),
              ],
            );
          }
        },
      ),
    );
  }
}
