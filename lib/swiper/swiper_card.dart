import 'package:flutter/material.dart';

class SwiperCard extends StatefulWidget {
  final int index;

  const SwiperCard({super.key, required this.index});

  @override
  State<SwiperCard> createState() => _SwiperCardState();
}

class _SwiperCardState extends State<SwiperCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: widget.index % 2 == 0 ? Colors.red : Colors.blue,
      child: Text(widget.index.toString()),
    );
  }
}
