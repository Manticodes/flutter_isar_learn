import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_isar_learn/collections/category.dart';
import 'package:flutter_isar_learn/collections/routine.dart';
import 'package:flutter_isar_learn/services/isar_services.dart';

import '../bloc/bloc/isar_bloc_bloc.dart';
import '../widgets/routine_card.dart';
import 'create_routine.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  List<Routine> searchList = <Routine>[];
  int? counter;
  countercat(IsarBlocState state) async {
    List<Routine> list =
        await IsarServices().getRoutineForCat(state.allCategories[5].id);
    counter = list.length;
  }

  @override
  Widget build(BuildContext context) {
    context.read<IsarBlocBloc>().add(LoadDB());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Routines'),
        actions: [
          ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Delete All'),
                      content: const Text('what to delete ?'),
                      actions: [
                        ElevatedButton(
                            onPressed: () => context
                                .read<IsarBlocBloc>()
                                .add(ClearRoutineDB()),
                            child: const Text('All')),
                        ElevatedButton(
                            onPressed: () {
                              context
                                  .read<IsarBlocBloc>()
                                  .add(ClearCategoryDB());
                              Navigator.pop(context);
                            },
                            child: const Text('Categories')),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel')),
                      ],
                    );
                  },
                );
              },
              child: const Text('Clear all')),
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return const CreateRoutine();
                  },
                );
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: BlocConsumer<IsarBlocBloc, IsarBlocState>(
        listener: (context, state) {
          context.read<IsarBlocBloc>().add(LoadDB());
          countercat(state);
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(' ${state.allRoutines.length} Routine Remain'),
                Text(counter.toString()),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                        onChanged: (String text) {
                          isSearching = true;
                          searchList = state.allRoutines
                              .where((element) => element.title.contains(text))
                              .toList();

                          if (searchController.text.isEmpty) {
                            isSearching = false;
                          }
                        },
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        controller: searchController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Search'),
                        )),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return RoutinCard(
                          routine: isSearching
                              ? searchList[index]
                              : state.allRoutines[index]);
                    },
                    itemCount: isSearching
                        ? searchList.length
                        : state.allRoutines.length,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return const CreateRoutine();
              },
            );
          },
          child: const Icon(Icons.add)),
    );
  }
}
