class Competition {
  final String created_at;
  final String remainingTime;
  int parseRemainingTime(String timeString) {
    final regex = RegExp(r'(\d+)h\s+(\d+)m\s+(\d+)s');
    final match = regex.firstMatch(timeString);

    if (match != null) {
      final hours = int.parse(match.group(1)!);
      final minutes = int.parse(match.group(2)!);
      final seconds = int.parse(match.group(3)!);
      return hours * 3600 + minutes * 60 + seconds;
    }
    return 0;
  }

  Competition({required this.created_at, required this.remainingTime});

  factory Competition.fromJson(Map<String, dynamic> json) {
    return Competition(
      created_at: json['end_date'] ?? '',
      remainingTime: json['remaining_time'] ?? '',
    );
  }
}
