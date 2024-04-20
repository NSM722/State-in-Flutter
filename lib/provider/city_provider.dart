import 'package:flutter_state_management/provider/weather_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// provider to hold the current city provided by the user on the UI
// a notifier class is implicitly created for this provider by Riverpod
final cityProvider = StateProvider<City?>((ref) => null);
