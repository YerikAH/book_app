import 'package:app_book/database/db_admin.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
         child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (){
                  DBAdmin admin = DBAdmin();
                  admin.initDataBase();
              },
              child: const Text("Database"),
            )
          ],
         )
      ),
    );
  }
}