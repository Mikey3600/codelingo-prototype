import 'package:flutter/material.dart';
import '../../widgets/common/loading_indicator.dart';

class LessonListScreen extends StatelessWidget {
  const LessonListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This is a placeholder - will be implemented with actual lesson data later
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lessons'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school,
              size: 80,
              color: Theme.of(context).primaryColor.withOpacity(0.7),
            ),
            const SizedBox(height: 24),
            Text(
              'Lessons Coming Soon',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text(
              'We\'re preparing amazing coding lessons for you!',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}