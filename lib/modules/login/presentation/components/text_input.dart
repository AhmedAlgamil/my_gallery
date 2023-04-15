import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
   CustomTextField({
    Key? key,
    this.hint,
    this.isSecured = false,
    required this.textController,
  }) : super(key: key);
  final String? hint;
  final bool isSecured;
  TextEditingController? textController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: const Color(0xffF7F7F7),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            controller: textController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: hint,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: const BorderSide(
                  color: Color(0xffF7F7F7),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: const BorderSide(
                  color: Color(0xffF7F7F7),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: const BorderSide(
                  color: Color(0xffF7F7F7),
                ),
              ),
              hintStyle: const TextStyle(
                color: Color(0xff988F8C),
              ),
            ),
            obscureText: isSecured,
          ),
        ),
      ),
    );
  }
}
