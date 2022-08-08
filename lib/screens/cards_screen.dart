import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'package:provider/provider.dart';

import '../provider/db_provider.dart';
import '../widgets/card_list_tile.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({Key? key}) : super(key: key);

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DbProvider>(context);
    log(provider.cards.toString());
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 55.h, bottom: 5.h, left: 12.w),
              child: const Text(
                'Cards',
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
            ListView.builder(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: context
                    .watch<DbProvider>()
                    .cards
                    .where((element) => element.title
                        .toLowerCase()
                        .contains(provider.search.toLowerCase()))
                    .length,
                itemBuilder: (context, i) {
                  log('message');
                  return CardsListTile(
                      card: context
                          .watch<DbProvider>()
                          .cards
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
