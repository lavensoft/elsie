import 'package:flutter/material.dart';

class BadgeCard extends StatefulWidget {
  const BadgeCard(this.text, { 
    super.key, 
    this.backgroundColor = const Color.fromRGBO(0, 165, 156, .05),
    this.color = const Color.fromRGBO(0, 165, 156, 1)
  });

  final String text;
  final Color backgroundColor;
  final Color color;

  @override
  State<BadgeCard> createState() => _BadgeCardState();
}

class _BadgeCardState extends State<BadgeCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 6, 15, 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(9)),
        color: widget.backgroundColor,
      ),
      child: Text(
        widget.text, 
        style: TextStyle (
          color: widget.color,
          fontSize: 13,
          fontWeight: FontWeight.w500
        )
      )
    );
  }
}