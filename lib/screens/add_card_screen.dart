import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';
import '../models/credit_card.dart';
import '../provider/db_provider.dart';
import '../widgets/custom_input_border.dart';

class AddCardScreen extends StatefulWidget {
  final CreditCard? card;
  final bool isEdit;
  const AddCardScreen({Key? key, this.card, required this.isEdit})
      : super(key: key);

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController expDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  // String creditNumberFormatter(String num) {
  //   String first = num.substring(0, 4);
  //   String second = num.substring(4, 8);
  //   String third = num.substring(8, 12);
  //   String last = num.substring(12, 16);

  //   return '$first $second $third $last';
  // }

  @override
  void initState() {
    if (widget.card != null) {
      titleController.text = widget.card!.title;
      nameController.text = widget.card!.name;
      numberController.text = widget.card!.number;
      expDateController.text = DateFormat('MM/yy').format(widget.card!.date);
      cvvController.text = widget.card!.cvv.toString();
      pinController.text = widget.card!.pin.toString();
    }
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    nameController.dispose();
    numberController.dispose();
    expDateController.dispose();
    cvvController.dispose();
    pinController.dispose();
    super.dispose();
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
              widget.isEdit ? 'Edit Card' : 'Add Card',
              style: const TextStyle(fontSize: 20, color: Colors.black),
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Form(
              key: provider.cardFormKey,
              child: Column(
                children: [
                  TextFormField(
                      controller: titleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Title mustn\'t be empty';
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
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name mustn\'t be empty';
                        }
                      },
                      decoration: const InputDecoration(
                        floatingLabelStyle: TextStyle(color: Color(0xff4447E2)),
                        label: Text('Cardholder Name'),
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
                      controller: numberController,
                      maxLength: 16,
                      keyboardType: TextInputType.number,
                     autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Number mustn\'t be empty';
                        }
                        if (!isNumeric(value)) {
                          return 'Not valid card number';
                        }
                        if (value.length != 16) {
                          return 'Card number must be 16 digits';
                        }
                      },
                      decoration: const InputDecoration(
                        floatingLabelStyle: TextStyle(color: Color(0xff4447E2)),
                        label: Text('Card Number'),
                        filled: true,
                        counterText: '',
                        fillColor: Color(0xFFF7F7F7),
                        border: CustomOutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(11)),
                            borderSide: BorderSide.none),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      controller: expDateController,
                      keyboardType: TextInputType.datetime,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Date mustn\'t be empty';
                        }
                      },
                      inputFormatters: [CreditCardExpirationDateFormatter()],
                      decoration: const InputDecoration(
                        floatingLabelStyle: TextStyle(color: Color(0xff4447E2)),
                        label: Text('Expiration Date'),
                        hintText: '00/00',
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
                      controller: cvvController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Cvv mustn\'t be empty';
                        }
                        if (!isNumeric(value)) {
                          return 'must be digits';
                        }
                        if (value.length != 3) {
                          return 'Cvv must be 3 digits';
                        }
                      },
                      decoration: const InputDecoration(
                        floatingLabelStyle: TextStyle(color: Color(0xff4447E2)),
                        label: Text('CVV'),
                        hintText: '000',
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
                      controller: pinController,
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Pin mustn\'t be empty';
                        }
                        if (!isNumeric(value)) {
                          return 'Pin be digits';
                        }
                        if (value.length != 4) {
                          return 'Pin must be 4 digits';
                        }
                      },
                      decoration: const InputDecoration(
                        floatingLabelStyle: TextStyle(color: Color(0xff4447E2)),
                        label: Text('Pin'),
                        filled: true,
                        fillColor: Color(0xFFF7F7F7),
                        border: CustomOutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(11)),
                            borderSide: BorderSide.none),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 140.h,
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
                        String number = '';
                        if (numberController.text.isNotEmpty) {
                          List<String> x = numberController.text.split(' ');
                          print(x);
                          number = x.join();
                        }
                        numberController.text = number;

                        if (provider.cardFormKey.currentState!.validate()) {
                          log(widget.card.toString());
                          if (widget.card == null) {
                            log('add');
                            context.read<DbProvider>().addNewCard(CreditCard(
                                title: titleController.text,
                                name: nameController.text,
                                number: numberController.text,
                                date: DateTime.now(),
                                cvv: int.parse(cvvController.text),
                                pin: int.parse(pinController.text)));
                          } else {
                            log('update');
                            context.read<DbProvider>().updateCard(CreditCard(
                                id: widget.card!.id,
                                title: titleController.text,
                                name: nameController.text,
                                number: numberController.text,
                                date: DateTime.now(),
                                cvv: int.parse(cvvController.text),
                                pin: int.parse(pinController.text)));
                          }

                          //log(DateTime.parse('formattedString'));
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Save'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
