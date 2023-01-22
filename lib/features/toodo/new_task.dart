import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/const.dart';
import 'cubit/Cubit.dart';
import 'cubit/states.dart';

class NewTask extends StatelessWidget {
  const NewTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        listener: (context,state){},
      builder: (context,state){
          return ListOfTasks(task: new_tasks);
      },
    );
  }
}
