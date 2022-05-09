

class Band {
  String id;
  String name;
  int votes;

  Band({
    required this.id,
    required this.name,
    required this.votes
  });

  factory Band.fromMap(Map<String, dynamic> obj ) {
    return Band(
      id: obj['id'], 
      name: obj['name'], 
      votes: obj['votes']
    );
  }
}

