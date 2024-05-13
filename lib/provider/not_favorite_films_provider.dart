import 'package:flutter_state_management/provider/films_state_notifier_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final notFavoriteFilmsProvider = Provider<List<Film>>((ref) =>
    ref.watch(filmsStateNotifierProvider).where((element) => !element.isFavorite).toList());
