import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

@immutable
class PersonState {
  final String name;
  final int age;
  final String? id;

  PersonState({
    required this.name,
    required this.age,
  }) : id = uuid.v4(); // Generate a random id

  PersonState copyWith({
    String? name,
    int? age,
  }) {
    return PersonState(
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }

  setPersonDetails(String? name, int? age) {
    final newPersonDetails = copyWith(
      name: name,
      age: age,
    );

    return newPersonDetails;
  }

  String get displayName => '$name is $age years old.';

  // compare the two instances of the Person class
  @override
  bool operator ==(covariant PersonState other) => id == other.id;

  // hash the id of the Person class
  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Person{name: $name, age: $age, id: $id}';
  }
}

// create a ChangeNotifier class
class PersonChangeNotifier extends ChangeNotifier {
  final List<PersonState> _persons = [];

  // expose the count of the persons in a consumer widget
  int get personsCount => _persons.length;

  // only expose the persons in a consumer widget but the list is unmodifiable
  UnmodifiableListView<PersonState> get persons => UnmodifiableListView(_persons);

  void addPerson(PersonState person) {
    _persons.add(person);
    // notify the listeners of the change in the list
    notifyListeners();
  }

  void removePerson(PersonState person) {
    _persons.remove(person);
    // notify the listeners of the change in the list
    notifyListeners();
  }

  void updatePerson(PersonState updatedPerson) {
    // check if the person exists in the list
    final index = _persons.indexOf(updatedPerson);
    final oldPerson = _persons[index];

    // update the person
    if (oldPerson.name != updatedPerson.name || oldPerson.age != updatedPerson.age) {
      _persons[index] = oldPerson.copyWith(
        name: updatedPerson.name,
        age: updatedPerson.age,
      );
      notifyListeners();
    }
  }
}

// the ref object is not required in this case hence the underscore (_) is used
final personChangeNotifierProvider = ChangeNotifierProvider((_) => PersonChangeNotifier());
