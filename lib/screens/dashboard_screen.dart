import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../models/credit_card.dart';
import '../provider/db_provider.dart';

import '../widgets/password_listTile.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late FToast fToast;
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  _showToast() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.black,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          SizedBox(
            width: 12.0,
          ),
          Text(
            "Card number copied",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  String creditNumberFormatter(String num) {
    String first = num.substring(0, 4);
    String second = num.substring(12, 16);
    return '$first **** **** $second';
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Padding(
          padding: EdgeInsets.only(left: 1, right: 10, top: 25),
          child: ListTile(
            title: Text(greeting()),
            subtitle: const Text('Welcome to your vault'),
            trailing: const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.black,
              child: Icon(Icons.password),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: const Text(
                      'Cards',
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_right_sharp)
                ],
              ),
              SizedBox(
                height: 200.h,
                child: context.watch<DbProvider>().cards.isEmpty
                    ?  Center(
                        child: Lottie.asset('assets/images/cards.json'))
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: context.watch<DbProvider>().cards.length,
                        itemBuilder: (context, i) {
                          CreditCard card =
                              context.watch<DbProvider>().cards[i];
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            width: 350.w,
                            height: 150.h,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      'assets/images/credit.png',
                                    )),
                                color: Colors.blue[400],
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 20.w, right: 30.w, top: 15.h),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const FaIcon(
                                        FontAwesomeIcons.trashCan,
                                        color: Colors.white,
                                        size: 22,
                                      ),
                                      const Spacer(),
                                      Text(
                                        card.title,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 22),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 55.h,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        creditNumberFormatter(card.number),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 22),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          Clipboard.setData(
                                              ClipboardData(text: card.number));
                                          fToast.showToast(
                                            child: _showToast(),
                                            gravity: ToastGravity.BOTTOM,
                                            toastDuration:
                                                const Duration(seconds: 2),
                                          );
                                        },
                                        icon: const FaIcon(
                                          FontAwesomeIcons.clone,
                                          color: Colors.white,
                                          size: 22,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 1),
                                    child: Row(
                                      children: [
                                        Text(
                                          DateFormat('MM/yy').format(card.date),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                        SizedBox(
                                          width: 50.w,
                                        ),
                                        const Text(
                                          'CVV',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        const Text(
                                          '***',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: const Text(
                      'Passwords',
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_right_sharp)
                ],
              ),
              context.watch<DbProvider>().passwords.isEmpty
                  ?Center(child: Lottie.asset('assets/images/password.json'))
                  : ListView.builder(
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount:
                          context.watch<DbProvider>().passwords.take(5).length,
                      itemBuilder: (context, i) {
                        return PasswordListTile(
                            password: context.watch<DbProvider>().passwords[i]);
                      })
            ],
          ),
        ),
      ),
    );
  }
}
