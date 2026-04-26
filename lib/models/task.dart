// ไฟล์นี้ใช้สำหรับเก็บข้อมูลของ table ที่เราจะทำงานด้านหลัง
class TaskModel {
  String? id;
  String taskName;
  String taskWhere;
  int taskPerson;
  bool taskStatus;
  String taskDuedate;
  String? taskImageUrl;

  TaskModel({
    this.id,
    required this.taskName,
    required this.taskWhere,
    required this.taskPerson,
    required this.taskStatus,
    required this.taskDuedate,
    this.taskImageUrl,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json['id']?.toString(),
        taskName: json['task_name'] ?? '',
        taskWhere: json['task_where'] ?? '',
        taskPerson: json['task_person'] ?? 0,
        taskStatus: json['task_status'] ?? false,
        taskDuedate: json['task_duedate'] ?? '',
        taskImageUrl: json['task_image_url'],
      );

  Map<String, dynamic> toJson() => {
        'task_name': taskName,
        'task_where': taskWhere,
        'task_person': taskPerson,
        'task_status': taskStatus,
        'task_duedate': taskDuedate,
        'task_image_url': taskImageUrl,
      };
}
