import 'package:flutter/material.dart';

import 'my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox({super.key, required this.controller, required this.onSave, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).primaryColor,
      content: Container(
        height: 120,
        child: Column(
          children: [
             TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task"
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //Save Button
                  MyButton(text: "Save", onPressed: onSave,),

                  const SizedBox(width: 8,),

                  //Cancel Button
                  MyButton(text: "Cancel", onPressed: onCancel)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
