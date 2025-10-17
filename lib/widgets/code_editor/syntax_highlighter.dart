import 'package:flutter/material.dart';

class SyntaxHighlighter {
  static TextSpan highlight(String code, String language) {
    // This is a simplified version - in a real app, we would use a more robust syntax highlighting library
    
    // Define syntax highlighting patterns for different languages
    Map<String, RegExp> keywordPatterns = {
      'python': RegExp(r'\b(def|class|if|else|elif|for|while|import|from|return|True|False|None)\b'),
      'javascript': RegExp(r'\b(function|const|let|var|if|else|for|while|return|import|export|class|true|false|null)\b'),
      'java': RegExp(r'\b(public|private|protected|class|interface|void|int|String|boolean|return|if|else|for|while|true|false|null)\b'),
      'cpp': RegExp(r'\b(int|float|double|char|void|class|struct|if|else|for|while|return|true|false|nullptr)\b'),
      'go': RegExp(r'\b(func|package|import|var|const|if|else|for|return|struct|interface|map|true|false|nil)\b'),
      'rust': RegExp(r'\b(fn|let|mut|if|else|for|while|return|struct|enum|trait|impl|true|false|None)\b'),
    };
    
    RegExp stringPattern = RegExp('("[^"]*"|\\\'[^\\\']*\\\')');

    RegExp commentPattern = RegExp(r'(//.*|/\*[\s\S]*?\*/|#.*)');
    RegExp numberPattern = RegExp(r'\b(\d+(\.\d+)?)\b');
    
    // Default to Python if language not supported
    RegExp keywordPattern = keywordPatterns[language.toLowerCase()] ?? keywordPatterns['python']!;
    
    // Split the code into segments to apply different styles
    List<TextSpan> spans = [];
    String remaining = code;
    
    // Process comments first
    _processPattern(remaining, commentPattern, Colors.grey, spans, (match) {
      remaining = remaining.replaceFirst(match.group(0)!, '');
    });
    
    // Process strings
    _processPattern(remaining, stringPattern, Colors.green, spans, (match) {
      remaining = remaining.replaceFirst(match.group(0)!, '');
    });
    
    // Process keywords
    _processPattern(remaining, keywordPattern, Colors.blue, spans, (match) {
      remaining = remaining.replaceFirst(match.group(0)!, '');
    });
    
    // Process numbers
    _processPattern(remaining, numberPattern, Colors.orange, spans, (match) {
      remaining = remaining.replaceFirst(match.group(0)!, '');
    });
    
    // Add any remaining text
    if (remaining.isNotEmpty) {
      spans.add(TextSpan(text: remaining, style: const TextStyle(color: Colors.black)));
    }
    
    return TextSpan(children: spans);
  }
  
  static void _processPattern(
    String text,
    RegExp pattern,
    Color color,
    List<TextSpan> spans,
    Function(RegExpMatch) onMatch,
  ) {
    pattern.allMatches(text).forEach((match) {
      spans.add(TextSpan(
        text: match.group(0),
        style: TextStyle(color: color),
      ));
      onMatch(match);
    });
  }
}