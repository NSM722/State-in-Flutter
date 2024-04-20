import 'package:flutter/material.dart';
import 'package:flutter_state_management/provider/city_provider.dart';
import 'package:flutter_state_management/provider/weather_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWeather = ref.watch(weatherProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather',
        ),
      ),
      body: Column(
        children: [
          currentWeather.when(
            data: (data) {
              return Text(
                data,
                style: const TextStyle(
                  fontSize: 100.0,
                ),
              );
            },
            loading: () {
              return const Padding(
                padding: EdgeInsets.all(
                  16.0,
                ),
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blueAccent,
                ),
              );
            },
            error: (error, stack) {
              return const Text(
                'Error: 🙅🏾‍♀️',
              );
            },
          ),
          const SizedBox(
            height: 40.0,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: City.values.length,
              itemBuilder: (context, index) {
                // get the current city from the index
                final city = City.values[index];
                final isSelected = ref.watch(cityProvider) == city;
                return ListTile(
                  title: Text(
                    city.toString().split('.').last.toUpperCase(),
                  ),
                  trailing: isSelected
                      ? const Icon(
                          Icons.check,
                          color: Colors.green,
                        )
                      : null,
                  onTap: () {
                    // set the state of the cityProvider to the current city
                    ref.read(cityProvider.notifier).state = city;
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
