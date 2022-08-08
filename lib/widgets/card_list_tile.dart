import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../models/credit_card.dart';
import '../provider/db_provider.dart';
import '../screens/add_card_screen.dart';
import '../shared.dart';

class CardsListTile extends StatelessWidget {
  final CreditCard card;
  const CardsListTile({Key? key, required this.card}) : super(key: key);

  String creditNumberFormatter(String num) {
    String first = num.substring(0, 4);
    String second = num.substring(12, 16);
    return '$first **** **** $second';
  }

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
      onDismissed: (direction) {
        context.read<DbProvider>().deleteCard(card.id!);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Card deleted'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ));
      },
      confirmDismiss: (dir) {
        return confirmDismiss(context,'card');
      },
      key: UniqueKey(),
      child: ListTile(
        title: Text(card.title),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddCardScreen(
              card: card,
              isEdit: true,
            ),
          ));
        },
        subtitle: Text(creditNumberFormatter(card.number)),
        trailing: IconButton(
            onPressed: () {},
            color: const Color.fromARGB(255, 17, 37, 189),
            iconSize: 26.w,
            icon: const Icon(Icons.more_vert)),
        leading: Container(
          width: 50.w,
          height: 51.h,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 229, 227, 227),
              borderRadius: BorderRadius.circular(9)),
          child: Center(
              child: card.number[0] == '4'
                  ? const FaIcon(FontAwesomeIcons.ccVisa,
                      color: Color.fromARGB(255, 7, 67, 116))
                  : Image.asset(
                      'assets/images/master.png',
                      fit: BoxFit.cover,
                      width: 50,
                    )),
        ),
      ),
    );
  }
}
