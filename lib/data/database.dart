import 'package:hive/hive.dart';

class ToDoDatabase {

  List toDoList = [];

  // reference the box
  final _mybox = Hive.box('mybox');


  // run this method if this is the first time opening this app
  void createInitialData(){
    toDoList = [
    ["Make Tutorial", false],
    ["Do Exercise", false],
    ];
  }

  //load the data frommthe database
  void loadData(){
    toDoList = _mybox.get("TODOLIST");
  }

  //update the database
  void updateDataBase(){
    _mybox.put("TODOLIST", toDoList);
  }
  

}