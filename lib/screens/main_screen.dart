
import 'package:flutter/material.dart';
import 'package:my_vault/screens/passwords_screen.dart';

import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import 'add_card_screen.dart';
import 'add_note_screen.dart';
import 'add_password_screen.dart';
import 'cards_screen.dart';
import 'dashboard_screen.dart';
import 'login_screen.dart';
import 'notes_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> pages = [
    const DashboardScreen(),
    const CardsScreen(),
    const NotesScreen(),
    const PasswordsScreen(),
  ];
  int _selectedIndex = 0;
  void _onTap(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: context.watch<AuthProvider>().isAuthenticated
          ? pages[_selectedIndex]
          : const LoginScreen(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: !context.watch<AuthProvider>().isAuthenticated
          ? const SizedBox()
          : FloatingActionButton(
           
              backgroundColor: Colors.black,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () async {
                // final isAuthenticated = await LocalAuthApi.authenticate();
                // final isAvailable = await LocalAuthApi.hasBiometrics();
                // final biometrics = await LocalAuthApi.getBiometrics();
                // final hasFingerprint =
                //     biometrics.contains(BiometricType.fingerprint);
                // final hasFace = biometrics.contains(BiometricType.face);
                // log('face $hasFace');
                // log('isA $isAvailable');
                // log('bio $biometrics');
                if (_selectedIndex == 1) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddCardScreen(
                      isEdit: false,
                    ),
                  ));
                } else if (_selectedIndex == 2) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddNoteScreen(
                      isEdit: false,
                    ),
                  ));
                } else if (_selectedIndex == 3) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        const AddPasswordScreen(isEdit: false),
                  ));
                }
              },
            ),
      bottomNavigationBar: !context.watch<AuthProvider>().isAuthenticated
          ? const SizedBox()
          : BottomNavigationBar(
              iconSize: 30,
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              fixedColor: Colors.black,
              onTap: _onTap,
              selectedLabelStyle: const TextStyle(
                color: Colors.black,
              ),
              unselectedLabelStyle: const TextStyle(color: Colors.black),
              items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      color: Colors.black,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.credit_card_sharp,
                      color: Colors.black,
                    ),
                    label: 'Cards ',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.note_add_sharp,
                      color: Colors.black,
                    ),
                    label: 'Notes',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    label: 'Passwords',
                  ),
                ]),
    );
  }
}
