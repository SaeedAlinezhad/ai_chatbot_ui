import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForegroundButtons extends StatelessWidget {
  const ForegroundButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
              color: const Color.fromARGB(57, 63, 57, 90),
              shape: const CircleBorder(),
              child: IconButton(
                icon: const Icon(Iconsax.sidebar_left_copy, color: Colors.white),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            Material(
              color: const Color.fromARGB(57, 63, 57, 90),
              shape: const CircleBorder(),
              child: IconButton(
                icon: const Icon(Iconsax.magicpen_copy, color: Colors.white),
                onPressed: () {
                  context.read<HomeBloc>().add(ClearMessagesEvent());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
