import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class Film {
  final String id;
  final String title;
  final String description;
  final bool isFavorite;

  const Film({
    required this.id,
    required this.title,
    required this.description,
    required this.isFavorite,
  });

  // create a function for updating state
  Film copyWith({
    String? id,
    String? title,
    String? description,
    bool? isFavorite,
  }) {
    return Film(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  // necessary function for debugging
  @override
  String toString() {
    return 'Film(id: $id, '
        'title: $title, '
        'description: $description, '
        'isFavorite: $isFavorite)';
  }

  // necessary function for comparing two objects
  @override
  bool operator ==(covariant Film other) {
    return id == other.id &&
        title == other.title &&
        description == other.description &&
        isFavorite == other.isFavorite;
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        isFavorite,
      ]);
}

// create a list of films
const films = [
  Film(
      id: "1",
      title: "The Shawshank Redemption",
      description:
          "Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.",
      isFavorite: true),
  Film(
      id: "2",
      title: "The Godfather",
      description:
          "An organized crime dynasty's aging patriarch transfers control of his clandestine empire to his reluctant son.",
      isFavorite: false),
  Film(
      id: "3",
      title: "The Dark Knight",
      description:
          "When the menace known as The Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham.",
      isFavorite: true),
  Film(
      id: "4",
      title: "Pulp Fiction",
      description:
          "The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.",
      isFavorite: false),
  Film(
      id: "5",
      title: "Inception",
      description:
          "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.",
      isFavorite: true),
  Film(
      id: "6",
      title: "The Matrix",
      description:
          "A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.",
      isFavorite: false),
  Film(
      id: "7",
      title: "Interstellar",
      description:
          "A team of explorers travel through a wormhole in space in an attempt to ensure humanity's survival.",
      isFavorite: true),
  Film(
      id: "8",
      title: "Fight Club",
      description:
          "An insomniac office worker and a devil-may-care soapmaker form an underground fight club that evolves into something much, much more.",
      isFavorite: false),
  Film(
      id: "9",
      title: "The Avengers",
      description:
          "Earth's mightiest heroes must come together and learn to fight as a team if they are going to stop the mischievous Loki and his alien army from enslaving humanity.",
      isFavorite: true),
];

// create the state notifier class that has a list of all the films in the system
// this notifier allows one to toggle the isFavorite property of a film
class FilmsNotifier extends StateNotifier<List<Film>> {
  // populate the state with the list of films
  FilmsNotifier() : super(films);

  // toggle the isFavorite property of a film
  void toggleIsFavorite(Film film, bool isFavorite) {
    // map through the state and update the film with the new isFavorite value
    state = state.map((f) => f.id == film.id ? f.copyWith(isFavorite: !isFavorite) : f).toList();
  }
}

// create a state notifier provider for the films notifier
final filmsStateNotifierProvider = StateNotifierProvider<FilmsNotifier, List<Film>>((_) {
  return FilmsNotifier();
});
