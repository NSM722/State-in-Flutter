import 'package:flutter/material.dart';
import 'package:flutter_state_management/provider/films_state_notifier_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FilmLists extends ConsumerWidget {
  // This parameter allows this widget to accept any type of provider
  final AlwaysAliveProviderBase<Iterable<Film>> provider;

  const FilmLists({super.key, required this.provider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final films = ref.watch(provider);
    final filmsNotifier = ref.read(filmsStateNotifierProvider.notifier);

    return Expanded(
      child: ListView.builder(
        itemCount: films.length,
        itemBuilder: (context, index) {
          final film = films.elementAt(index);
          final isFavoriteIcon =
              film.isFavorite ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border);
          return ListTile(
            title: Text(film.title),
            subtitle: Text(film.description),
            trailing: IconButton(
              icon: isFavoriteIcon,
              onPressed: () {
                filmsNotifier.toggleIsFavorite(film, film.isFavorite);
              },
            ),
          );
        },
      ),
    );
  }
}
