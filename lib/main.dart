import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:flutter_state_management/provider/person_change_notifier_provider.dart';
// import 'package:flutter_state_management/examples/counter.dart';
// import 'package:flutter_state_management/examples/counter.dart';
// import 'package:flutter_state_management/examples/date.dart';
// import 'package:flutter_state_management/examples/weather.dart';
// import 'package:flutter_state_management/examples/names_streams.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Page',
        ),
      ),
      body: const Center(
        child: Text(
          '....',
        ),
      ),
    );
  }
}
