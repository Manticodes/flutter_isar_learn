// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_isar_learn/services/isar_services.dart';
import '../bloc/bloc/isar_bloc_bloc.dart';
import '../collections/routine.dart';
import '../screens/update_routine_page.dart';

class RoutinCard extends StatefulWidget {
  final Routine routine;
  RoutinCard({
    Key? key,
    required this.routine,
  }) : super(key: key);

  @override
  State<RoutinCard> createState() => _RoutinCardState();
}

class _RoutinCardState extends State<RoutinCard> {
  @override
  void initState() {
    setcount();
    super.initState();
  }

  int? counter;

  setcount() async {
    int id = widget.routine.category.value!.id;
    List<Routine> list = await IsarServices().getRoutineForCat(id);
    counter = list.length;
    print(counter);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: ListTile(
        subtitle: Text(counter.toString()),
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Text(
            widget.routine.title,
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
              TextSpan(text: ' ${widget.routine.category.value?.name}')
            ])),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 2.0),
            child: RichText(
                text: TextSpan(children: [
              const WidgetSpan(
                child: Icon(Icons.lock_clock),
              ),
              TextSpan(text: ' ${widget.routine.startTime}')
            ])),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: RichText(
                text: TextSpan(children: [
              const WidgetSpan(
                child: Icon(Icons.calendar_month),
              ),
              TextSpan(text: ' ${widget.routine.day}'),
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
                                  context.read<IsarBlocBloc>().add(
                                      DeleteRoutine(routine: widget.routine));
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
                      _updateRoutine(context, widget.routine);
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
}
