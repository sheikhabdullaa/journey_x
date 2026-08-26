import 'package:flutter/material.dart';

class TuristViewHistory extends StatefulWidget {
  const TuristViewHistory({super.key});

  @override
  State<TuristViewHistory> createState() => _TuristViewHistoryState();
}

class _TuristViewHistoryState extends State<TuristViewHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Turist View History Screen'),
      ),
    );
  }
}