import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_isar_learn/collections/category.dart';
import 'package:flutter_isar_learn/collections/routine.dart';
import 'package:flutter_isar_learn/screens/create_routine.dart';
import 'package:flutter_isar_learn/screens/update_routine.dart';
import 'package:flutter_isar_learn/services/color_schemes.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationSupportDirectory();
  final isar = await Isar.open(
    [RoutineSchema, CategorySchema],
    directory: dir.path,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'routing app',
    theme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
    home: HomePage(isar: isar),
  ));
}

class HomePage extends StatefulWidget {
  final Isar isar;
  HomePage({
    Key? key,
    required this.isar,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Routine>? routines;
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
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateRoutine(isar: widget.isar),
                      ));
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: routines != null
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    return RoutinCard(
                      isar: widget.isar,
                      routine: routines![index],
                    );
                  },
                  itemCount: routines!.length,
                )
              : Container(),
        ));
  }
}

class RoutinCard extends StatelessWidget {
  final Routine routine;
  final Isar isar;
  const RoutinCard({
    Key? key,
    required this.routine,
    required this.isar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: ListTile(
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Text(
              routine.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 2.0),
            child: RichText(
                text: TextSpan(children: [
              const WidgetSpan(
                child: Icon(Icons.lock_clock),
              ),
              TextSpan(text: routine.startTime)
            ])),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: RichText(
                text: TextSpan(children: [
              const WidgetSpan(
                child: Icon(Icons.calendar_month),
              ),
              TextSpan(text: routine.day)
            ])),
          )
        ]),
        trailing: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    UpdateRoutine(isar: isar, routine: routine),
              ));
            },
            child: const Icon(Icons.keyboard_arrow_right)),
      ),
    );
  }
}
