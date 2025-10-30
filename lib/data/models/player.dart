import 'package:equatable/equatable.dart';

class Player extends Equatable {
  final String id;
  final String name;
  final String createdBy;
  final DateTime createdAt;
  final DateTime? deletedAt;

  const Player({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.createdAt,
    required this.deletedAt,
  });

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      id: map['id'],
      name: map['name'],
      createdBy: map['created_by'],
      createdAt: DateTime.parse(map['created_at']),
      deletedAt: map['deleted_at'] != null
          ? DateTime.parse(map['deleted_at'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "created_by": createdBy,
      "created_at": createdAt.toIso8601String(),
      "deleted_at": deletedAt?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Player{'
        'id: $id, '
        'name: $name, '
        'createdBy: $createdBy, '
        'createdAt: $createdAt, '
        'deletedAt: $deletedAt'
        '}';
  }

  @override
  List<Object?> get props => [id, name, createdBy, createdAt, deletedAt];
}
