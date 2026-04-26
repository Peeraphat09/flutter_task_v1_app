import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../models/task.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  Future<List<TaskModel>> getAllTasks() async {
    final List<dynamic> response = await supabase.from('task_tb').select().order('created_at');
    return response.map((e) => TaskModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> addTask(TaskModel task) async {
    await supabase.from('task_tb').insert(task.toJson());
  }

  Future<void> updateTask(TaskModel task) async {
    await supabase.from('task_tb').update(task.toJson()).eq('id', task.id!);
  }

  Future<void> deleteTask(String id) async {
    await supabase.from('task_tb').delete().eq('id', id);
  }

  // อัปโหลดรูปรองรับ Web
  Future<String?> uploadImage(XFile imageFile) async {
    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final path = 'tasks/$fileName';
      
      final imageBytes = await imageFile.readAsBytes();

      await supabase.storage.from('task_bk').uploadBinary(
        path, 
        imageBytes,
        fileOptions: const FileOptions(contentType: 'image/jpeg'),
      );
      
      final imageUrl = supabase.storage.from('task_bk').getPublicUrl(path);
      return imageUrl;
    } catch (e) {
      debugPrint('Upload Error: $e');
      return null;
    }
  }

  Future<void> deleteImage(String imageUrl) async {
    try {
      final uri = Uri.parse(imageUrl);
      final pathSegments = uri.pathSegments;
      final fileName = pathSegments.last; 
      await supabase.storage.from('task_bk').remove(['tasks/$fileName']);
    } catch (e) {
      debugPrint('Delete Image Error: $e');
    }
  }
}