import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class LookSwiperTest extends StatefulWidget {
  const LookSwiperTest({
    super.key,
    required this.controller,
    this.undoMaxCount = 2,
    this.preloadLooksCount = 3,
  });

  final CardSwiperController controller;
  final int undoMaxCount;
  final int preloadLooksCount;

  @override
  State<LookSwiperTest> createState() => _LookSwiperTestState();
}

class _LookSwiperTestState extends State<LookSwiperTest> {
  Queue<Widget> looksQueue = Queue<Widget>();
  int looksIndex = 0;

  List<Container> cards = [];

  @override
  void initState() {
    for (int i = 0; i < 10; i++) {
      cards.add(
        Container(
          alignment: Alignment.center,
          color: i % 2 == 0 ? Colors.red : Colors.blue,
          child: Text(i.toString()),
        ),
      );
    }
    for (Widget card in cards) {
      looksQueue.add(card);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Flexible(
            child: CardSwiper(
              cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                Widget card;
                Queue<Widget> tempQueue = Queue<Widget>.from(looksQueue);
                if (looksIndex > 0) {
                  log("Tempqueue length : ${tempQueue.length} and card selected is ${index - looksIndex}");
                  card = tempQueue.elementAt(index - looksIndex);
                  tempQueue.removeFirst();
                } else {
                  card = looksQueue.elementAt(index);
                }
                return card;
              },
              cardsCount: 5,
              controller: widget.controller,
              onSwipe: (previousIndex, currentIndex, direction) {
                looksIndex = currentIndex! - widget.undoMaxCount;
                log("=" * 20);
                log("Previous Index : $previousIndex");
                log("Current Index : $currentIndex");
                log("Direction : $direction");
                log("Looks Index : $looksIndex");
                log("Index : $currentIndex");
                if (looksIndex > 0) {
                  log("Index - Looks Index : ${currentIndex! - looksIndex}");
                  looksQueue.removeFirst();
                }
                log("Looks Queue Length : ${looksQueue.length}");
                log("=" * 20);
                looksQueue.elementAt(currentIndex - looksIndex);
                return true;
              },
              numberOfCardsDisplayed: 2,
              // TODO
              // TODO
              // TODO Il faut changer ce builder pour pouvoir afficher x+1
              // TODO
              // TODO
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
                  // TODO : Change the action of the error button
                  log("Error of the post");
                },
                child: const Icon(Icons.warning_amber),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
