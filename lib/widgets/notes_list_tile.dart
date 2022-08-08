import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../provider/db_provider.dart';
import '../screens/add_note_screen.dart';
import '../shared.dart';

class NotesListTile extends StatelessWidget {
  final Note note;
  const NotesListTile({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: Colors.red,
        alignment: AlignmentDirectional.centerEnd,
        child: const Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (dir) {
        return confirmDismiss(context,'note');
      },
      onDismissed: (direction) {
        context.read<DbProvider>().deleteNote(note.id!);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Note deleted'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ));
      },
      key: UniqueKey(),
      child: ListTile(
        title: Text(note.title),
        subtitle: Text(note.content, overflow: TextOverflow.ellipsis),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddNoteScreen(
              note: note,
              isEdit: true,
            ),
          ));
        },
        trailing: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddNoteScreen(
                note: note,
                isEdit: true,
              ),
            ));
          },
          color: Colors.black,
          iconSize: 8.w,
          icon: FaIcon(
            FontAwesomeIcons.arrowRight,
            color: Colors.black,
          ),
        ),
        leading: Container(
          child: Center(
            child: Icon(Icons.note_add_sharp),
          ),
          width: 50.w,
          height: 51.h,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 229, 227, 227),
              borderRadius: BorderRadius.circular(9)),
        ),
      ),
    );
  }
}
