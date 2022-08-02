class Workout {
  final String name, day, duration;
  const Workout({
    required this.name,
    required this.day,
    required this.duration,
  });

  factory Workout.fromMap(Map<String, dynamic> json) {
    return Workout(
      name: json['name'],
      day: json['day'],
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'day': day,
      'duration': duration,
    };
  }
}
