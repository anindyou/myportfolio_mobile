import 'package:json_annotation/json_annotation.dart';

part 'experience.g.dart';

// Django DateField hanya menerima "YYYY-MM-DD"
DateTime _dateFromJson(String json) => DateTime.parse(json);
String _dateToJson(DateTime date) => date.toIso8601String().substring(0, 10);

DateTime? _dateFromJsonN(String? json) =>
    json == null ? null : DateTime.parse(json);
String? _dateToJsonN(DateTime? date) =>
    date?.toIso8601String().substring(0, 10);

/// Experience synchronized with the Django REST Framework API.
@JsonSerializable(fieldRename: FieldRename.snake)
class Experience {
  const Experience({
    this.id,
    required this.title,
    this.institution,
    required this.description,
    required this.startedAt,
    this.endedAt,
  });

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);

  @JsonKey(includeToJson: false)
  final String? id;
  final String title;
  final String? institution;
  final String description;

  @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson)
  final DateTime startedAt;

  @JsonKey(fromJson: _dateFromJsonN, toJson: _dateToJsonN)
  final DateTime? endedAt;

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}