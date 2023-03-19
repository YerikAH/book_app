import 'dart:math';
import 'package:app_book/model/model.dart';
import 'package:app_book/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ItemHomeWidget extends StatelessWidget {
  BookModel book;
  Function onDelete;
  Function onUpdate;

  ItemHomeWidget({super.key, 
    required this.book,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double pyth = sqrt(pow(height, 2) + pow(width, 2));

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24.0),
                child: Image.network(
                  book.image,
                  width: pyth * 0.10,
                  height: pyth * 0.14,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      book.author,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      book.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.black60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 12,
          right: 0,
          child: PopupMenuButton(
            onSelected: (int value) {
              if (value == 1) {
                onUpdate();
              } else {
                onDelete();
              }
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 16.0, color:AppTheme.black70,),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Update",
                        style: GoogleFonts.poppins(
                          fontSize: 14.0,
                          color: AppTheme.black70,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: [
                      Icon(Icons.delete_outline_rounded, size: 16.0, color: AppTheme.black70),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text("Delete",
                        style: GoogleFonts.poppins(
                          fontSize: 14.0,
                          color: AppTheme.black70,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ],
                  ),
                ),
              ];
            },
          ),
        ),
      ],
    );
  }
}