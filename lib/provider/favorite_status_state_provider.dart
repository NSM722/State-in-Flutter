import 'package:hooks_riverpod/hooks_riverpod.dart';

enum FavoriteStatus {
  all,
  favorite,
  notFavorite,
}

extension FavoriteStatusInfo on FavoriteStatus {
  String get statusName {
    switch (this) {
      case FavoriteStatus.all:
        return 'All';
      case FavoriteStatus.favorite:
        return 'Favorite';
      case FavoriteStatus.notFavorite:
        return 'Not Favorite';
      default:
        return '';
    }
  }
}

// create a state provider for favorite status
final favoriteStatusStateProvider = StateProvider<FavoriteStatus>((_) {
  return FavoriteStatus.all;
});
