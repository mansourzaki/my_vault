import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

import '../models/credit_card.dart';
import '../models/note.dart';
import '../models/password.dart';

class DbHelper {
  Database? database;
  static DbHelper dbHelper = DbHelper();
  static String passwordsTableName = 'passwords';
  static String cardsTableName = 'cards';
  static String notesTableName = 'notes';
  // ------------
  static String passwordsIdColumnName = 'id';
  static String passwordsTitlColumnName = 'title';
  static String passwordsUrlColumnName = 'url';
  static String passwordsUsernameColumnName = 'username';
  static String passwordColumnName = 'password';
  //---------------------

  // ------------
  static String cardsIdColumnName = 'id';
  static String cardsTitleColumnName = 'title';
  static String cardsHolderNameColumnName = 'name';
  static String cardsCardNumberColumnName = 'number';
  static String cardsExpirationDateColumnName = 'date';
  static String cardsCvvColumnName = 'cvv';
  static String cardsPinColumnName = 'pin';
  //---------------------
  static String notesIdColumnName = 'id';
  static String notesTitleColumnName = 'title';
  static String notesContentColumnName = 'content';

  DbHelper() {
    initDatabase();
  }
  initDatabase() async {
    database = await createConnectionWithDatabase();
  }

  Future<Database> createConnectionWithDatabase() async {
    String dbPath = await getDatabasesPath();
    String dbName = 'myDb.db';
    String fullPath = path.join(dbPath, dbName);

    Database database =
        await openDatabase(fullPath, version: 1, onCreate: (db, i) async {
      await db.execute(
          '''CREATE TABLE $passwordsTableName ($passwordsIdColumnName INTEGER PRIMARY KEY, $passwordsTitlColumnName TEXT, $passwordsUrlColumnName Text, $passwordsUsernameColumnName Text,$passwordColumnName Text)''');
      await db.execute(
          '''CREATE TABLE $cardsTableName ($cardsIdColumnName INTEGER PRIMARY KEY, $cardsTitleColumnName TEXT, $cardsHolderNameColumnName Text, $cardsCardNumberColumnName Text,$cardsExpirationDateColumnName int,$cardsCvvColumnName Integer,$cardsPinColumnName Integer)''');
      await db.execute(
          '''CREATE TABLE $notesTableName ($notesIdColumnName INTEGER PRIMARY KEY, $notesTitleColumnName TEXT, $notesContentColumnName Text)''');
    }, onOpen: (db) async {
      final tables =
          await db.rawQuery('SELECT name FROM sqlite_master ORDER BY name;');
      log(tables.toString());
      //db.delete(notesTableName);
      //print('db opened');
    });
    return database;
  }

  Future<List<Password>> selectAllPasswords() async {
    List<Map<String, dynamic>> rowsAsMap =
        await database!.query(passwordsTableName);
    List<Password> passwords =
        rowsAsMap.map((e) => Password.fromJson(e)).toList();
    return passwords;
  }

  Future<List<CreditCard>> selectAllCards() async {
    List<Map<String, dynamic>> rowsAsMap =
        await database!.query(cardsTableName);
    List<CreditCard> cards =
        rowsAsMap.map((e) => CreditCard.fromJson(e)).toList();
    return cards;
  }

  Future<List<Note>> selectAllNotes() async {
    List<Map<String, dynamic>> rowsAsMap =
        await database!.query(notesTableName);
    List<Note> notes = rowsAsMap.map((e) => Note.fromJson(e)).toList();
    return notes;
  }

  addNewPassword(Password password) async {
    int index = await database!.insert(passwordsTableName, password.toJson());
    log(index.toString());
  }

  addNewCard(CreditCard card) async {
    int index = await database!.insert(cardsTableName, card.toJson());
    log(index.toString());
  }

  addNewNote(Note note) async {
    // log(note.toJson());
    int index = await database!.insert(notesTableName, note.toJson());
    log(index.toString());
  }

  updateOnePassword(Password password) async {
    int x = await database!.update(passwordsTableName, password.toJson(),
        where: '$passwordsIdColumnName= ?', whereArgs: [password.id]);
    log(x.toString());
  }

  updateOneCard(CreditCard card) async {
    //log(card.id.toString());
  //  var xy = await database!.query(cardsTableName);
    //print(card.toJson());
    int x = await database!.update(cardsTableName, card.toJson(),
        where: 'id= ?', whereArgs: [card.id]);
    log(x.toString());
  }

  updateOneNote(Note note) async {
    int x = await database!.update(notesTableName, note.toJson(),
        where: '$notesIdColumnName = ?', whereArgs: [note.id]);
    log(x.toString());
  }

  deletePassword(int id) async {
    await database!.delete(passwordsTableName,
        where: '$passwordsIdColumnName = ?', whereArgs: [id]);
    log('deleted');
  }

  deleteNote(int id) async {
    await database!.delete(notesTableName,
        where: '$notesIdColumnName = ?', whereArgs: [id]);
    log('deleted');
  }

  deleteCard(int id) async {
    await database!.delete(cardsTableName,
        where: '$cardsIdColumnName = ?', whereArgs: [id]);
    log('deleted');
  }
}
