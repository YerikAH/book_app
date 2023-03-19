import 'package:app_book/database/db_admin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/model.dart';
import '../widgets/widgets.dart';

class FormBookUpdate extends StatefulWidget {
  BookModel book;
  FormBookUpdate({super.key, 
    required this.book,
  });

  @override
  State<FormBookUpdate> createState() => _FormBookUpdateState();
}

class _FormBookUpdateState extends State<FormBookUpdate> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _authorController = TextEditingController();

  final TextEditingController _imageController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final _myFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
      _titleController.text = widget.book.title;
      _authorController.text = widget.book.author;
      _imageController.text = widget.book.image;
      _descriptionController.text = widget.book.description;
  }

  void saveBook() {
    if (_myFormKey.currentState!.validate()) {
      BookModel myBook = BookModel(
        title: _titleController.text,
        author: _authorController.text,
        image: _imageController.text,
        description: _descriptionController.text,
      );
      myBook.id = widget.book.id;
        DBAdmin().updateBook(myBook).then((mandarina){
          if (mandarina >= 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: const Color(0xff06d6a0),
                duration: const Duration(seconds: 5),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                content: Row(
                  children: const [
                    Icon(Icons.check, color: Colors.white),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Text(
                        "The book update successfully",
                      ),
                    ),
                  ],
                ),
              ),
            );
            Navigator.pop(context);
          }
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("cargar widget");
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(36.0),
          topRight: Radius.circular(36.0),
        ),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _myFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Update book",
                  style: GoogleFonts.poppins(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5
                  ),
                ),
              ),
              CommonTextFieldWidget(
                hintText: "Enter the title",
                icon: Icons.rocket_launch_rounded,
                label: "Title",
                controller: _titleController,

              ),
              CommonTextFieldWidget(
                hintText: "Enter name the autor",
                icon: Icons.person_rounded,
                label: "Autor",
                controller: _authorController,
              ),
              CommonTextFieldWidget(
                hintText: "Enter front page url",
                icon: Icons.image_rounded,
                label: "Front page",
                controller: _imageController,
              ),
              CommonTextFieldWidget(
                hintText: "Enter description",
                icon: Icons.view_headline_rounded,
                label: "Description",
                maxLines: 1,
                controller: _descriptionController,
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    saveBook();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(179, 255, 80, 27),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                  child: Text(
                   "Update",
                    style: GoogleFonts.poppins(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}