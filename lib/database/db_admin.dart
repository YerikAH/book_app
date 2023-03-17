import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBAdmin{
    // Con directory.path, capturamos el cirectorio de nuestra aplicación.
    // Con join, unimos path, en este caso creamos un archivo DBBooks.db
  initDataBase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String pathDataBase = join(directory.path, "DBBooks.db");
    return await openDatabase(
      pathDataBase,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE BOOK(id INTEGER PRIMARY KEY AUTOINCREMENT , title TEXT, author TEXT, description TEXT, image TEXT)"
        );
      }
    );
  }
}