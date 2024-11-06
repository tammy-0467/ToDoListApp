import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todoapp/Util/dialog_box.dart';
import 'package:todoapp/Util/todo_tile.dart';
import 'package:todoapp/data/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    // if this is the first time ever opening the app create default data
    if (_myBox.get("TODOLIST") == null){
      db.createInitialData();
    } else {
      //there already exists data
      db.loadData();
    }
    super.initState();
  }

  //text controller
  final _controller = TextEditingController();


  //checkbox was tapped
  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  // Save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
   }

  //create a new task
  void createNewTask (){
    showDialog(
      context: context,
        builder: (context){
          return DialogBox(
              controller: _controller,
              onSave: saveNewTask,
              onCancel: Navigator.of(context).pop,
          );
    });
  }

  // delete task
  void deleteTask (int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text('Todo'),
        elevation: 0,

      ),

      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (Context, index){
          return TodoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context)=> deleteTask(index),
          );
        },
      )
    );
  }
}
