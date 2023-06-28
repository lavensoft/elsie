import 'package:elsie/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageCard extends StatefulWidget {
  const ImageCard({ super.key, required this.title, required this.image, this.tags = const [], this.href="" });

  final String title;
  final List<String> tags;
  final String href;
  final String image;

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 0, 18, 24),
      clipBehavior: Clip.hardEdge, //Make border radius crop content
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, .12),
            blurRadius: 12,
            offset: Offset(0, 6)
          ),
        ],
      ),
      child: InkWell(
        onTap: () async {
          if(widget.href != "") {
            await launch(widget.href);
          }
        },
        child: Column(
          children: [
            Container( //*Image thumbnail
              color: Colors.black,
              // height: 300,
              child: Image.network(widget.image, fit: BoxFit.contain),
            ),
            Container( //*Information
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: Column(
                children: [
                  Text( //*Title
                    widget.title,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.4,
                      fontWeight: FontWeight.w500
                    ),
                  ),

                  if(widget.tags.isNotEmpty) Container( //*Tags Group
                    margin: const EdgeInsets.only(top: 9),
                    child: Row(
                      children: widget.tags.map((tag) {
                        return Container( //*Tag
                          margin: const EdgeInsets.only(right: 6),
                          child: BadgeCard(tag),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}