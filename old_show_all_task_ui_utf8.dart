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
  // เธชเธฃเนเธฒเธ Instance เธเธญเธ SupabaseService
  final service = SupabaseService();

  // เธชเธฃเนเธฒเธเธ•เธฑเธงเนเธเธฃเธชเธณเธซเธฃเธฑเธเน€เธเนเธเธเนเธญเธกเธนเธฅเธเธฒเธ supabase
  List<Task> tasks = [];

  // เธชเธฃเนเธฒเธ method เน€เธเธทเนเธญเน€เธฃเธตเธขเธเนเธเน service เธ”เธถเธเธเนเธญเธกเธนเธฅเธกเธฒเน€เธเนเธเนเธเธ•เธฑเธงเนเธเธฃ
  void loadTasks() async {
    final data = await service.getTasks();
    setState(() {
      tasks = data;
    });
  }

  @override
  void initState() {
    super.initState();
    // เนเธซเธฅเธ”เธเนเธญเธกเธนเธฅเน€เธกเธทเนเธญเธซเธเนเธฒเธ•เนเธฒเธเธ–เธนเธเธชเธฃเนเธฒเธ
    loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // เธชเนเธงเธเธเธญเธ appBar
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
      // เธชเนเธงเธเธเธญเธเธเธธเนเธกเน€เธเธดเนเธกเธเธฒเธ
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
      // เธชเนเธงเธเธเธญเธเธ•เธณเนเธซเธเนเธเธเธธเนเธกเธ—เธตเนเน€เธเธดเนเธกเธเธฒเธ
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // เธชเนเธงเธเธเธญเธ body เธ—เธตเนเนเธชเธ”เธ logo เธเธฑเธเธเนเธญเธกเธนเธฅเธกเธฒเธเธฒเธ supabase
      body: Center(
        child: Column(
          children: [
            // เธชเนเธงเธเธเธญเธ logo
            SizedBox(height: 40),
            Image.asset(
              'assets/images/logo.png',
              width: 180,
              height: 180,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            // เธชเนเธงเธเธเธญเธ listview เนเธชเธ”เธเธเนเธญเธกเธนเธฅ task_tb เธเธฒเธ supabase
            Expanded(
              child: ListView.builder(
                // เธเธณเธเธงเธเธฃเธฒเธขเธเธฒเธฃ
                itemCount: tasks.length,
                // เธซเธเนเธฒเธ•เธฒเธเธญเธเนเธ•เนเธฅเธฐเธฃเธฒเธขเธเธฒเธฃ
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
                        // เธ—เธณเธญเธฐเนเธฃเธเธฒเธเธญเธขเนเธฒเธเน€เธกเธทเนเธญเธเธ”เธฃเธฒเธขเธเธฒเธฃ
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
                        'เธเธฒเธ: ${tasks[index].task_name}',
                      ),
                      subtitle: Text(
                        'เธชเธ–เธฒเธเธฐ: ${tasks[index].task_status == true ? 'เน€เธชเธฃเนเธ' : 'เธขเธฑเธเนเธกเนเน€เธชเธฃเนเธ'}',
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
