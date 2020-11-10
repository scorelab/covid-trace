import 'package:flutter/material.dart';

class LabelTextFormField extends StatefulWidget {
  final String labelText;
  final bool isObscure;
  final controller;
  final TextInputType keyboardType;
  

  LabelTextFormField(
      {this.isObscure = false,
      this.controller,
      this.keyboardType = TextInputType.text,
      this.labelText});

  @override
  _LabelTextFormFieldState createState() => _LabelTextFormFieldState();
}

class _LabelTextFormFieldState extends State<LabelTextFormField> {

  bool pass=true;
  @override
  Widget build(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 8.0),
      child: TextFormField(
        obscureText: widget.labelText=="Password"?pass: widget.isObscure,
        controller: widget.controller,
        validator: widget.labelText=="Password"?_passwordValidator: (String value) {
          if (value.isEmpty) {
            return widget.labelText + " is required";
          }
          return null;
        },
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
            labelText: widget.labelText,
            suffixIcon: widget.labelText=="Password"? IconButton(
              icon: Icon(
                // Based on passwordVisible state choose the icon
                pass ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                // Update the state i.e. toogle the state of passwordVisible variable
                setState(() {
                  pass = !pass;
                });
              },
            ):null,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.4),
              borderRadius: BorderRadius.circular(10.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            )),
      ),
    );
  }

    String _passwordValidator(String password) {
    if (password.isEmpty) {
      return 'Please enter the passowrd';
    }

    if (password.length < 6) {
      return "Password must be at least 6 characters";
    }

    return null;
  }
}
