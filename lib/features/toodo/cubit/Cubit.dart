import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/features/toodo/cubit/states.dart';
import '../archive.dart';
import '../done.dart';
import '../new_task.dart';
List<Map> new_tasks = [];
List<Map> done_tasks = [];
List<Map> archive_tasks = [];

List<Widget> Screen = [
  NewTask(),
  done(),
  archive(),
];
List<String> title = ['new_task', 'done', 'archive'];

class AppCubit extends Cubit<AppState> {
  AppCubit(super.CubitInitialAppState);
  static AppCubit get(context) => BlocProvider.of(context);
  int idex = 1;
  void changeScreen(int value) {
    idex = value;
    emit(CubitChangeScreenAppState());
  }

  late Database database;

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
                'CREATE TABLE tasks (ID INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
            .then((value) {
          print('Table created');
        }).catchError((error) {
          print('ERORR $error');
        });
      },
      onOpen: (database) {
        getDataFromDataBase(database);
        print('database opend');
      },
    ).then((value) {
      database = value;
      emit(CubitCreateDatabaseAppState());
    });
  }

  Future insertToDatabase({
    required String time,
    required String date,
    required String title,
  }) async {
    return await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks (title, date ,time ,status) VALUES ("$title","$date","$time","new")')
          .then((value) {
        print('$value Insert Successful');
      }).catchError((error) {
        print('ERROR $error');
      });
      emit(CubitInsertDatabaseAppState());
      return null;
    });
  }

  void getDataFromDataBase(database) {
    database.rawQuery('SELECT * FROM tasks').then((value) {
      new_tasks=[];
      done_tasks=[];
      archive_tasks=[];
      value.forEach((element) {
        if(element['status']=='Done') {
          done_tasks.add(element);
        } else if(element['status']=='Archive') {
          archive_tasks.add(element);
        } else {
          new_tasks.add(element);
        }
        Navigator.pop;
      });
      emit(CubitGetDatabaseAppState());
    });
  }

  void deleteFromDataBase({required int id})
  {
    database.rawDelete(
      'DELETE FROM tasks WHERE id = ?',[id]
    ).then((value) =>{
      getDataFromDataBase(database),
      emit(CubitDeleteDatabaseAppState())
    });
  }


  Future<void> updateDataBase({required String state, required int id}) {
    return database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$state', id]).then((value) {
      getDataFromDataBase(database);
      emit(CubitUpDateDatabaseAppState());
    });
  }

  bool addNew = true;
  Icon iconAdd = const Icon(Icons.edit);
  void changeFloatingActionButton({required bool add, required Icon icon}) {
    addNew = add;
    iconAdd = icon;
    emit(CubitChangeFloatingActionButtonAppState());
  }


}
