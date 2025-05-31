import 'package:flutter/material.dart';
import 'package:ia_training_app/data/looks/looks_model.dart';
import 'package:ia_training_app/data/looks/looks_repository.dart';
import 'package:ia_training_app/shared/custom_title.dart';
import 'package:ia_training_app/shared/look_swiper.dart';

class HomePage extends StatefulWidget {
  final LookGender gender;

  const HomePage({super.key, required this.gender});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LooksRepository _repo = LooksRepository();
  List<Look> _looks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInitialLooks();
  }

  Future<void> _loadInitialLooks() async {
    final looks = await _repo.fetchNextLooks(gender: widget.gender);
    setState(() {
      _looks = looks;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: height / 40,
            ),
            CustomTitle(title: "Looks Générés"),
            SizedBox(
              height: height / 40,
            ),
            Flexible(
              child: LookSwiper(
                looks: _looks,
                gender: widget.gender,
                onLoadMore: () async {
                  final newLooks = await _repo.fetchNextLooks(gender: widget.gender);
                  setState(() => _looks.addAll(newLooks));
                },
              ),
            ),
            Container(
              height: height / 40,
            ),
          ],
        ),
      ),
    );
  }
}
