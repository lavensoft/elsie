import "package:flutter/material.dart";

class Button extends StatefulWidget {
  const Button({ super.key, required this.onPressed, required this.text });

  final Function onPressed;
  final String text;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColorLight)
      ),
      onPressed: () => widget.onPressed(), 
      child: Text(
        widget.text,
        style: TextStyle(
          color: Theme.of(context).primaryColor
        ),
      )
    );
  }
}