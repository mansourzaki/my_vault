import '../helpers/db_helper.dart';

class Note {
  int? id;
  late String title;
  late String content;

  Note({this.id, required this.title, required this.content});

  Note.fromJson(Map<String, dynamic> json) {
    id = json[DbHelper.notesIdColumnName];
    title = json[DbHelper.notesTitleColumnName];
    content = json[DbHelper.notesContentColumnName];
  }

  Map<String, dynamic> toJson() {
    return {
      DbHelper.notesTitleColumnName: title,
      DbHelper.notesContentColumnName: content
    };
  }
}
