import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'helpers/db_helper.dart';
import 'provider/auth_provider.dart';
import 'provider/db_provider.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.dbHelper.initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (context, child) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider<DbProvider>(
                  create: (context) => DbProvider(),
                ),
                ChangeNotifierProvider<AuthProvider>(
                  create: (context) => AuthProvider(),
                ),
              ],
              child: MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(
                  
                  primarySwatch: Colors.blue,
                ),
                home: const MainScreen(),
              ));
        });
  }
}
