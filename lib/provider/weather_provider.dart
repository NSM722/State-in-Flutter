import 'package:flutter_state_management/provider/city_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// default emoji for unknown weather
const unknownWeatherEmoji = '🛑';

// enum for constant city values for this app
enum City {
  stockholm,
  paris,
  tokyo,
}

// type alias
typedef WeatherEmoji = String;

// function outputs weather given a city
Future<WeatherEmoji> getWeather(City city) {
  // imitate a network request
  return Future.delayed(
    const Duration(seconds: 3),
    () {
      return {
        City.stockholm: '🌧️',
        City.paris: '❄️',
        City.tokyo: '🌪️',
      }[city]!;
    },
  );
}

// provider to read from the currentCityProvider and get the weather emoji
final weatherProvider = FutureProvider<WeatherEmoji>(
  (ref) {
    final city = ref.watch(cityProvider);
    if (city != null) {
      return getWeather(city);
    } else {
      return unknownWeatherEmoji;
    }
  },
);
