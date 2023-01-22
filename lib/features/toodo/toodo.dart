import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../core/const.dart';
import 'cubit/Cubit.dart';
import 'cubit/states.dart';

class Tasks extends StatelessWidget {
  @override
  var scafoldKey = GlobalKey<ScaffoldState>();
  var titleController = TextEditingController(),
      timeController = TextEditingController(),
      dateController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Tasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(CubitInitialAppState())..createDatabase(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit Cubit = AppCubit.get(context);
          return Scaffold(
            key: scafoldKey,
            appBar: AppBar(
              title: Text(title[Cubit.idex]),
            ),
            body: ConditionalBuilder(
              condition: true,
              builder: (context) => Screen[Cubit.idex],
              fallback: (context) => const Center(
                  child: CircularProgressIndicator(
                color: Colors.red,
              )),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (Cubit.addNew) {
                  scafoldKey.currentState!
                      .showBottomSheet(
                        (context) => Form(
                          key: formKey,
                          child: Container(
                            padding: const EdgeInsets.all(20.0),
                            color: Colors.grey[100],
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Text must be not empty";
                                    }
                                    return null;
                                  },
                                  controller: titleController,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Task Name',
                                    prefixIcon: Icon(Icons.text_fields),
                                  ),
                                ),
                                const SizedBox(height: 15.0),
                                defaultTextFormField(
                                  onTap: () {
                                    showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                        .then((value) {
                                      timeController.text =
                                          value!.format(context).toString();
                                    });
                                  },
                                  controller: timeController,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return "Text must be not empty";
                                    }
                                    return null;
                                  },
                                  lable: 'Task Time',
                                  prefix: Icons.watch_later_outlined,
                                ),
                                const SizedBox(height: 15.0),
                                defaultTextFormField(
                                    onTap: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate:
                                                  DateTime.parse('2030-05-01'))
                                          .then((value) {
                                        dateController.text = DateFormat.yMMMd()
                                            .format(value!)
                                            .toString();
                                      });
                                    },
                                    controller: dateController,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return "Text must be not empty";
                                      }
                                      return null;
                                    },
                                    lable: 'Task Date',
                                    prefix: Icons.date_range)
                              ],
                            ),
                          ),
                        ),
                      )
                      .closed
                      .then((value) {
                    Cubit.changeFloatingActionButton(
                        icon: const Icon(Icons.edit), add: true);
                  });
                  Cubit.changeFloatingActionButton(
                      icon: const Icon(Icons.add), add: false);
                } else if (formKey.currentState!.validate()) {
                  Cubit.changeFloatingActionButton(
                    icon: const Icon(Icons.edit),
                    add: true,
                  );
                  Cubit.insertToDatabase(
                          date: dateController.text,
                          title: titleController.text,
                          time: timeController.text)
                      .then((value) {
                    Cubit.getDataFromDataBase(Cubit.database);
                    Navigator.pop(context);
                  });
                }
              },
              child: Cubit.iconAdd,
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (value) {
                Cubit.changeScreen(value);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu), label: 'New task'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive), label: 'Archive'),
              ],
              iconSize: 30.0,
              currentIndex: Cubit.idex,
            ),
          );
        },
      ),
    );
  }
}
