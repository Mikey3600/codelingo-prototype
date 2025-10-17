class Progress {
  final String id;
  final String userId;
  final String languageId;
  final List<LessonProgress> completedLessons;
  final List<String> completedProjects;
  final List<DSAProblemProgress> solvedProblems;
  final DateTime lastUpdated;
  
  Progress({
    required this.id,
    required this.userId,
    required this.languageId,
    required this.completedLessons,
    required this.completedProjects,
    required this.solvedProblems,
    required this.lastUpdated,
  });
  
  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      id: json['id'],
      userId: json['userId'],
      languageId: json['languageId'],
      completedLessons: (json['completedLessons'] as List)
          .map((lesson) => LessonProgress.fromJson(lesson))
          .toList(),
      completedProjects: List<String>.from(json['completedProjects']),
      solvedProblems: (json['solvedProblems'] as List)
          .map((problem) => DSAProblemProgress.fromJson(problem))
          .toList(),
      lastUpdated: DateTime.parse(json['lastUpdated']),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'languageId': languageId,
      'completedLessons': completedLessons.map((lesson) => lesson.toJson()).toList(),
      'completedProjects': completedProjects,
      'solvedProblems': solvedProblems.map((problem) => problem.toJson()).toList(),
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}

class LessonProgress {
  final String lessonId;
  final DateTime completedAt;
  final int earnedXp;
  final List<String> completedChallenges;
  
  LessonProgress({
    required this.lessonId,
    required this.completedAt,
    required this.earnedXp,
    required this.completedChallenges,
  });
  
  factory LessonProgress.fromJson(Map<String, dynamic> json) {
    return LessonProgress(
      lessonId: json['lessonId'],
      completedAt: DateTime.parse(json['completedAt']),
      earnedXp: json['earnedXp'],
      completedChallenges: List<String>.from(json['completedChallenges']),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'lessonId': lessonId,
      'completedAt': completedAt.toIso8601String(),
      'earnedXp': earnedXp,
      'completedChallenges': completedChallenges,
    };
  }
}

class DSAProblemProgress {
  final String problemId;
  final DateTime solvedAt;
  final int earnedXp;
  final String solution;
  final String language;
  final int executionTime; // in milliseconds
  final int memoryUsed; // in KB
  
  DSAProblemProgress({
    required this.problemId,
    required this.solvedAt,
    required this.earnedXp,
    required this.solution,
    required this.language,
    required this.executionTime,
    required this.memoryUsed,
  });
  
  factory DSAProblemProgress.fromJson(Map<String, dynamic> json) {
    return DSAProblemProgress(
      problemId: json['problemId'],
      solvedAt: DateTime.parse(json['solvedAt']),
      earnedXp: json['earnedXp'],
      solution: json['solution'],
      language: json['language'],
      executionTime: json['executionTime'],
      memoryUsed: json['memoryUsed'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'problemId': problemId,
      'solvedAt': solvedAt.toIso8601String(),
      'earnedXp': earnedXp,
      'solution': solution,
      'language': language,
      'executionTime': executionTime,
      'memoryUsed': memoryUsed,
    };
  }
}