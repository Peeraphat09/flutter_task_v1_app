// file นี้ใช้สำหรับจัดการการเชื่อมต่อกับ Supabase

// CRUD กับ Table -> database (PostgreSQL) -> supabase
// upload/delete file bucket -> storage -> supabase

import 'dart:io';

import 'package:flutter_task_v1_app/models/task.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  // สร้าง object/instance ของ Supabase เพื่อใช้งาน
  final supabase = Supabase.instance.client;

  // สร้าง method สำหรับใช้งานกับ supabase
  // ดึงข้อมูลงานทั้งหมดจาก task_tb และ return ค่าที่ได้จากการดึงไปใช้งาน
  Future<List<Task>> getTasks() async {
    // ดึงข้อมูลงานทั้งหมดจาก task_tb
    final data = await supabase.from('task_tb').select('*');

    // return ค่าที่ได้จากการดึงไปใช้งาน
    return data.map((task) => Task.fromJson(task)).toList();
  }

  // method อัปโหลดไฟล์ไปยัง task_bk และ return ค่าที่ได้จากการอัปโหลดไปใช้งาน
  Future<String> uploadFile(File file) async {
    // สร้างชื่อไฟล์ใหม่ให้ไฟล์เพื่อไม่ให้ซ้ำกัน
    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';

    // อัปโหลดไฟล์ไปยัง task_bk
    await supabase.storage.from('task_bk').upload(fileName, file);

    // return ค่าที่ได้จากการอัปโหลดไปใช้งาน
    return supabase.storage.from('task_bk').getPublicUrl(fileName);
  }

  // method ลบไฟล์ที่อัปโหลดไปที่ task_tb
  Future insertTask(Task task) async {
    // เพิ่มข้อมูลไปยัง task_tb
    await supabase.from('task_tb').insert(task.toJson());
  }

  // method เพิ่มข้อมูลไปยัง task_tb

  // method แก้ไขข้อมูลใน task_tb

  // method ลบข้อมูลใน task_tb

}
