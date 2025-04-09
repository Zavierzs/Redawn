class JournalEntry {
  final String content;
  final DateTime createdAt;

  JournalEntry({required this.content, required this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  static JournalEntry fromMap(Map<String, dynamic> map) {
    return JournalEntry(
      content: map['content'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
