import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_isar_learn/logic/bloc/bloc_isar/isar_bloc.dart';
import 'package:flutter_isar_learn/widgets/routine_card.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_isar_learn/collections/category.dart';
import 'package:flutter_isar_learn/collections/routine.dart';
import 'package:flutter_isar_learn/screens/create_routine.dart';
import 'package:flutter_isar_learn/services/color_schemes.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationSupportDirectory();
  final isar = await Isar.open(
    [RoutineSchema, CategorySchema],
    directory: dir.path,
  );
  runApp(BlocProvider(
    create: (context) => IsarBloc(),
    child: BlocBuilder<IsarBloc, IsarState>(
      builder: (context, state) {
        context.read<IsarBloc>().add(AddIsar(isar: isar));
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'routing app',
          theme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
          home: HomePage(),
        );
      },
    ),
  ));
}

class HomePage extends StatelessWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  final TextEditingController searchController = TextEditingController();
  List<Routine>? routines;
  bool isSearching = false;
  /*   void initState() {
    _readRoutinea();
    super.initState();
  } */

  /*  _readRoutinea() async {
    final routineCollection = isar.routines;
    final getRoutines = await routineCollection.where().findAll();
//todo need state
    routines = getRoutines;

    /* setState(() {
      routines = getRoutines;
    }); */
  } */

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IsarBloc, IsarState>(
      builder: (context, state) {
        Isar isar = state.isarList[0];
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
                          title: Text('Delete All'),
                          content: Text('what to delete ?'),
                          /* actions: [
                            ElevatedButton(
                                onPressed: () => _clearAll(context),
                                child: Text('Routines')),
                            ElevatedButton(
                                onPressed: () => _clearAllC(context),
                                child: Text('Categories')),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancel')),
                          ], */
                        );
                      },
                    );
                  },
                  child: Text('Clear all')),
              IconButton(
                  onPressed: () {
                    _addRoutine(context, isar);
                  },
                  icon: const Icon(Icons.add))
            ],
          ),
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                          // onChanged: _searchRoutine,
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
                      if (index < routines!.length) {
                        return RoutinCard(
                          isar: isar,
                          routine: routines![index],
                        );
                      } else {
                        return Container();
                      }
                    },
                    itemCount: routines!.length,
                  )),
                ],
              )),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                _addRoutine(context, isar);
              },
              child: const Icon(Icons.add)),
        );
      },
    );
  }

  void _addRoutine(BuildContext context, Isar isar) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return CreateRoutine(isar: isar);
      },
    );
  }

  /* _searchRoutine(String text) async {
    isSearching = true;
    final searchResult =
        await isar.routines.filter().titleContains(text).findAll();

    //todo need state
    /*  setState(() {
      routines = searchResult;
      if (searchController.text.isEmpty) {
        isSearching = false;
      }
    }); */
  } */

  /* _clearAll(BuildContext context) async {
    await isar.writeTxn(() async {
      await isar.routines.clear();
    });
    Navigator.pop(context);
  } */

  /* _clearAllC(BuildContext context) async {
    await isar.writeTxn(() async {
      await isar.categorys.clear();
    });
    Navigator.pop(context);
  } */
}
