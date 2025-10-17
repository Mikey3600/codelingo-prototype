import 'package:flutter/material.dart';

class StreakWidget extends StatelessWidget {
  final int streakCount;
  final bool isActive;

  const StreakWidget({
    Key? key,
    required this.streakCount,
    this.isActive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFFFC800) : Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: const Color(0xFFFFC800).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                )
              ]
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.local_fire_department,
            color: isActive ? Colors.deepOrange : Colors.grey[600],
            size: 24,
          ),
          const SizedBox(width: 8),
          Text(
            '$streakCount',
            style: TextStyle(
              color: isActive ? Colors.deepOrange : Colors.grey[600],
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            'day${streakCount != 1 ? 's' : ''}',
            style: TextStyle(
              color: isActive ? Colors.deepOrange : Colors.grey[600],
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}