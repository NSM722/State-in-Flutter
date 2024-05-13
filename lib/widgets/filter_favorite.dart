import 'package:flutter/material.dart';
import 'package:flutter_state_management/provider/favorite_status_state_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FilterFavorites extends ConsumerWidget {
  const FilterFavorites({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteStatus = ref.watch(favoriteStatusStateProvider);

    return DropdownButton(
      value: favoriteStatus,
      items: FavoriteStatus.values
          .map((status) => DropdownMenuItem(
                value: status,
                child: Text(status.statusName),
              ))
          .toList(),
      onChanged: (value) {
        ref.read(favoriteStatusStateProvider.notifier).state = value as FavoriteStatus;
      },
    );
  }
}
