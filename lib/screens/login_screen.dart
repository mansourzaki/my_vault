import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                    await provider.authinticate();
                    if (provider.isAuthenticated) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) =>  const MainScreen(),
                      ));
                    }
                  },
              child: Lottie.asset('assets/images/vault1.json',)),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(11)),
                      primary: const Color(0xFF4447E2),
                      padding: const EdgeInsets.all(20)),
                  onPressed: () async {
                    await provider.authinticate();
                    if (provider.isAuthenticated) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const MainScreen(),
                      ));
                    }
                  },
                  child: const Text('Unlock your vault',style: TextStyle(fontSize:18,decoration: TextDecoration.underline,color: Color(0xFF4447E2)),),
                ),
              ),  
            )
          ],
        ),
      ),
    );
  }
}
