import 'package:flutter/material.dart';
import 'package:notes/models/notes.dart';

class EditScreen extends StatefulWidget {
  final Note? note;
  const EditScreen({super.key, this.note});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    if (widget.note != null) {
      titleController = TextEditingController(text: widget.note!.title);
      contentController = TextEditingController(text: widget.note!.content);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  TextField(
                    keyboardType: TextInputType.multiline,
                    controller: titleController,
                    style:  const TextStyle(color: Colors.grey, fontSize: 30),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Title",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 30)
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: contentController,
                    style:  const TextStyle(color: Colors.grey),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Content",
                      hintStyle: TextStyle(color: Colors.grey)
                    ),
                  )
                ],
              )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pop([titleController, contentController]);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}