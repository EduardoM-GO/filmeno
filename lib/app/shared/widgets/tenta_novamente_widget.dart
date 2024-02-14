import 'package:flutter/material.dart';

class TentaNovamenteWidget extends StatelessWidget {
  final VoidCallback onTap;
  const TentaNovamenteWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) => Center(
        child: IconButton(onPressed: onTap, icon: const Icon(Icons.refresh)),
      );
}
