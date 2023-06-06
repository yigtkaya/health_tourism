import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/vertical_space.dart';

class HTTextField extends StatefulWidget {
  final TextEditingController textController;
  final String title;

  const HTTextField({
    Key? key,
    required this.textController,
    required this.title,
  }) : super(key: key);

  @override
  State<HTTextField> createState() => _HTTextFieldState();
}

class _HTTextFieldState extends State<HTTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const VerticalSpace(
          spaceAmount: 2,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: const Color(0xff3a5979),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          height: 60.0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: widget.title == "Email" ? false : true,
                autocorrect: false,
                enableSuggestions: false,
                decoration: InputDecoration(
                    prefixIcon: widget.title == "Email"
                        ? const Icon(
                            Icons.email,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.key,
                            color: Colors.white,
                          ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: "Type in your text",
                    fillColor: Colors.transparent.withOpacity(0.1)),
                controller: widget.textController),
          ),
        ),
      ],
    );
  }

  void changeObsecure(bool isSelected) {}
}
