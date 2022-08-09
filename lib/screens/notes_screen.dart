import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';

import '../provider/db_provider.dart';
import '../widgets/notes_list_tile.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DbProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 55.h, bottom: 5.h, left: 12.w),
              child: const Text(
                'Notes',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.h),
              child: TextField(
                onChanged: context.read<DbProvider>().searchFun,
                decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 244, 241, 241),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(11))),
              ),
            ),
            context.watch<DbProvider>().notes.isEmpty
                ? Center(child: Lottie.asset('assets/images/notes.json'))
                : ListView.builder(
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: provider.notes
                        .where((element) => element.title
                            .toLowerCase()
                            .contains(provider.search.toLowerCase()))
                        .length,
                    itemBuilder: (context, i) {
                      return NotesListTile(
                          note: provider.notes
                              .where((element) => element.title
                                  .toLowerCase()
                                  .contains(provider.search.toLowerCase()))
                              .toList()[i]);
                    })
          ],
        ),
      ),
    );
  }
}
