class Lesson {
  final String id;
  final String title;
  final String description;
  final String languageId;
  final String level; // 'beginner', 'intermediate', 'advanced'
  final int xpReward;
  final List<Challenge> challenges;
  final int order; // Position in the learning path
  final List<String> prerequisites; // IDs of prerequisite lessons
  
  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.languageId,
    required this.level,
    required this.xpReward,
    required this.challenges,
    required this.order,
    required this.prerequisites,
  });
  
  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      languageId: json['languageId'],
      level: json['level'],
      xpReward: json['xpReward'],
      challenges: (json['challenges'] as List)
          .map((challenge) => Challenge.fromJson(challenge))
          .toList(),
      order: json['order'],
      prerequisites: List<String>.from(json['prerequisites']),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'languageId': languageId,
      'level': level,
      'xpReward': xpReward,
      'challenges': challenges.map((challenge) => challenge.toJson()).toList(),
      'order': order,
      'prerequisites': prerequisites,
    };
  }
}

class Challenge {
  final String id;
  final String type; // 'multiple_choice', 'fill_in_blank', 'code_completion', etc.
  final String instruction;
  final String? codeTemplate;
  final List<String>? options; // For multiple choice
  final String? correctAnswer;
  final List<String>? hints;
  final int xpReward;
  
  Challenge({
    required this.id,
    required this.type,
    required this.instruction,
    this.codeTemplate,
    this.options,
    this.correctAnswer,
    this.hints,
    required this.xpReward,
  });
  
  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
      id: json['id'],
      type: json['type'],
      instruction: json['instruction'],
      codeTemplate: json['codeTemplate'],
      options: json['options'] != null ? List<String>.from(json['options']) : null,
      correctAnswer: json['correctAnswer'],
      hints: json['hints'] != null ? List<String>.from(json['hints']) : null,
      xpReward: json['xpReward'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'instruction': instruction,
      'codeTemplate': codeTemplate,
      'options': options,
      'correctAnswer': correctAnswer,
      'hints': hints,
      'xpReward': xpReward,
    };
  }
}