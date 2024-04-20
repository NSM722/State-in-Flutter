import 'package:hooks_riverpod/hooks_riverpod.dart';

// The value held my this provider is a DateTime object
// that can only be read by its dependents but not modified
final currentDate = Provider<DateTime>(
  (ref) => DateTime.now(),
);

//OR
final currentDateProvider = Provider<DateTime>((_) {
  return DateTime.now();
});
