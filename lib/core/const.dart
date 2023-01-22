import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import '../features/toodo/cubit/Cubit.dart';

Widget defaultMaterialButton(
    {required var function,
      required String text,
      bool isUpper = true,
      double width = double.infinity,
      Color color = Colors.blue,
      Color textColor = Colors.white}) {
  return Container(
    width: width,
    color: color,
    child: MaterialButton(
      onPressed: function,
      child: Text((isUpper) ? text.toUpperCase() : text,
          style: TextStyle(
            color: textColor,
          )),
    ),
  );
}

Widget defaultTextFormField({
  required TextEditingController controller,
  TextInputType type = TextInputType.none,
  required var validate,
  required String lable,
  required IconData prefix,
  IconButton? sufix,
  var onTap,
  onSubmit,
  onChange,
  bool isPass = false,
}) {
  return TextFormField(
    obscureText: isPass,
    onFieldSubmitted: onSubmit,
    onChanged: onChange,
    onTap: onTap,
    validator: validate,
    controller: controller,
    keyboardType: type,
    decoration: InputDecoration(
      // border:  const OutlineInputBorder(),
      labelText: lable,
      prefixIcon: Icon(prefix),
      suffixIcon: ((sufix) != null) ? sufix : null,

    ),
  );
}

Widget buildNewTasks(Map tasks, context) {
  return Dismissible(
    key: Key(tasks['ID'].toString()),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40.0,
            child: Center(
                child: Text(
                  '${tasks['time']}',
                  style: const TextStyle(fontSize: 15.0),
                )),
          ),
          const SizedBox(
            width: 15.0,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${tasks['title']}',
                  style: const TextStyle(fontSize: 20.0),
                ),
                Text(
                  '${tasks['date']}',
                  style: const TextStyle(fontSize: 15.0),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(context)
                  .updateDataBase(state: 'Done', id: tasks['ID']);
            },
            icon: const Icon(Icons.check_circle_outline),
            color: Colors.green,
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(context)
                  .updateDataBase(state: 'Archive', id: tasks['ID']);
            },
            icon: const Icon(Icons.archive),
            color: Colors.grey,
          )
        ],
      ),
    ),
    onDismissed: (direction) {
      AppCubit.get(context).deleteFromDataBase(id: tasks['ID']);
    },
  );
}

// ignore: non_constant_identifier_names
Widget ListOfTasks({required List<Map> task}) {
  return ConditionalBuilder(
      condition: task.isNotEmpty,
      builder: (context) => ListView.separated(
          itemBuilder: (context, index) => buildNewTasks(task[index], context),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: task.length),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.menu,
              size: 80.0,
              color: Colors.grey,
            ),
            Text(
              'No Tasks Yet',
              style: TextStyle(fontSize: 20.0),
            )
          ],
        ),
      ));
}

Widget myDivider() {
  return Padding(
    padding: const EdgeInsetsDirectional.only(start: 20.0),
    child: Container(
      color: Colors.grey,
      height: 2.0,
    ),
  );
}


void NavigatorTo(context, Widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return Widget;
  }));
}

void NavigatorAndFinish(context, Widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) {
      return Widget;
    }),
        (route) => false,
  );
}

//'http://mobisite202.somee.com';
    //'http://thewinnerteach-001-site1.etempurl.com';