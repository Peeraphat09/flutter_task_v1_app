import 'package:flutter/material.dart';
import 'package:flutter_task_v1_app/models/task.dart';
import 'package:flutter_task_v1_app/services/supabase_service.dart';
import 'package:flutter_task_v1_app/views/add_task_ui.dart';

class ShowAllTaskUi extends StatefulWidget {
  const ShowAllTaskUi({super.key});

  @override
  State<ShowAllTaskUi> createState() => _ShowAllTaskUiState();
}

class _ShowAllTaskUiState extends State<ShowAllTaskUi> {
  // สร้าง Instance ของ SupabaseService
  final service = SupabaseService();

  // สร้างตัวแปรสำหรับเก็บข้อมูลจาก supabase
  List<Task> tasks = [];

  // สร้าง method เพื่อเรียกใช้ service ดึงข้อมูลมาเก็บในตัวแปร
  void loadTasks() async {
    final data = await service.getTasks();
    setState(() {
      tasks = data;
    });
  }

  @override
  void initState() {
    super.initState();
    // โหลดข้อมูลเมื่อหน้าต่างถูกสร้าง
    loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ส่วนของ appBar
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Task Na Ja V.1',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      // ส่วนของปุ่มเพิ่มงาน
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskUi(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      // ส่วนของตำแหน่งปุ่มที่เพิ่มงาน
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // ส่วนของ body ที่แสดง logo กับข้อมูลมาจาก supabase
      body: Center(
        child: Column(
          children: [
            // ส่วนของ logo
            SizedBox(height: 40),
            Image.asset(
              'assets/images/logo.png',
              width: 180,
              height: 180,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            // ส่วนของ listview แสดงข้อมูล task_tb จาก supabase
            Expanded(
              child: ListView.builder(
                // จำนวนรายการ
                itemCount: tasks.length,
                // หน้าตาของแต่ละรายการ
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10.0,
                      left: 35,
                      right: 35,
                    ),
                    child: ListTile(
                      onTap: () {
                        // ทำอะไรบางอย่างเมื่อกดรายการ
                      },
                      leading: tasks[index].task_image_url! != ''
                          ? Image.network(
                              tasks[index].task_image_url!,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/logo.png',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                      title: Text(
                        'งาน: ${tasks[index].task_name}',
                      ),
                      subtitle: Text(
                        'สถานะ: ${tasks[index].task_status == true ? 'เสร็จ' : 'ยังไม่เสร็จ'}',
                      ),
                      trailing: Icon(
                        Icons.info,
                        color: Colors.red,
                      ),
                      tileColor: index % 2 == 0 ? Colors.green[50] : Colors.pink[50],
                      contentPadding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
