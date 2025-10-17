import 'package:flutter/material.dart';
import '../../widgets/progress/streak_widget.dart';
import '../../widgets/progress/xp_bar.dart';
import '../../widgets/progress/level_badge.dart';
import '../../models/user_model.dart';

// Ensure that user_model.dart exports a 'User' class.
class User {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final int level;
  final int xp;
  final int streak;
  final int dailyGoal;
  final int dailyProgress;
  final List<String> completedLessons;
  final List<String> completedProjects;
  final List<String> completedDSAProblems;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.level,
    required this.xp,
    required this.streak,
    required this.dailyGoal,
    required this.dailyProgress,
    required this.completedLessons,
    required this.completedProjects,
    required this.completedDSAProblems,
  });
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock user data - in a real app, this would come from a provider or state management
    final User mockUser = User(
      id: '1',
      name: 'John Doe',
      email: 'john@example.com',
      photoUrl: null,
      level: 5,
      xp: 2500,
      streak: 7,
      dailyGoal: 50,
      dailyProgress: 30,
      completedLessons: [],
      completedProjects: [],
      completedDSAProblems: [],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('CodeLingo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // TODO: Implement notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User greeting and level
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, ${mockUser.name}!',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Keep coding to reach your goals!',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  LevelBadge(level: mockUser.level),
                ],
              ),

              const SizedBox(height: 24),

              // XP Progress
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'XP Progress',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      XPBar(
                        currentXP: mockUser.xp,
                        requiredXP: 3000, // Mock required XP for next level
                        level: mockUser.level,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${mockUser.xp}/3000 XP to Level ${mockUser.level + 1}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Daily Goal and Streak
              Row(
                children: [
                  Expanded(
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Daily Goal',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 12),
                            LinearProgressIndicator(
                              value:
                                  mockUser.dailyProgress / mockUser.dailyGoal,
                              backgroundColor: Colors.grey[300],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              minHeight: 10,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${mockUser.dailyProgress}/${mockUser.dailyGoal} XP today',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Current Streak',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 12),
                            Center(
                              child: SizedBox(
                                width: 60,
                                height: 60,
                                child: StreakWidget(
                                  streakCount: mockUser.streak,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Center(
                              child: Text(
                                '${mockUser.streak} days',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Continue Learning
              Text(
                'Continue Learning',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              _buildContinueLearningCard(
                context,
                'Python Basics',
                'Variables and Data Types',
                'Lesson 3 of 10',
                0.3,
                Icons.code,
                Colors.blue,
              ),

              const SizedBox(height: 16),

              // Recommended for You
              Text(
                'Recommended for You',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              _buildRecommendationCard(
                context,
                'JavaScript',
                'Learn Async/Await',
                'Advanced • 45 min',
                Icons.javascript,
                Colors.yellow[700]!,
              ),
              const SizedBox(height: 12),
              _buildRecommendationCard(
                context,
                'Data Structures',
                'Binary Search Trees',
                'Intermediate • 30 min',
                Icons.account_tree,
                Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContinueLearningCard(
    BuildContext context,
    String language,
    String title,
    String progress,
    double progressValue,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to lesson
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: color.withOpacity(0.2),
                    child: Icon(icon, color: color),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    language,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(progress, style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: progressValue,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(color),
                borderRadius: BorderRadius.circular(10),
                minHeight: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendationCard(
    BuildContext context,
    String language,
    String title,
    String details,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to recommended lesson
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.2),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      language,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 4),
                    Text(title, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(details, style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}
