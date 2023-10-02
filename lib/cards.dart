import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardTile extends StatelessWidget {
  final String title;
  final String content;
  final DateTime dateAndTime ;
  final Color color;
  final void Function() delFunction;
  final void Function() onTap;
  const CardTile({super.key, required this.title, required this.content, required this.dateAndTime, required this.color, required this.delFunction, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 80,
            color: color,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 3, bottom: 6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:[
                      Text(
                        textAlign: TextAlign.left,
                        "$title:", style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                      const SizedBox(height: 4),
                      Text(
                        content, maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      const SizedBox(height: 4),
                        RichText(
                          text: TextSpan(
                            text: "Edited: ${DateFormat("EEE MMM d, yyyy h:mm:a").format(dateAndTime)}",
                            style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 10),
                          )
                          ),
                    ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    onPressed: delFunction,
                    icon: const Icon(Icons.delete)
                  ),
                )
              ]
            )
          ),
        ),
      ),
    );
  }
}