import 'dart:math';
import 'package:flutter/material.dart';
import 'package:notes/cards.dart';
import 'package:notes/constants/colors.dart';
import 'package:notes/edits.dart';
import 'package:notes/models/notes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  _delete(int index){
    setState(() {
      sampleNotes.removeAt(index);
    });
  }

  void _addNewNote() async{
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const EditScreen(),
    ));

    if (result != null){
      setState(() {
      sampleNotes.add(
        Note(id: sampleNotes.length, title: result[0].text, content: result[1].text, lastModified: DateTime.now(),
        ),
      );
        filteredNotes = sampleNotes;
      });
    }
  }

  Color _getRandomColor(){
    Random randColor = Random();
    return backgroundColors[randColor.nextInt(backgroundColors.length)];
  }

  List<Note> filteredNotes = [];
  bool sorted = false;

  List<Note>sortByModifiedTime(List<Note> notes){
    if(sorted){
      notes.sort((a, b) => a.lastModified.compareTo(b.lastModified));
    }else{
      notes.sort((b, a) => a.lastModified.compareTo(b.lastModified));
    }

    sorted != sorted;
    return notes;
  }

  @override
  void initState() {
    super.initState();
    filteredNotes = sampleNotes;
  }

  void searchTextChanged(String searchText){
  setState(() {
    filteredNotes =
    sampleNotes.where((note) => note.content.toLowerCase().contains(searchText.toLowerCase()) ||
    note.title.toLowerCase().contains(searchText.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Notes",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () {
                        setState(() {
                          filteredNotes = sortByModifiedTime(filteredNotes);
                        });
                      },
                      icon: const Icon(Icons.sort),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: searchTextChanged,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 13),
                  hintText: "Search notes...",
                  hintStyle: const TextStyle(color: Colors.white),
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.2),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.2),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredNotes.length,
                itemBuilder: ((context, index) {
                  return CardTile(
                    onTap: () async{
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => EditScreen(
                          note: filteredNotes[index]
                        )
                        )
                      );
                      if (result != null){
                        setState(() {
                        int original = sampleNotes.indexOf(filteredNotes[index]);
                        sampleNotes[original] = Note(
                          id: sampleNotes[original].id,
                          title: result[0].text,
                          content: result[1].text,
                          lastModified: DateTime.now());

                          filteredNotes[index] = Note(
                            id: filteredNotes[index].id,
                            title: result[0].text,
                            content: result[1].text,
                            lastModified: DateTime.now());
                        });
                      }
                    },
                    title: filteredNotes[index].title,
                    content: filteredNotes[index].content,
                    dateAndTime: filteredNotes[index].lastModified,
                    color: _getRandomColor(),
                    delFunction: (){
                      _delete(index);
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewNote,
        child: const Icon(Icons.add),
      ),
    );
  }
}
