class Suggestion {
  Suggestion({
    required this.activity,
    required this.type,
  });

  final String activity;
  final String type;

  /// Este factory convierte un map en una instancia de la clase Suggestion
  factory Suggestion.fromJson(Map<String, dynamic> json) => 
  Suggestion(
    activity: json["activity"],
    type: json["type"],
  );
}
