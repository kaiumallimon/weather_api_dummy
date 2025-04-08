import 'package:flutter/material.dart';

import '../models/weather_model.dart';

class WeatherDataWidget extends StatelessWidget {
  const WeatherDataWidget({
    super.key,
    required this.weatherData,
  });

  final WeatherData? weatherData;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      child: Column(
        spacing: 10,
        children: [
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text("City"),
            subtitle: Text(weatherData?.name ?? "N/A"),
          ),
          ListTile(
            leading: const Icon(Icons.cloud),
            title: const Text("Weather"),
            subtitle:
                Text(weatherData?.weather[0].description ?? "N/A"),
          ),
          ListTile(
            leading: const Icon(Icons.map),
            title: const Text("Temp"),
            subtitle:
                Text((weatherData!.main.temp - 273.15).toString()),
          ),
          ListTile(
            leading: const Icon(Icons.visibility),
            title: const Text("Visibility"),
            subtitle:
                Text(weatherData?.visibility.toString() ?? "N/A"),
          ),
          ListTile(
            leading: const Icon(Icons.air),
            title: const Text("Wind Speed"),
            subtitle:
                Text(weatherData?.wind.speed.toString() ?? "N/A"),
          ),
          ListTile(
            leading: const Icon(Icons.cloud_queue),
            title: const Text("Clouds"),
            subtitle:
                Text(weatherData?.clouds.all.toString() ?? "N/A"),
          ),
          ListTile(
            leading: const Icon(Icons.access_time),
            title: const Text("Time Zone"),
            subtitle: Text(weatherData?.timezone.toString() ?? "N/A"),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text("Date"),
            subtitle: Text(DateTime.fromMillisecondsSinceEpoch(
                    weatherData!.dt * 1000)
                .toString()),
          ),
          ListTile(
            leading: const Icon(Icons.cloud_circle),
            title: const Text("Humidity"),
            subtitle:
                Text(weatherData?.main.humidity.toString() ?? "N/A"),
          ),
          ListTile(
            leading: const Icon(Icons.speed),
            title: const Text("Pressure"),
            subtitle:
                Text(weatherData?.main.pressure.toString() ?? "N/A"),
          ),
          ListTile(
            leading: const Icon(Icons.thermostat),
            title: const Text("Feels Like"),
            subtitle: Text(
                (weatherData!.main.feelsLike - 273.15).toString()),
          ),
          ListTile(
            leading: const Icon(Icons.thermostat_outlined),
            title: const Text("Temp Min"),
            subtitle:
                Text((weatherData!.main.tempMin - 273.15).toString()),
          ),
          ListTile(
            leading: const Icon(Icons.thermostat_auto),
            title: const Text("Temp Max"),
            subtitle:
                Text((weatherData!.main.tempMax - 273.15).toString()),
          ),
        ],
      ),
    ));
  }
}

