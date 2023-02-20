import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_isar_learn/bloc/bloc/isar_bloc_bloc.dart';
import 'package:flutter_isar_learn/screens/create_routine.dart';
import 'package:flutter_isar_learn/services/color_schemes.g.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'collections/category.dart';
import 'collections/routine.dart';

void main() async {
  /*  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationSupportDirectory();
  final isar = await Isar.open(
    [RoutineSchema, CategorySchema],
    directory: dir.path,
  ); */
  runApp(BlocProvider(
    create: (context) => IsarBlocBloc(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'routing app',
      theme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: Home2(),
    ),
  ));
}

/* class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();
  List<Routine>? routines;
  bool isSearching = false;
  @override
  void initState() {
    _readRoutinea();
    super.initState();
  }

  _readRoutinea() async {
    final routineCollection = widget.isar.routines;
    final getRoutines = await routineCollection.where().findAll();
    setState(() {
      routines = getRoutines;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      actions: [
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
                      ],
                    );
                  },
                );
              },
              child: Text('Clear all')),
          IconButton(
              onPressed: () {
                _addRoutine(context, widget.isar);
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
          )),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _addRoutine(context, widget.isar);
          },
          child: const Icon(Icons.add)),
    );
  }

  Future<ListView> listBuilder() async {
    if (isSearching == false) {
      await _readRoutinea();
    }

    return ListView.builder(
      itemBuilder: (context, index) {
        if (index < routines!.length) {
          return RoutinCard(
            isar: widget.isar,
            routine: routines![index],
          );
        } else {
          return Container();
        }
      },
      itemCount: routines!.length,
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

  _searchRoutine(String text) async {
    isSearching = true;
    final searchResult =
        await widget.isar.routines.filter().titleContains(text).findAll();
    setState(() {
      routines = searchResult;
      if (searchController.text.isEmpty) {
        isSearching = false;
      }
    });
  }

  _clearAll(BuildContext context) async {
    await widget.isar.writeTxn(() async {
      await widget.isar.routines.clear();
    });
    Navigator.pop(context);
  }

  _clearAllC(BuildContext context) async {
    await widget.isar.writeTxn(() async {
      await widget.isar.categorys.clear();
    });
    Navigator.pop(context);
  }
} */

class Home2 extends StatelessWidget {
  const Home2({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<IsarBlocBloc>().add(LoadRoutine());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Routines'),
        actions: [
          /*  ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Delete All'),
                        content: Text('what to delete ?'),
                        actions: [
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
                        ],
                      );
                    },
                  );
                },
                child: Text('Clear all')), */
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return CreateRoutine();
                  },
                );
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: BlocBuilder<IsarBlocBloc, IsarBlocState>(
        builder: (context, state) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text(
                state.allRoutines[index].startTime,
              ));
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
                return CreateRoutine();
              },
            );
          },
          child: const Icon(Icons.add)),
    );
  }
}
