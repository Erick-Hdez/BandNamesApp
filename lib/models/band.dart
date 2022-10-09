class Band {
  String id;
  String name;
  int votes;

  Band({required this.id, required this.name, this.votes = 0});

  // Comunicacion por sockets ( Creando un factory constructor )
  factory Band.fromMap(Map<String, dynamic> obj) =>
      Band(id: obj['id'], name: obj['name'], votes: obj['votes']);

  @override
  String toString() {
    return 'Id: $id, Name: $name, Votes: $votes';
  }
}
