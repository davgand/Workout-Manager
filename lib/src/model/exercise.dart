class Exercise {
  int id;
  String name;
  int reps;
  int weight;
  String? notes;

  Exercise(
      {required this.id,
      required this.name,
      required this.reps,
      required this.weight,
      this.notes});

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        id: json['id'],
        name: json['name'],
        reps: json['reps'],
        weight: json['weight'],
        notes: json['notes'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'reps': reps,
      'weight': weight,
      if (notes != null) 'notes': notes else 'notes': "",
    };
  }
}
