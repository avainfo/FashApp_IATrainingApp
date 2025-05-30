import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class LookSwiper extends StatefulWidget {
  const LookSwiper({
    super.key,
    required this.controller,
    this.undoMaxCount = 2,
    this.preloadLooksCount = 3,
  });

  final CardSwiperController controller;
  final int undoMaxCount;
  final int preloadLooksCount;

  @override
  State<LookSwiper> createState() => _LookSwiperState();
}

class _LookSwiperState extends State<LookSwiper> {
  Queue<Widget> looksQueue = Queue<Widget>();
  int looksIndex = 0;
  int undo = 0;

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
    reloadCards();
    super.initState();
  }

  void reloadCards() {
    for (Widget card in cards) {
      looksQueue.add(card);
    }

    // TODO : Move this func into firebase swipers actions
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
                if (looksIndex > 0) {
                  card = looksQueue.elementAt(index - looksIndex);
                } else {
                  card = looksQueue.elementAt(index);
                }
                return card;
              },
              cardsCount: 99999,
              controller: widget.controller,
              isLoop: false,
              onSwipe: (previousIndex, currentIndex, direction) {
                if (undo < 0) {
                  undo++;
                  return true;
                }
                looksIndex = currentIndex! - widget.undoMaxCount;
                if (looksIndex > 0) looksQueue.removeFirst();
                looksQueue.elementAt(currentIndex - looksIndex);
                if (currentIndex == 9) {
                  reloadCards();
                }
                return true;
              },
              onUndo: (prev, cur, dir) {
                if (undo == -widget.undoMaxCount || cur < 0) return false;
                undo--;
                return true;
              },
              numberOfCardsDisplayed: 1,
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
