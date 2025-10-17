import 'package:flutter/foundation.dart';

class User {
  final String id;
  final String username;
  final String email;
  final String? photoUrl;
  final DateTime createdAt;
  final DateTime lastActive;
  final List<String> selectedLanguages;
  final int currentStreak;
  final int longestStreak;
  final int totalXp;
  final int level;
  
  User({
    required this.id,
    required this.username,
    required this.email,
    this.photoUrl,
    required this.createdAt,
    required this.lastActive,
    required this.selectedLanguages,
    required this.currentStreak,
    required this.longestStreak,
    required this.totalXp,
    required this.level,
  });
  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      photoUrl: json['photoUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      lastActive: DateTime.parse(json['lastActive']),
      selectedLanguages: List<String>.from(json['selectedLanguages']),
      currentStreak: json['currentStreak'],
      longestStreak: json['longestStreak'],
      totalXp: json['totalXp'],
      level: json['level'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'photoUrl': photoUrl,
      'createdAt': createdAt.toIso8601String(),
      'lastActive': lastActive.toIso8601String(),
      'selectedLanguages': selectedLanguages,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'totalXp': totalXp,
      'level': level,
    };
  }
  
  User copyWith({
    String? id,
    String? username,
    String? email,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? lastActive,
    List<String>? selectedLanguages,
    int? currentStreak,
    int? longestStreak,
    int? totalXp,
    int? level,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      lastActive: lastActive ?? this.lastActive,
      selectedLanguages: selectedLanguages ?? this.selectedLanguages,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      totalXp: totalXp ?? this.totalXp,
      level: level ?? this.level,
    );
  }
}