import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/fonts.dart';

class UserViewLayout extends StatefulWidget {
  const UserViewLayout({super.key});

  @override
  State<UserViewLayout> createState() => _UserViewLayoutState();
}

class _UserViewLayoutState extends State<UserViewLayout> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Align(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'PAIZ MATARRITA JOSEPH', // deberia ser el name profile
                  style: Fonts.userViewTitleTextStyle,
                ),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(20),
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Si desea cerrar su sesión',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        )
      ],
    );
  }
}
