class Note{
  final int id;
  final String title;
  final String content;
  final DateTime lastModified;

  const Note({required this.id, required this.title, required this.content, required this.lastModified,
});
}

List<Note> sampleNotes = [
  Note(
    id: 0,
    title: "Beginning Anime",
    content: "1. Naruto\n2. Attack on Titan\n3.Demon slayer",
    lastModified: DateTime(2023, 4, 5, 34, 5),
  ),
  Note(
    id: 1,
    title: "Learning to Code",
    content: "1. Pick a language\n2. Learn as deeply as you feel\n3.Build a project",
    lastModified: DateTime(2023, 4, 5, 34, 5),
  ),
  Note(
    id: 2,
    title: "How to get the girls",
    content: "1. Improve upon yourself\n2. Do not be a simp\n3. Limit your interactions",
    lastModified: DateTime(2023, 4, 5, 34, 5),
  ),
];