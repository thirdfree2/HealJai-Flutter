import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ReplyCard extends StatelessWidget {
  const ReplyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width -45),
          child: 
          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        color: Colors.lightGreen,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 80, top: 10, bottom: 20),
              child: Text(
                "Hey",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Positioned(
              bottom: 4,
              right: 10,
              child: 
                  Text(
                    "20:58",
                    style: TextStyle(fontSize: 13, color: Colors.white),
                  ),
            )
          ],
        ),
      )),
    );
  }
}
