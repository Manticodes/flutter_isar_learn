// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc/isar_bloc_bloc.dart';
import '../collections/routine.dart';
import '../screens/update_routine_page.dart';

class RoutinCard extends StatelessWidget {
  final Routine routine;

  const RoutinCard({
    Key? key,
    required this.routine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Text(
            routine.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 2.0),
            child: RichText(
                text: TextSpan(children: [
              const WidgetSpan(
                child: Icon(Icons.category),
              ),
              TextSpan(text: ' ${routine.category.value!.name}')
            ])),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 2.0),
            child: RichText(
                text: TextSpan(children: [
              const WidgetSpan(
                child: Icon(Icons.lock_clock),
              ),
              TextSpan(text: ' ${routine.startTime}')
            ])),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: RichText(
                text: TextSpan(children: [
              const WidgetSpan(
                child: Icon(Icons.calendar_month),
              ),
              TextSpan(text: ' ${routine.day}'),
              const WidgetSpan(
                  child: SizedBox(
                width: 20,
              )),
            ])),
          )
        ]),
        trailing: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  child: const Icon(Icons.delete),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Delete Routine'),
                          content: const Text(
                            'Are u sure you want to delete this item ?',
                            style: TextStyle(fontSize: 15),
                          ),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<IsarBlocBloc>()
                                      .add(DeleteRoutine(routine: routine));
                                  Navigator.pop(context);
                                },
                                child: const Text('Yes')),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('No')),
                          ],
                        );
                      },
                    );
                  },
                ),
                const SizedBox(
                  width: 25,
                ),
                InkWell(
                    onTap: () {
                      _updateRoutine(context, routine);
                    },
                    child: const Icon(Icons.keyboard_arrow_right)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _updateRoutine(BuildContext context, Routine routine) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return UpdateRoutinePage(
          routine: routine,
        );
      },
    );
  }

  /* _deleteRoutine(BuildContext context) async {
    await isar.writeTxn(() => isar.routines.delete(routine.id));
    Navigator.pop(context);
  } */
}
