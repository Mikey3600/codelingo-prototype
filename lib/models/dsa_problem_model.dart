class DSAProblem {
  final String id;
  final String title;
  final String description;
  final String difficulty; // 'easy', 'medium', 'hard'
  final List<String> tags; // e.g., 'arrays', 'strings', 'trees'
  final Map<String, String> codeTemplates; // language -> template
  final List<TestCase> testCases;
  final int xpReward;
  final String source; // 'leetcode', 'codeforces', 'custom'
  final String? sourceId; // ID from the original platform
  
  DSAProblem({
    required this.id,
    required this.title,
    required this.description,
    required this.difficulty,
    required this.tags,
    required this.codeTemplates,
    required this.testCases,
    required this.xpReward,
    required this.source,
    this.sourceId,
  });
  
  factory DSAProblem.fromJson(Map<String, dynamic> json) {
    return DSAProblem(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      difficulty: json['difficulty'],
      tags: List<String>.from(json['tags']),
      codeTemplates: Map<String, String>.from(json['codeTemplates']),
      testCases: (json['testCases'] as List)
          .map((testCase) => TestCase.fromJson(testCase))
          .toList(),
      xpReward: json['xpReward'],
      source: json['source'],
      sourceId: json['sourceId'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'difficulty': difficulty,
      'tags': tags,
      'codeTemplates': codeTemplates,
      'testCases': testCases.map((testCase) => testCase.toJson()).toList(),
      'xpReward': xpReward,
      'source': source,
      'sourceId': sourceId,
    };
  }
}

class TestCase {
  final String input;
  final String expectedOutput;
  final bool isHidden; // Whether to show this test case to the user
  
  TestCase({
    required this.input,
    required this.expectedOutput,
    required this.isHidden,
  });
  
  factory TestCase.fromJson(Map<String, dynamic> json) {
    return TestCase(
      input: json['input'],
      expectedOutput: json['expectedOutput'],
      isHidden: json['isHidden'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'input': input,
      'expectedOutput': expectedOutput,
      'isHidden': isHidden,
    };
  }
}