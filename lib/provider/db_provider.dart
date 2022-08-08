import 'dart:developer';

import 'package:flutter/material.dart';


import '../helpers/db_helper.dart';
import '../models/credit_card.dart';
import '../models/note.dart';
import '../models/password.dart';

class DbProvider with ChangeNotifier {
  List<Password> passwords = [];
  List<CreditCard> cards = [];
  List<Note> notes = [];
  String search = '';
  GlobalKey<FormState> noteFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> cardFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> passFormKey = GlobalKey<FormState>();
  bool isSnackbarActive = false;
  DbProvider() {
    getAllCards();
    getAllModels();
  }
  searchFun(String query) {
    search = query;
    notifyListeners();
  }

  changeSnackBarState(){
    isSnackbarActive = !isSnackbarActive;
    notifyListeners();
  }

  getAllModels() async {
    getAllCards();
    getAllPasswords();

    getAllNotes();
    notifyListeners();
  }

  getAllPasswords() async {
    passwords = await DbHelper.dbHelper.selectAllPasswords();
  }

  getAllCards() async {
    cards = await DbHelper.dbHelper.selectAllCards();
    notifyListeners();
  }

  getAllNotes() async {
    notes = await DbHelper.dbHelper.selectAllNotes();
  }

  addNewNote(Note note) async {
    await DbHelper.dbHelper.addNewNote(note);
    notes.add(note);
    getAllNotes();
    notifyListeners();
  }

  addNewPassword(Password pass) async {
    await DbHelper.dbHelper.addNewPassword(pass);
    passwords.add(pass);
    getAllPasswords();
    notifyListeners();
  }

  addNewCard(CreditCard card) async {
    await DbHelper.dbHelper.addNewCard(card);
    cards.add(card);
    notifyListeners();
  }

  deleteNote(int id) async {
    await DbHelper.dbHelper.deleteNote(id);
    getAllModels();
  }

  deletePassword(int id) async {
    await DbHelper.dbHelper.deletePassword(id);
    getAllModels();
  }

  deleteCard(int id) async {
    await DbHelper.dbHelper.deleteCard(id);
    getAllModels();
  }

  updateNote(Note note) async {
    await DbHelper.dbHelper.updateOneNote(note);
    await getAllNotes();
    log('updadated');
    notifyListeners();
  }

  updateCard(CreditCard card) async {
    await DbHelper.dbHelper.updateOneCard(card);
    await getAllCards();
    notifyListeners();
  }

  updatePassword(Password password) async {
    await DbHelper.dbHelper.updateOnePassword(password);
    await getAllPasswords();
    notifyListeners();
  }
}
