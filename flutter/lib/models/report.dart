// ignore_for_file: file_names

class Report {
  final int id;
  final int userId;
  final String name;
  final String description;
  final DateTime creationDate;
  final String imagePath;
  final String place;
  final String status;

  Report({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.creationDate,
    required this.imagePath,
    required this.place,
    required this.status,
  });

  // Factory constructor to create a Report object from JSON
  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      description: json['description'],
      creationDate: DateTime.parse(json['creationDate']),
      imagePath: json['imagePath'] ?? '',
      place: json['place'] ?? '',
      status: json['status'] ?? 'Pending',
    );
  }

  // Method to convert a Report object to JSON (useful for creating a report)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'description': description,
      'creationDate': creationDate.toIso8601String(),
      'imagePath': imagePath,
      'place': place,
      'status': status,
    };
  }
}
