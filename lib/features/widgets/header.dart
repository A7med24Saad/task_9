import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task_9/cash.dart';
import 'package:task_9/core/styles.dart';
import 'package:task_9/features/profile.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: cash.get(cash.NameKey),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text('Hello,  ${snapshot.data!.split('   ').first}',
                    style: getHeadlineStyle());
              } else {
                return Text(
                  'user',
                  style: getHeadlineStyle(),
                );
              }
            },
            //
          ),
          Text(
            'Have A Nice Day.',
            style: getSmallTextStyle(),
          ),
        ],
      ),
      const Spacer(),
      FutureBuilder(
        future: cash.get(cash.Image),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const profile(),
                ));
              },
              child: Container(
                child: CircleAvatar(
                    radius: 25,
                    backgroundImage: FileImage(File(snapshot.data!))),
              ),
            );
          } else {
            return const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blue,
            );
          }
        },
      ),
    ]);
  }
}
