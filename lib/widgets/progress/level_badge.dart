import 'package:flutter/material.dart';

class LevelBadge extends StatelessWidget {
  final int level;
  final double size;

  const LevelBadge({
    Key? key,
    required this.level,
    this.size = 60.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Determine badge color based on level
    Color badgeColor;
    if (level < 5) {
      badgeColor = Colors.brown;
    } else if (level < 10) {
      badgeColor = Colors.grey;
    } else if (level < 15) {
      badgeColor = Colors.amber;
    } else if (level < 20) {
      badgeColor = Colors.lightBlueAccent;
    } else {
      badgeColor = Colors.purple;
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            badgeColor,
            badgeColor.withOpacity(0.7),
          ],
          center: Alignment.topLeft,
          focal: Alignment.center,
          radius: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: badgeColor.withOpacity(0.4),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          '$level',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: size * 0.4,
            shadows: [
              Shadow(
                blurRadius: 2.0,
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(1, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}