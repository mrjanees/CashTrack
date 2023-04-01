import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

void emptyFieldHandler(BuildContext context, String title) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: Container(
          width: 250,
          height: 112,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 248, 255, 251),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.error_rounded,
                      size: 40,
                      color: Color.fromARGB(197, 244, 67, 54),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Empty data',
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: const TextStyle(color: Colors.black87, fontSize: 20),
                )
              ],
            ),
          ),
        ));
      });
}
