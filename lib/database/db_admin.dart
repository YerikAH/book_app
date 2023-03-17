import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBAdmin{
    // Con directory.path, capturamos el cirectorio de nuestra aplicación.
    // Con join, unimos path, en este caso creamos un archivo DBBooks.db
    // Ya no es necesario poner CREATE DATABASE, ya que se crea cuando creamos el archivo
    // openDataBase, es para abrir nuestra base de datos, recibe el path, la versión de nuestra base de datos, y onCreate, se ejecuta cuando se crea una nueva base de datos. En esta función se pueden crear las tablas y establecer los índices necesarios para la base de datos.
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