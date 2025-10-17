import 'package:flutter/material.dart';

class ProjectListScreen extends StatelessWidget {
  const ProjectListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Build Real Projects',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Apply your skills by building complete applications',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            
            // Project categories
            _buildCategorySelector(context),
            
            const SizedBox(height: 24),
            
            // Beginner projects
            Text(
              'Beginner Projects',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            
            _buildProjectCard(
              context,
              'Todo List App',
              'Python',
              'Build a simple command-line todo list application',
              ['Python', 'File I/O', 'Data Structures'],
              Colors.blue,
              Icons.check_box,
              '1-2 hours',
            ),
            
            _buildProjectCard(
              context,
              'Weather Dashboard',
              'JavaScript',
              'Create a web app that displays weather information',
              ['HTML', 'CSS', 'JavaScript', 'API'],
              Colors.orange,
              Icons.wb_sunny,
              '2-3 hours',
            ),
            
            const SizedBox(height: 24),
            
            // Intermediate projects
            Text(
              'Intermediate Projects',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            
            _buildProjectCard(
              context,
              'Blog Platform',
              'Node.js',
              'Build a full-stack blog with user authentication',
              ['Node.js', 'Express', 'MongoDB', 'Authentication'],
              Colors.green,
              Icons.article,
              '8-10 hours',
              locked: true,
            ),
            
            _buildProjectCard(
              context,
              'E-commerce Store',
              'React',
              'Create an online store with product listings and cart',
              ['React', 'State Management', 'API Integration'],
              Colors.purple,
              Icons.shopping_cart,
              '10-12 hours',
              locked: true,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCategorySelector(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildCategoryChip(context, 'All', true),
          _buildCategoryChip(context, 'Web', false),
          _buildCategoryChip(context, 'Mobile', false),
          _buildCategoryChip(context, 'Desktop', false),
          _buildCategoryChip(context, 'Backend', false),
          _buildCategoryChip(context, 'Data Science', false),
        ],
      ),
    );
  }
  
  Widget _buildCategoryChip(BuildContext context, String label, bool selected) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (bool selected) {
          // TODO: Implement filtering
        },
        backgroundColor: Colors.grey[200],
        selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
        checkmarkColor: Theme.of(context).primaryColor,
        labelStyle: TextStyle(
          color: selected ? Theme.of(context).primaryColor : Colors.black87,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
  
  Widget _buildProjectCard(
    BuildContext context,
    String title,
    String language,
    String description,
    List<String> tags,
    Color color,
    IconData icon,
    String duration,
    {bool locked = false}
  ) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: locked ? null : () {
          // TODO: Navigate to project details
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          language,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (locked)
                    const Icon(Icons.lock, color: Colors.grey),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: tags.map((tag) => Chip(
                  label: Text(
                    tag,
                    style: const TextStyle(fontSize: 12),
                  ),
                  backgroundColor: Colors.grey[200],
                  padding: EdgeInsets.zero,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                )).toList(),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    duration,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}