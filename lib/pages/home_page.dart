import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:ia_training_app/shared/title.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CardSwiperController controller = CardSwiperController();

  List<Container> cards = [
    Container(
      alignment: Alignment.center,
      child: const Text('1'),
      color: Colors.blue,
    ),
    Container(
      alignment: Alignment.center,
      child: const Text('2'),
      color: Colors.red,
    ),
    Container(
      alignment: Alignment.center,
      child: const Text('3'),
      color: Colors.purple,
    ),
    Container(
      alignment: Alignment.center,
      child: const Text('4'),
      color: Colors.yellow,
    ),
    Container(
      alignment: Alignment.center,
      child: const Text('5'),
      color: Colors.green,
    ),
  ];

  List<Widget> showCards() {
    List<Widget> cards = [];
    for (int i = 0; i < 3; i++) {
      cards.add(cards[i]);
    }
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            CustomTitle(title: "Looks Générés"),
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            ),
            Flexible(
              child: CardSwiper(
                cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                  Widget card = cards[index];
                  return card;
                },
                cardsCount: cards.length,
                controller: controller,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  shape: CircleBorder(),
                  onPressed: controller.undo,
                  child: const Icon(Icons.rotate_left),
                ),
                FloatingActionButton(
                  shape: CircleBorder(),
                  onPressed: () => controller.swipe(CardSwiperDirection.left),
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
                  onPressed: () => controller.swipe(CardSwiperDirection.right),
                  child: const Icon(Icons.check_rounded),
                ),
                FloatingActionButton(
                  shape: CircleBorder(),
                  onPressed: () {
                    // TODO : Change the action of the error button
                    log("Error of the post");
                  },
                  child: const Icon(Icons.warning_amber),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            ),
          ],
        ),
      ),
    );
  }
}
