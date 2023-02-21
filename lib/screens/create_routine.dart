import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_isar_learn/collections/category.dart';
import 'package:flutter_isar_learn/collections/routine.dart';

import '../bloc/bloc/isar_bloc_bloc.dart';

/* class CreateRoutine extends StatefulWidget {
  const CreateRoutine({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateRoutine> createState() => _CreateRoutineState();
}

class _CreateRoutineState extends State<CreateRoutine> {
  List<Category>? categories;
  Category? dropDownValue;
  List<String> days = [
    'sunday',
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday'
  ];
  TimeOfDay selectedTime = TimeOfDay.now();
  String dayDropDownValue = 'sunday';
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var newCatController = TextEditingController();
  _selectedTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dialOnly);

    if (timeOfDay != null && timeOfDay != selectedTime) {
      selectedTime = timeOfDay;
      setState(() {
        timeController.text =
            "${selectedTime.hour}:${selectedTime.minute} ${selectedTime.period.name}";
      });
    }
  }

  _addcategory(Isar isar) async {
    final categories = isar.categorys;
    final newcategory = Category()..name = newCatController.text;
    await isar.writeTxn(() async => await categories.put(newcategory));
    newCatController.clear();
    _readCategory();
  }

  _readCategory() async {
    final categorycollection = widget.isar.categorys;
    final getcategory = await categorycollection.where().findAll();
    setState(() {
      dropDownValue = null;
      categories = getcategory;
    });
  }

  _addRoutine() async {
    final newRoutine = Routine()
      ..category.value = dropDownValue
      ..title = titleController.text
      ..startTime = timeController.text
      ..day = dayDropDownValue;

    await widget.isar.writeTxn(() async {
      await routines.put(newRoutine);
      await newRoutine.category.save();
    });
    titleController.clear();
    timeController.clear();
    setState(() {
      dropDownValue = null;
      dayDropDownValue = "monday";
    });
  }

  @override
  void initState() {
    super.initState();
    _readCategory();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Category'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: DropdownButton(
                    isExpanded: true,
                    items: categories?.map((e) {
                      return DropdownMenuItem<Category>(
                        value: e,
                        child: Text(e.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        dropDownValue = value!;
                      });
                    },
                    value: dropDownValue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('New Category'),
                            content:
                                TextFormField(controller: newCatController),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    if (newCatController.text.isNotEmpty) {
                                      _addcategory(widget.isar);
                                    }
                                  },
                                  child: const Text('Add'))
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.add))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextField(
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                decoration: const InputDecoration(
                    labelStyle: TextStyle(fontSize: 18),
                    label: Text('title'),
                    border: OutlineInputBorder()),
                controller: titleController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: InkWell(
                    onTap: () {
                      _selectedTime(context);
                    },
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelStyle: TextStyle(fontSize: 18),
                          // label: Text('Start Time'),
                          border: OutlineInputBorder()),
                      controller: timeController,
                      enabled: false,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      _selectedTime(context);
                    },
                    icon: const Icon(Icons.calendar_month))
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Text('Day'),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: DropdownButton(
                isExpanded: true,
                value: dayDropDownValue,
                items: days.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    dayDropDownValue = value!;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _addRoutine();
                        dropDownValue = null;
                        dayDropDownValue = "monday";
                        titleController.clear();
                        timeController.clear();
                      });
                    },
                    child: const Text('Add')))
          ]),
        ),
      ),
    );
  }
} */

class CreateRoutine extends StatefulWidget {
  CreateRoutine({super.key});

  @override
  State<CreateRoutine> createState() => _CreateRoutineState();
}

class _CreateRoutineState extends State<CreateRoutine> {
  Category? dropDownValue;

  List<String> days = [
    'sunday',
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday'
  ];

  TimeOfDay selectedTime = TimeOfDay.now();

  String dayDropDownValue = 'sunday';

  var titleController = TextEditingController();

  final TextEditingController timeController = TextEditingController();

  var newCatController = TextEditingController();

  _selectedTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dialOnly);

    if (timeOfDay != null && timeOfDay != selectedTime) {
      selectedTime = timeOfDay;

      timeController.text =
          "${selectedTime.hour}:${selectedTime.minute} ${selectedTime.period.name}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IsarBlocBloc, IsarBlocState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Category'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: DropdownButton(
                            isExpanded: true,
                            items: state.allCategories.map((e) {
                              return DropdownMenuItem<Category>(
                                value: e,
                                child: Text(e.name),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                dropDownValue = value!;
                              });
                            },
                            value: dropDownValue,
                            icon: const Icon(Icons.keyboard_arrow_down),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('New Category'),
                                    content: TextFormField(
                                        controller: newCatController),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            if (newCatController
                                                .text.isNotEmpty) {
                                              context.read<IsarBlocBloc>().add(
                                                  AddCategory(
                                                      category: Category()
                                                        ..name =
                                                            newCatController
                                                                .text));
                                              newCatController.clear();
                                            }
                                          },
                                          child: const Text('Add'))
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.add))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextField(
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        decoration: const InputDecoration(
                            labelStyle: TextStyle(fontSize: 18),
                            label: Text('title'),
                            border: OutlineInputBorder()),
                        controller: titleController,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: InkWell(
                            onTap: () {
                              _selectedTime(context);
                            },
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  labelStyle: TextStyle(fontSize: 18),
                                  // label: Text('Start Time'),
                                  border: OutlineInputBorder()),
                              controller: timeController,
                              enabled: false,
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              _selectedTime(context);
                            },
                            icon: const Icon(Icons.calendar_month))
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text('Day'),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: DropdownButton(
                        isExpanded: true,
                        value: dayDropDownValue,
                        items: days.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            dayDropDownValue = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: ElevatedButton(
                            onPressed: () {
                              context.read<IsarBlocBloc>().add(AddRoutine(
                                  routine: Routine()
                                    ..category.value = dropDownValue
                                    ..title = titleController.text
                                    ..startTime = timeController.text
                                    ..day = dayDropDownValue));
                              dropDownValue = null;
                              dayDropDownValue = "monday";
                              titleController.clear();
                              timeController.clear();
                            },
                            child: const Text('Add')))
                  ]),
            ),
          ),
        );
      },
    );
  }
}
