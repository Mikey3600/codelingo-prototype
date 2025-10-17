import 'package:flutter/material.dart';

class DSAPathScreen extends StatelessWidget {
  const DSAPathScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DSA Progress Path'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data Structures & Algorithms',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Master the fundamentals of computer science',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            
            // Progress overview card
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
                      'Your Progress',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: 0.15, // Mock progress value
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      minHeight: 8,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '3/20 topics completed',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // DSA Topics
            Text(
              'Topics',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            
            // Arrays topic
            _buildTopicCard(
              context,
              'Arrays',
              'Foundation',
              'Learn array operations and basic algorithms',
              Icons.grid_on,
              Colors.blue,
              true,
              0.8,
            ),
            
            // Linked Lists topic
            _buildTopicCard(
              context,
              'Linked Lists',
              'Foundation',
              'Understand singly and doubly linked lists',
              Icons.link,
              Colors.green,
              true,
              0.5,
            ),
            
            // Stacks & Queues topic
            _buildTopicCard(
              context,
              'Stacks & Queues',
              'Foundation',
              'Master LIFO and FIFO data structures',
              Icons.layers,
              Colors.orange,
              true,
              0.2,
            ),
            
            // Trees topic
            _buildTopicCard(
              context,
              'Trees',
              'Intermediate',
              'Binary trees, BST, and tree traversals',
              Icons.account_tree,
              Colors.purple,
              false,
              0.0,
            ),
            
            // Graphs topic
            _buildTopicCard(
              context,
              'Graphs',
              'Advanced',
              'Graph representations and algorithms',
              Icons.hub,
              Colors.red,
              false,
              0.0,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTopicCard(
    BuildContext context,
    String title,
    String level,
    String description,
    IconData icon,
    Color color,
    bool unlocked,
    double progress,
  ) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: unlocked ? () {
          // TODO: Navigate to topic details
        } : null,
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          level,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!unlocked)
                    const Icon(Icons.lock, color: Colors.grey),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (unlocked) ...[
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  borderRadius: BorderRadius.circular(10),
                  minHeight: 6,
                ),
                const SizedBox(height: 8),
                Text(
                  '${(progress * 100).toInt()}% complete',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}