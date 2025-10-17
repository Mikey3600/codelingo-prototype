import 'package:flutter/material.dart';
import '../../widgets/progress/level_badge.dart';
import '../../widgets/progress/streak_widget.dart';
import 'package:go_router/go_router.dart';
// Ensure that user_model.dart defines a 'User' class.
// If not, define the User class below or update the import path.

// Temporary User class definition for error-free compilation
class MockUser {
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

  MockUser({
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

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock user data - in a real app, this would come from a provider or state management
    final MockUser mockUser = MockUser(
      id: '1',
      name: 'John Doe',
      email: 'john@example.com',
      photoUrl: null,
      level: 5,
      xp: 2500,
      streak: 7,
      dailyGoal: 50,
      dailyProgress: 30,
      completedLessons: ['python_basics_1', 'python_basics_2'],
      completedProjects: ['todo_app'],
      completedDSAProblems: ['array_1', 'array_2'],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(context, mockUser),
            const SizedBox(height: 16),
            _buildStatsSection(context, mockUser),
            const SizedBox(height: 24),
            _buildAchievementsSection(context),
            const SizedBox(height: 24),
            _buildActivitySection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, MockUser user) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: user.photoUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      user.photoUrl!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  )
                : Text(
                    user.name.substring(0, 1),
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
          ),
          const SizedBox(height: 16),
          Text(
            user.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LevelBadge(level: user.level),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.local_fire_department,
                      color: Colors.amber,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${user.streak} day streak',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context, MockUser user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Stats',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildStatCard(
                context,
                'XP',
                user.xp.toString(),
                Icons.star,
                Colors.amber,
              ),
              const SizedBox(width: 16),
              _buildStatCard(
                context,
                'Lessons',
                user.completedLessons.length.toString(),
                Icons.school,
                Colors.blue,
              ),
              const SizedBox(width: 16),
              _buildStatCard(
                context,
                'Projects',
                user.completedProjects.length.toString(),
                Icons.build,
                Colors.green,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(
                icon,
                color: color,
                size: 28,
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAchievementsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Achievements',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildAchievementCard(
                  context,
                  'First Steps',
                  'Complete your first lesson',
                  Icons.emoji_events,
                  Colors.amber,
                  true,
                ),
                _buildAchievementCard(
                  context,
                  'Consistent Learner',
                  'Maintain a 7-day streak',
                  Icons.calendar_today,
                  Colors.green,
                  true,
                ),
                _buildAchievementCard(
                  context,
                  'Project Builder',
                  'Complete your first project',
                  Icons.build,
                  Colors.blue,
                  true,
                ),
                _buildAchievementCard(
                  context,
                  'Algorithm Master',
                  'Solve 10 DSA problems',
                  Icons.code,
                  Colors.purple,
                  false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
    bool unlocked,
  ) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: unlocked ? color.withOpacity(0.2) : Colors.grey[300],
                child: Icon(
                  icon,
                  color: unlocked ? color : Colors.grey,
                  size: 30,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: unlocked ? null : Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: unlocked ? Colors.grey[600] : Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivitySection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Activity',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          _buildActivityItem(
            context,
            'Completed Python Basics - Variables',
            '2 days ago',
            Icons.check_circle,
            Colors.green,
          ),
          _buildActivityItem(
            context,
            'Earned "First Steps" achievement',
            '2 days ago',
            Icons.emoji_events,
            Colors.amber,
          ),
          _buildActivityItem(
            context,
            'Started Todo List project',
            '3 days ago',
            Icons.build,
            Colors.blue,
          ),
          _buildActivityItem(
            context,
            'Solved Array Reversal problem',
            '4 days ago',
            Icons.code,
            Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
    BuildContext context,
    String title,
    String time,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: color.withOpacity(0.2),
              child: Icon(
                icon,
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    time,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}