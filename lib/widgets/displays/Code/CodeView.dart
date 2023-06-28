import "package:flutter/material.dart";

class CodeView extends StatelessWidget {
  const CodeView({ super. key, required this.code, });

  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.fromLTRB(18, 0, 18, 0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.03),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      width: double.infinity,
      child: Text(
        code,
        textAlign: TextAlign.left,
      )
    );
  }
}