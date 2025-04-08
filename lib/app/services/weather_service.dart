import 'dart:convert';

import 'package:dummy/app/constants/constants.dart';
import 'package:dummy/app/models/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  Future<WeatherData?> getWeatherData(String city, String country) async {
    String APIURL =
        "https://api.openweathermap.org/data/2.5/weather?q=$city,$country&appid=${AppConstants.APIKEY}";

    try {
      final response = await http.get(Uri.parse(APIURL));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        debugPrint("Response data: $data");
        WeatherData weatherData = WeatherData.fromJson(data);
        return weatherData;
      } else {
        throw Exception("Failed to load weather data");
        // return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}


// GET
// POST

