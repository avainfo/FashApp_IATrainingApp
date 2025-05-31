import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:ia_training_app/data/looks/looks_model.dart';
import 'package:ia_training_app/data/looks/looks_repository.dart';
import 'package:ia_training_app/swiper/looks_card.dart';
import 'package:ia_training_app/swiper/swiper_actions.dart';

class LookSwiper extends StatefulWidget {
  final List<Look> looks;
  final LookGender gender;
  final Future<void> Function() onLoadMore;

  const LookSwiper({
    super.key,
    required this.looks,
    required this.gender,
    required this.onLoadMore,
  });

  @override
  State<LookSwiper> createState() => _LookSwiperState();
}

class _LookSwiperState extends State<LookSwiper> {
  final CardSwiperController _controller = CardSwiperController();
  final LooksRepository _repo = LooksRepository();
  Queue<Look> lookQueue = Queue<Look>();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    lookQueue.addAll(widget.looks);
  }

  void _handleSwipe(CardSwiperDirection direction) async {
    if (currentIndex >= lookQueue.length) return;

    final currentLook = lookQueue.elementAt(currentIndex);

    switch (direction) {
      case CardSwiperDirection.right:
        await _repo.likeLook(currentLook.id);
        break;
      case CardSwiperDirection.left:
        await _repo.dislikeLook(currentLook.id);
        break;
      default:
        break;
    }

    setState(() => currentIndex++);

    if (currentIndex >= lookQueue.length - 2) {
      await widget.onLoadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: CardSwiper(
              controller: _controller,
              cardsCount: lookQueue.length,
              numberOfCardsDisplayed: 2,
              isLoop: false,
              onSwipe: (previousIndex, currentIndex, direction) {
                _handleSwipe(direction);
                return true;
              },
              cardBuilder: (context, index, _, _) {
                if (index >= lookQueue.length) return const SizedBox();
                final look = lookQueue.elementAt(index);
                return LooksCard(
                  look: look,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        SwiperActions(
          controller: _controller,
          onError: () async {
            if (currentIndex >= lookQueue.length) return;
            final currentLook = lookQueue.elementAt(currentIndex);
            await _repo.reportLookError(currentLook.id, widget.gender);
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
