import 'dart:math';

import 'package:app_book/database/db_admin.dart';
import 'package:app_book/model/model.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double pyth = sqrt(pow(height, 2) + pow(width, 2));

    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: pyth * 0.42,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://images.pexels.com/photos/14454202/pexels-photo-14454202.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                  fit: BoxFit.cover
                )
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      width: pyth * 0.35,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 14.0,
                            offset: const Offset(4, 4)
                          )
                        ]
                      ),
                      child: TextField(
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Search book...",
                          hintStyle: const TextStyle(
                            fontSize: 14.0,
                          ),
                          suffixIcon: const Icon(
                            Icons.search,
                            size: 19.0,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: Row(
                        children: const [
                          Text(
                            "Save \nyou'r favorite \n books.",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            FutureBuilder(
               future: DBAdmin().getBooks(),
               builder: (BuildContext context, AsyncSnapshot snap){
                if(snap.hasData){
                  List<BookModel> myBooks = snap.data;
                  return myBooks.isNotEmpty ? Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 8.0,
                        ),
                        const Text(
                          "Mis libros favoritos",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: myBooks
                                .map((mandarina) => ItemSliderWidget(
                                      book: mandarina,
                                    ))
                                .toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Text(
                          "Lista general",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ListView.builder(
                          itemCount: myBooks.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return ItemHomeWidget(
                              book: myBooks[index],
                              onDelete: () {
                                // showDeleteDialog(myBooks[index].id!);
                                return null;
                              },
                              onUpdate: () {
                                // booKTemp = myBooks[index];
                                // isRegister = false;
                                // showFormBook();
                                return null;
                                // print(myBooks[index].toJson());
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                      ],
                    ),
                  )
                  : Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50.0),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/box.png",
                            height: pyth * 0.1,
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          const Text(
                              "Por favor registra tu primer libro.")
                        ],
                      ),
                    ),
                  );
                }
                return CircularProgressIndicator();
               },
            )
          ],
        ),
      )
    );
  }
}