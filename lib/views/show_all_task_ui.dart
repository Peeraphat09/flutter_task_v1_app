import 'package:flutter/material.dart';
import 'package:flutter_task_v1_app/models/task.dart';
import 'package:flutter_task_v1_app/services/supabase_service.dart';
import 'package:flutter_task_v1_app/views/add_task_ui.dart';
import 'package:flutter_task_v1_app/views/update_delete_task_ui.dart';

class ShowAllTaskUi extends StatefulWidget {
  const ShowAllTaskUi({super.key});

  @override
  State<ShowAllTaskUi> createState() => _ShowAllTaskUiState();
}

class _ShowAllTaskUiState extends State<ShowAllTaskUi> {
  final service = SupabaseService();
  List<TaskModel> tasks = [];
  bool isLoading = true;

  void loadTasks() async {
    setState(() => isLoading = true);
    try {
      final data = await service.getAllTasks();
      setState(() {
        tasks = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Task Tracker',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTaskUi(),
            ),
          ).then((value) {
            if (value == true) {
              loadTasks();
            }
          });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: isLoading 
        ? const Center(child: CircularProgressIndicator()) 
        : Center(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Image.asset(
              'assets/images/logo.png',
              width: 180,
              height: 180,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10.0,
                      left: 35,
                      right: 35,
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateDeleteTaskUi(task: tasks[index]),
                          ),
                        ).then((value) {
                          if (value == true) {
                            loadTasks();
                          }
                        });
                      },
                      leading: tasks[index].taskImageUrl != null && tasks[index].taskImageUrl!.isNotEmpty
                          ? Image.network(
                              tasks[index].taskImageUrl!,
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
                        'งาน: ${tasks[index].taskName}',
                      ),
                      subtitle: Text(
                        'สถานะ: ${tasks[index].taskStatus == true ? 'เสร็จแล้ว' : 'ยังไม่เสร็จ'}',
                      ),
                      trailing: const Icon(
                        Icons.info,
                        color: Colors.green,
                      ),
                      tileColor: index % 2 == 0 ? Colors.green[100] : Colors.grey[100],
                      contentPadding: const EdgeInsets.all(10),
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
