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