import 'package:flutter/material.dart';
import 'package:gms_and/widgets/user/commons.dart';
import 'package:gms_and/widgets/book_chart.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    //return Commons();

    return BookChart();
  }
}
