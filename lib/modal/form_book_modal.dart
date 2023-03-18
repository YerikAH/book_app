import 'package:app_book/database/db_admin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/model.dart';
import '../widgets/widgets.dart';

class FormBookModal extends StatefulWidget {
  BookModel? book;
  bool isRegister;
  FormBookModal({
    this.book,
    required this.isRegister,
  });

  @override
  State<FormBookModal> createState() => _FormBookModalState();
}

class _FormBookModalState extends State<FormBookModal> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _authorController = TextEditingController();

  final TextEditingController _imageController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final _myFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!widget.isRegister) {
      _titleController.text = widget.book!.title;
      _authorController.text = widget.book!.author;
      _imageController.text = widget.book!.image;
      _descriptionController.text = widget.book!.description;
    }
  }

  void saveBook() {
    if (_myFormKey.currentState!.validate()) {
      //Registrar un libro
      // String title = _titleController.text;
      // String author = _authorController.text;
      // String image = _imageController.text;
      // String description = _descriptionController.text;
      // DBAdmin().insertBook(title, author, description, image);

      // Map<String, dynamic> bookMap = {
      //   "image": _imageController.text,
      //   "title": _titleController.text,
      //   "description": _descriptionController.text,
      //   "author": _authorController.text,
      // };

      // DBAdmin().insertBook(bookMap);

      BookModel myBook = BookModel(
        title: _titleController.text,
        author: _authorController.text,
        image: _imageController.text,
        description: _descriptionController.text,
      );

      if (widget.isRegister) {
        DBAdmin().insertBook(myBook).then((mandarina) {
          if (mandarina >= 0) {
            //Se agregó el libro correctamente
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: const Color(0xff06d6a0),
                duration: const Duration(seconds: 5),
                behavior: SnackBarBehavior.floating,
                // padding: EdgeInsets.all(12.0),
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
                        "El libro se registró correctamente.",
                      ),
                    ),
                  ],
                ),
              ),
            );
            Navigator.pop(context);
          } else {}
        }).catchError((error) {
          print(error);
        });
      } else {
        myBook.id = widget.book!.id;
        DBAdmin().updateBook(myBook).then((mandarina) {
          if (mandarina >= 0) {
            //Se agregó el libro correctamente
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: const Color(0xff06d6a0),
                duration: const Duration(seconds: 5),
                behavior: SnackBarBehavior.floating,
                // padding: EdgeInsets.all(12.0),
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
                        "El libro se actualizó correctamente.",
                      ),
                    ),
                  ],
                ),
              ),
            );
            Navigator.pop(context);
          } else {}
        }).catchError((error) {
          print(error);
        });
        //Actualizar un libro...

      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  widget.isRegister ? "Add book" : "Update book",
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
                    widget.isRegister ? "Add" : "Update",
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