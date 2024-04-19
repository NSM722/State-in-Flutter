import 'package:flutter/material.dart';
import 'package:flutter_state_management/provider/counter_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer(
          // the ref in this builder function only rebuilds this Consumer widget
          builder: (context, ref, child) {
            final count = ref.watch(counterProvider);
            final text =
                (count == null || count == 0) ? 'Press the increment button' : count.toString();
            return Text(
              text,
            );
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            // OR
            // onPressed: () {
            //   ref.read(counterProvider.notifier).increment();
            // },
            onPressed: ref.read(counterProvider.notifier).increment,
            child: const Text(
              'Increment',
            ),
          ),
        ],
      ),
    );
  }
}
