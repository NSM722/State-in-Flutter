import 'package:flutter/material.dart';
import 'package:flutter_state_management/provider/person_change_notifier_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
      // only the body gets rebuilt when the persons list changes
      body: Consumer(
        builder: (context, ref, child) {
          final persons = ref.watch(personChangeNotifierProvider);
          return ListView.builder(
            itemCount: persons.personsCount,
            itemBuilder: (context, index) {
              final person = persons.persons[index];
              return ListTile(
                title: GestureDetector(
                  onTap: () async {
                    final updatedPerson = await createOrUpdatePerson(
                      context,
                      person,
                    );
                    if (updatedPerson != null) {
                      ref.read(personChangeNotifierProvider.notifier).addPerson(updatedPerson);
                    }
                  },
                  child: Text(person.displayName),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    ref.read(personChangeNotifierProvider.notifier).removePerson(person);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.lightGreenAccent,
                        content: Text('Person details deleted'),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newPerson = await createOrUpdatePerson(context, null);
          if (newPerson != null) {
            ref.read(personChangeNotifierProvider.notifier).addPerson(newPerson);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

final nameController = TextEditingController();
final ageController = TextEditingController();

Future<PersonState?> createOrUpdatePerson(
  BuildContext context,
  PersonState? existingPerson,
) async {
  String? name = existingPerson?.name;
  int? age = existingPerson?.age;

  nameController.text = name ?? '';
  ageController.text = age?.toString() ?? '';

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Create person'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Enter Name...',
              ),
              onChanged: (value) => name = value,
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(
                labelText: 'Enter Age...',
              ),
              onChanged: (value) => age = int.tryParse(value),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (name != null || age != null) {
                if (existingPerson != null) {
                  // update the existing person
                  final newPerson = existingPerson.setPersonDetails(name, age);
                  Navigator.of(context).pop(newPerson);
                } else {
                  // create a new person
                  final createdPerson = PersonState(
                    name: name!,
                    age: age!,
                  );
                  Navigator.of(context).pop(createdPerson);
                }
              } else {
                Navigator.of(context).pop();
              }
            },
            child: const Text('Save'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}
