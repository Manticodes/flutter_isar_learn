import 'package:flutter/material.dart';
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
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'routing app',
    theme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
    home: HomePage(isar: isar),
  ));
}

class HomePage extends StatefulWidget {
  final Isar isar;
  const HomePage({
    Key? key,
    required this.isar,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: const Center(
        child: Text('asda'),
      ),
    );
  }
}
