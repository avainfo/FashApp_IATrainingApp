import 'package:flutter/material.dart';
import 'package:ia_training_app/data/looks/looks_model.dart';

class LooksCard extends StatelessWidget {
  final Look look;

  const LooksCard({
    super.key,
    required this.look,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    var height = MediaQuery.of(context).size.height;
    var top = ((height / 40) + (height / 20) + (height / 40) + 40);
    var bottom = top + (height / 40) + 20 + (height / 10) + 50;

    final cardHeight = (height - (topPadding + bottomPadding)) - (top + bottom);
    final imageHeight = (cardHeight) / 3;

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Image.network(look.images.topUrl, height: imageHeight),
              const SizedBox(height: 10),
              Image.network(look.images.bottomUrl, height: imageHeight),
              const SizedBox(height: 10),
              Image.network(look.images.shoeUrl, height: imageHeight),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
