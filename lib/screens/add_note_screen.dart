import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../provider/db_provider.dart';
import '../widgets/custom_input_border.dart';

class AddNoteScreen extends StatefulWidget {
  static const routeName = 'addNote';
  final Note? note;
  final bool isEdit;
  const AddNoteScreen({Key? key, this.note, required this.isEdit})
      : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    if (widget.note != null) {
      titleController.text = widget.note!.title;
      contentController.text = widget.note!.content;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DbProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          title: Text(
            widget.isEdit ? 'Edit Note' : 'Add Note',
            style: const TextStyle(fontSize: 20, color: Colors.black),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
          child: Form(
            key: provider.noteFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                    controller: titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Title shouldn't be empty";
                      }
                    },
                    decoration: const InputDecoration(
                      //  labelStyle: TextStyle(color: Color(0xff4447E2)),
                      label: Text('Title'),
                      filled: true,
                      fillColor: Color(0xFFF7F7F7),
                      border: CustomOutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(11)),
                          borderSide: BorderSide.none),
                    )),
                const SizedBox(
                  height: 20,
                ),
                //need make max lines adaptive
                TextField(
                  controller: contentController,
                  maxLines: 20,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(color: Color(0xff4447E2)),
                    hintText: 'Note',
                    filled: true,
                    fillColor: Color(0xFFF7F7F7),
                    border: CustomOutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(11)),
                        borderSide: BorderSide.none),
                  ),
                ),
                SizedBox(
                  height: 125.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11)),
                        primary: const Color(0xFF4447E2),
                        padding: const EdgeInsets.all(20)),
                    onPressed: () async {
                      if (provider.noteFormKey.currentState!.validate()) {
                        if (widget.note == null) {
                          context.read<DbProvider>().addNewNote(Note(
                              title: titleController.text,
                              content: contentController.text));
                          log('added');
                          Navigator.pop(context);
                        } else {
                          context.read<DbProvider>().updateNote(Note(
                              id: widget.note!.id,
                              title: titleController.text,
                              content: contentController.text));
                          log('updadted');
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: const Text('Save'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
