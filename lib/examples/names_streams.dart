import 'package:flutter/material.dart';
import 'package:flutter_state_management/provider/names_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final names = ref.watch(namesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stream Provider',
        ),
      ),
      body: names.when(
        data: (names) {
          return ListView.builder(
              itemCount: names.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Center(
                    child: Text(
                      names.elementAt(index),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.yellowAccent),
                    ),
                  ),
                );
              });
        },
        error: (error, stackTrace) => const Center(
          child: Text(
            'Reached the end of the list!',
            style: TextStyle(
              color: Colors.lightBlueAccent,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
