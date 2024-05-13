import 'package:flutter/material.dart';
import 'package:flutter_state_management/examples/film_lists.dart';
import 'package:flutter_state_management/provider/favorite_films_provider.dart';
import 'package:flutter_state_management/provider/favorite_status_state_provider.dart';
import 'package:flutter_state_management/provider/films_state_notifier_provider.dart';
import 'package:flutter_state_management/provider/not_favorite_films_provider.dart';
import 'package:flutter_state_management/widgets/filter_favorite.dart';
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
          'Great Films',
        ),
      ),
      body: Column(
        children: [
          const FilterFavorites(),
          Consumer(
            builder: (context, ref, child) {
              final filter = ref.watch(favoriteStatusStateProvider);
              switch (filter) {
                case FavoriteStatus.all:
                  return FilmLists(
                    provider: filmsStateNotifierProvider,
                  );
                case FavoriteStatus.favorite:
                  return FilmLists(
                    provider: favoriteFilmsProvider,
                  );
                case FavoriteStatus.notFavorite:
                  return FilmLists(
                    provider: notFavoriteFilmsProvider,
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
