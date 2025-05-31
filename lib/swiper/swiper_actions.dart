import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class SwiperActions extends StatefulWidget {
  final CardSwiperController controller;

  final Function onError;

  const SwiperActions({super.key, required this.controller, required this.onError});

  @override
  State<SwiperActions> createState() => _SwiperActionsState();
}

class _SwiperActionsState extends State<SwiperActions> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FloatingActionButton(
            shape: CircleBorder(),
            onPressed: widget.controller.undo,
            child: const Icon(Icons.rotate_left),
          ),
          FloatingActionButton(
            shape: CircleBorder(),
            onPressed: () => widget.controller.swipe(CardSwiperDirection.left),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                gradient: RadialGradient(
                  colors: [Color(0xFFFC5B43), Color(0xFFFC305C)],
                  center: AlignmentGeometry.xy(-1, 1),
                  radius: 1,
                ),
              ),
              child: Center(child: const Icon(Icons.close_rounded, color: Colors.white)),
            ),
          ),
          FloatingActionButton(
            shape: CircleBorder(),
            onPressed: () => widget.controller.swipe(CardSwiperDirection.right),
            child: const Icon(Icons.check_rounded),
          ),
          FloatingActionButton(
            shape: CircleBorder(),
            onPressed: () {
              widget.onError();
            },
            child: const Icon(Icons.warning_amber),
          ),
        ],
      ),
    );
  }
}
