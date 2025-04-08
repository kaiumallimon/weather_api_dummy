import 'package:dummy/app/models/weather_model.dart';
import 'package:dummy/app/services/weather_service.dart';
import 'package:dummy/app/widgets/_weather_data.dart';
import 'package:flutter/material.dart';

import '../widgets/_custom_button.dart';
import '../widgets/_custom_textfield.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  WeatherData? weatherData;
  bool isLoading = false;

  Future<void> getWeather() async {
    WeatherService weatherService = WeatherService();
    String city = cityController.text.trim();
    String country = countryController.text.trim();

    if (city.isNotEmpty && country.isNotEmpty) {
      try {
        setState(() {
          isLoading = true;
        });

        final response = await weatherService.getWeatherData(city, country);

        if (response != null) {
          setState(() {
            weatherData = response;
            isLoading = false;
          });
        } else {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to load weather data")),
          );
          setState(() {
            isLoading = false;
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("Error fetching weather data ${e.toString()}")),
        );
      }
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter city and country")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: false,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              setState(() {
                cityController.clear();
                countryController.clear();
                weatherData = null;
              });
            },
          ),
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              spacing: 20,
              children: [
                Expanded(
                  child: CustomTextfield(
                      controller: cityController,
                      width: double.infinity,
                      height: 50,
                      hintText: "City Name"),
                ),
                Expanded(
                  child: CustomTextfield(
                      controller: countryController,
                      width: double.infinity,
                      height: 50,
                      hintText: "Country code"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Get Weather",
              width: double.infinity,
              height: 50,
              onPressed: () async {
                await getWeather();
              },
            ),
            const SizedBox(height: 20),
            if (isLoading)
              Expanded(
                child: Center(
                    child: CircularProgressIndicator(
                  color: Colors.blue,
                  // radius: 15,
                )),
              ),
            if (weatherData != null) WeatherDataWidget(weatherData: weatherData)
          ],
        ),
      )),
    );
  }
}
