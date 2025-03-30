class ClassModel {
  final int id;
  final String className;
  final String subject;
  final String teacher;
  final String schedule;
  final String room;

  ClassModel({
    required this.id,
    required this.className,
    required this.subject,
    required this.teacher,
    required this.schedule,
    required this.room,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['id'],
      className: json['className'],
      subject: json['subject'],
      teacher: json['teacher'],
      schedule: json['schedule'],
      room: json['room'],
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "className": className,
        "subject": subject,
        "teacher": teacher,
        "schedule": schedule,
        "room": room,
      };
}
