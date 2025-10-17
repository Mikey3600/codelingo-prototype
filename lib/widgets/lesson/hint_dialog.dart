import 'package:flutter/material.dart';
import '../common/custom_button.dart';

class HintDialog extends StatelessWidget {
  final String hint;
  final int xpCost;
  final Function() onAccept;
  final Function() onDecline;

  const HintDialog({
    Key? key,
    required this.hint,
    required this.xpCost,
    required this.onAccept,
    required this.onDecline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.lightbulb,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Get a Hint',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Would you like to use a hint? This will cost you $xpCost XP.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'No, thanks',
                    onPressed: onDecline,
                    type: ButtonType.outline,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    text: 'Use Hint',
                    onPressed: onAccept,
                    type: ButtonType.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}