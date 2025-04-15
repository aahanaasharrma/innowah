
import 'package:flutter/cupertino.dart';

class BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg_home.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}