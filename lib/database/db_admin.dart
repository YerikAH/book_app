import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBAdmin{
  initDataBase() async {
    print("Iniciando db");
    // Con directory.path, capturamos el cirectorio de nuestra aplicación.
    // Con join, unimos path, en este caso creamos un archivo DBBooks.db
    Directory directory = await getApplicationDocumentsDirectory();
    String pathDataBase = join(directory.path, "DBBooks.db");
  }
}