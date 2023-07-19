import 'dart:convert';

class ContactModel {
  final String? id;
  final String name;
  final String email;

  ContactModel({
    this.id,
    required this.name,
    required this.email,
  });

  ContactModel copyWith({
    String? id,
    String? name,
    String? email,
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'],
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactModel.fromJson(String source) => ContactModel.fromMap(json.decode(source));

  @override
  String toString() => 'ContactModel(id: $id, name: $name, email: $email)';
}
