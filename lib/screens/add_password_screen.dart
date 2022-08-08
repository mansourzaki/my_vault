import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:random_password_generator/random_password_generator.dart';

import '../models/password.dart';
import '../provider/db_provider.dart';
import '../widgets/custom_input_border.dart';

class AddPasswordScreen extends StatefulWidget {
  final Password? password;
  final bool isEdit;
  const AddPasswordScreen({Key? key, this.password, required this.isEdit})
      : super(key: key);

  @override
  State<AddPasswordScreen> createState() => _AddPasswordScreenState();
}

class _AddPasswordScreenState extends State<AddPasswordScreen> {
  double _sliderValue = 1;
  bool _upperCase = false;
  bool _lowerCase = false;
  bool _digits = false;
  bool _symbols = false;
  bool _generate = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isVisible = false;
  String passwordGenerator() {
    final password = RandomPasswordGenerator();
    return password.randomPassword(
        letters: _lowerCase,
        uppercase: _upperCase,
        numbers: _digits,
        specialChar: _symbols,
        passwordLength: _sliderValue);
  }

  @override
  void initState() {
    if (widget.password != null) {
      titleController.text = widget.password!.title;
      urlController.text = widget.password!.url;
      emailController.text = widget.password!.userName;
      passwordController.text = widget.password!.password;
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
              widget.isEdit ? 'Edit Password' : 'Add Password',
              style: const TextStyle(fontSize: 20, color: Colors.black),
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Form(
              key: provider.passFormKey,
              child: Column(
                children: [
                  TextFormField(
                      controller: titleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Title shouldn't be empty";
                        }
                      },
                      decoration: const InputDecoration(
                        floatingLabelStyle: TextStyle(color: Color(0xff4447E2)),
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
                  TextFormField(
                      controller: urlController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Webiste Url shouldn't be empty";
                        }

                        // if (isURL(value, {'require_tld': false})) {
                        //   return 'please enter a vaild url';
                        // }
                      },
                      decoration: const InputDecoration(
                        floatingLabelStyle: TextStyle(color: Color(0xff4447E2)),
                        label: Text('Website URl'),
                        filled: true,
                        fillColor: Color(0xFFF7F7F7),
                        border: CustomOutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(11)),
                            borderSide: BorderSide.none),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "email or username shouldn't be empty";
                        }
                      },
                      decoration: const InputDecoration(
                        floatingLabelStyle: TextStyle(color: Color(0xff4447E2)),
                        label: Text('Email or Username'),
                        filled: true,
                        fillColor: Color(0xFFF7F7F7),
                        border: CustomOutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(11)),
                            borderSide: BorderSide.none),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      obscureText: isVisible,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "password mustn't be empty";
                        }
                      },
                      controller: passwordController,
                      decoration: InputDecoration(
                        floatingLabelStyle: const TextStyle(color: Color(0xff4447E2)),
                        label: const Text('Password'),
                        filled: true,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            icon: Icon(isVisible
                                ? Icons.visibility
                                : Icons.visibility_off)),
                        fillColor: const Color(0xFFF7F7F7),
                        border: const CustomOutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(11)),
                            borderSide: BorderSide.none),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      child: const Text(
                        'Generate Password',
                        style: TextStyle(color: Color(0xFF4447E2)),
                      ),
                      onPressed: () {
                        _generate = !_generate;
                        setState(() {});
                      },
                    ),
                  ),
                  !_generate
                      ? SizedBox(
                          height: 1.h,
                        )
                      : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Length',
                                  style:  TextStyle(
                                      color:  Color(0xFF4447E2),
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 232.w,
                                  child: Slider(
                                    activeColor: const Color(0xFF4447E2),
                                    value: _sliderValue,
                                    onChanged: (value) {
                                      _sliderValue = value;
                                      passwordController.text =
                                          passwordGenerator();
                                      setState(() {});
                                    },
                                    divisions: 32,
                                    max: 32,
                                    min: 1,
                                    thumbColor: const Color(0xFF4447E2),
                                  ),
                                ),
                                Text(_sliderValue.floor().toString()),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Use uppercase letters (A-Z)',
                                  style:  TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Switch(
                                    value: _upperCase,
                                    onChanged: (v) {
                                      _upperCase = v;
                                      setState(() {});
                                    })
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Use lowercase letters (a-z)',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Switch(
                                    value: _lowerCase,
                                    onChanged: (v) {
                                      _lowerCase = v;
                                      setState(() {});
                                    })
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Use digits (0-9)',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Switch(
                                    value: _digits,
                                    onChanged: (v) {
                                      _digits = v;
                                      setState(() {});
                                    })
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Use Symbols',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Switch(
                                    value: _symbols,
                                    onChanged: (v) {
                                      _symbols = v;
                                      setState(() {});
                                    })
                              ],
                            ),
                          ],
                        ),
                  !_generate
                      ? SizedBox(
                          height: 210.h,
                        )
                      : SizedBox(
                          height: 40.h,
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
                        if (provider.passFormKey.currentState!.validate()) {
                          if (widget.password == null) {
                            await context.read<DbProvider>().addNewPassword(
                                Password(
                                    title: titleController.text.trim(),
                                    url: urlController.text.trim(),
                                    userName: emailController.text.trim(),
                                    password: passwordController.text.trim()));
                            log('added');
                            Navigator.pop(context);
                          } else {
                            await context.read<DbProvider>().updatePassword(
                                Password(
                                    id: widget.password!.id,
                                    title: titleController.text.trim(),
                                    url: urlController.text.trim(),
                                    userName: emailController.text.trim(),
                                    password: passwordController.text.trim()));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Password Updated'),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                            ));
                            log('updadted');
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
