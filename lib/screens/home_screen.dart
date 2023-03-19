import 'dart:math';

import 'package:app_book/database/db_admin.dart';
import 'package:app_book/model/model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../modal/modal.dart';
import '../theme/app_theme.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget { 
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BookModel? booKTemp;
  bool isRegister = true;

  showFormBook() {
    print("function execute");
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        print("build widget");
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: FormBookModal(
            book: booKTemp,
            isRegister: isRegister,
          ),
        );
      },
    ).then((value) {
      setState(() {});
    });
  }

  showDeleteDialog(int idBook) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Text("Attention",
                style: GoogleFonts.poppins(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.black100
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text("Do you want to delete this book?",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.black70,
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: AppTheme.orange,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 6.0,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        DBAdmin().deleteBook(idBook).then((value) {
                          if (value >= 0) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "The book was deleted successfully",
                                ),
                              ),
                            );
                            setState(() {});
                            //SnackBar
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.orange,
                        foregroundColor: Colors.white,
                        textStyle: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                      ),
                      child: const Text(
                        "Accept",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double pyth = sqrt(pow(height, 2) + pow(width, 2));

    return  Scaffold(
      floatingActionButton: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          isRegister = true;
          showFormBook();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(179, 255, 80, 27),
            borderRadius: BorderRadius.circular(255.0),
          ),
          child: const Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: 30.0,
            
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: pyth * 0.42,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://images.pexels.com/photos/2460817/pexels-photo-2460817.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                  fit: BoxFit.cover
                )
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                        children: [
                          Text(
                            "Save \nyou'r favorite \n books.",
                            style: GoogleFonts.poppins(
                              fontSize: 32.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white
                            )
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
                        Text(
                          "My favorite books",
                          style: GoogleFonts.poppins(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5
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
                        Text(
                          "Overall list",
                          style: GoogleFonts.poppins(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5
                          ),
                        ),
                        ListView.builder(
                          itemCount: myBooks.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return ItemHomeWidget(
                              book: myBooks[index],
                              onDelete: () {
                                showDeleteDialog(myBooks[index].id!);
                              },
                              onUpdate: () {
                                booKTemp = myBooks[index];
                                isRegister = false;
                                showFormBook();
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
                      padding: const EdgeInsets.symmetric(vertical: 75.0, horizontal: 20.0),
                      child: Column(
                        
                        children: [
                          Container(
                            width: pyth * 0.1,
                            padding: const EdgeInsets.all(15.0),
                            height: pyth * 0.1,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(179, 255, 80, 27),
                              borderRadius: BorderRadius.circular(255.0)
                            ),
                            child: Center(
                              child: Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/box.png")
                                  )
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Please register your first book.",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 16.0,
                              color: const Color.fromARGB(179, 255, 80, 27),
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
                return const CircularProgressIndicator();
               },
            )
          ],
        ),
      )
    );
  }
}