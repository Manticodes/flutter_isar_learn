import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc/isar_bloc_bloc.dart';
import '../widgets/routine_card.dart';
import 'create_routine.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
        },
        builder: (context, state) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return RoutinCard(routine: state.allRoutines[index]);
            },
            itemCount: state.allRoutines.length,
          );
        },
      ),
      /* Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
               Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                        onChanged: _searchRoutine,
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
                child: FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!;
                    } else {
                      return Container();
                    }
                  },
                  future: listBuilder(),
                ),
              ),
            ],
          )), */
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
