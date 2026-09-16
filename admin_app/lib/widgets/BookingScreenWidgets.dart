import 'package:flutter/material.dart';

class BookingScreenWidgets extends StatelessWidget {
  final double wid;
  final String path;
  final String tex;
  final VoidCallback onTap;

  const BookingScreenWidgets({
    super.key,
    required this.wid,
    required this.path,
    required this.tex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return
    // Material(
    //   child:
    Container(
      width: wid,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(18, 0, 0, 0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Center(
            child: InkWell(
              onTap: onTap,
              child: Image.asset(
                path,
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            tex,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        ],
      ),
    );
    // );
  }
}
