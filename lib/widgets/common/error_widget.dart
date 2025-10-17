import 'package:flutter/material.dart';
import 'custom_button.dart';

class ErrorDisplayWidget extends StatelessWidget {
  final String message;
  final String? actionLabel;
  final VoidCallback? onActionPressed;
  final IconData icon;

  const ErrorDisplayWidget({
    Key? key,
    required this.message,
    this.actionLabel,
    this.onActionPressed,
    this.icon = Icons.error_outline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onActionPressed != null) ...[
              const SizedBox(height: 24),
              CustomButton(
                text: actionLabel!,
                onPressed: onActionPressed!,
                type: ButtonType.primary,
                isFullWidth: false,
              ),
            ],
          ],
        ),
      ),
    );
  }
}