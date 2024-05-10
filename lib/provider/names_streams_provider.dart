import 'package:hooks_riverpod/hooks_riverpod.dart';

const List<String> names = [
  'Emma',
  'Liam',
  'Olivia',
  'Noah',
  'Ava',
  'William',
  'Sophia',
  'James',
  'Isabella',
  'Benjamin',
  'Mia',
  'Elijah',
];

// create stream provider
final tickerProvider = StreamProvider<int>((ref) {
  // provide values from 1
  return Stream.periodic(
    const Duration(seconds: 1),
    (x) => x + 1,
  );
});

// create names provider which will listen to the tickerProvider
// and return the names list based on the value of the tickerProvider
final namesProvider = StreamProvider((ref) {
  // convert the tickerProvider future to a stream
  final ticker = ref.watch(tickerProvider.future).asStream();
  // return the names list based on the value of the tickerProvider
  return ticker.map(
    (count) => names.getRange(
      0,
      count,
    ),
  );
});
