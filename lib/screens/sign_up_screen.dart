import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'login',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 82.h,
            ),
            Padding(
              padding: EdgeInsets.all(16.sp),
              child: Text(
                'Sign up',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30.sp),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'Full Name',
                  filled: true,
                  fillColor: const Color.fromARGB(255, 244, 241, 241),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(11))),
            ),
            SizedBox(
              height: 14.sp,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  fillColor: const Color.fromARGB(255, 244, 241, 241),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(11))),
            ),
            SizedBox(
              height: 14.h,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: const Color.fromARGB(255, 244, 241, 241),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(11))),
            ),
            SizedBox(
              height: 23.h,
            ),
            Row(
              children: const [
                Expanded(
                    child: Divider(
                  endIndent: 20,
                  thickness: 1,
                  color: Color(0xFFD9D9D9),
                )),
                Text('or Sign up with'),
                Expanded(
                    child: Divider(
                  indent: 20,
                  thickness: 1,
                  color: Color(0xFFD9D9D9),
                )),
              ],
            ),
            SizedBox(
              height: 22.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 99.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 244, 241, 241),
                      borderRadius: BorderRadius.circular(12)),
                  child: Image.asset('assets/images/google.png'),
                ),
                Container(
                  width: 99.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 244, 241, 241),
                      borderRadius: BorderRadius.circular(12)),
                  child: SvgPicture.asset(
                    'assets/images/facebooksv.svg',
                    width: 20.w,
                    height: 20.h,
                  ),
                ),
                Container(
                  width: 99.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 244, 241, 241),
                      borderRadius: BorderRadius.circular(12)),
                  child: Image.asset(
                    'assets/images/apple.png',
                    width: 22.w,
                    height: 22.h,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11)),
                      primary: const Color(0xFF4447E2),
                      padding: const EdgeInsets.all(20)),
                  onPressed: () {},
                  child: const Text('Sign u p'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
