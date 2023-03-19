import 'package:app_book/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CommonTextFieldWidget extends StatelessWidget {
  String label;
  String hintText;
  IconData icon;
  int? maxLines;
  TextEditingController controller;

  CommonTextFieldWidget({
    super.key, 
    required this.hintText,
    required this.icon,
    required this.label,
    this.maxLines,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            " $label:",
            style: GoogleFonts.poppins(
              fontSize: 14.0,
              color: AppTheme.black100,
              fontWeight: FontWeight.w500
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppTheme.black10,
                  blurRadius: 12,
                  offset: const Offset(4, 4),
                ),
              ],
            ),
            child: Theme(
              data:Theme.of(context).copyWith(
                colorScheme: ThemeData().colorScheme.copyWith(
                primary:AppTheme.orange,
                ),
              ),
              child: TextFormField(
                controller: controller,
                maxLines: maxLines, 
                style: GoogleFonts.poppins(
                  color: AppTheme.black70,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400
                ),
                
                decoration: InputDecoration(
                  hintText: hintText,
                  filled: true,
                  fillColor: AppTheme.white,
                  prefixIcon: Icon(icon),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide.none
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide.none
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return "Obligatory field";
                  }
                  return null;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}