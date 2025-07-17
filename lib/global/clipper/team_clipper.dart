//
import 'package:flutter/material.dart';

class TeamTitleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.1216250, size.height * 0.9954000);
    path_0.lineTo(size.width * 0.8755000, size.height * 0.9936000);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(0, 0);
    path_0.lineTo(size.width * 0.1216250, size.height * 0.9954000);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class TeamOverViewTileClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();

    path_0.moveTo(size.width * 0.5000000, size.height);
    path_0.lineTo(size.width * 0.9966667, size.height * 0.3750000);
    path_0.lineTo(size.width * 0.5000000, 0);
    path_0.lineTo(0, size.height * 0.3725000);
    path_0.lineTo(size.width * 0.5000000, size.height);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class TeamOverViewLeagueTile extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();

    path_0.moveTo(size.width * 0.3000000, size.height * 1.0050000);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(size.width * 1.0050000, 0);
    path_0.lineTo(size.width * 0.3000000, 0);
    path_0.lineTo(0, size.height * 0.4950000);
    path_0.lineTo(size.width * 0.3000000, size.height * 1.0050000);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class TeamPlayerTileClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();

    path_0.moveTo(0, size.height);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(size.width * 1.0012000, size.height * 0.3521000);
    path_0.lineTo(size.width * 0.5000000, 0);
    path_0.lineTo(0, size.height * 0.3500000);
    path_0.lineTo(0, size.height);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
