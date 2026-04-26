import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_task_v1_app/models/task.dart';
import 'package:flutter_task_v1_app/services/supabase_service.dart';

class AddTaskUi extends StatefulWidget {
  const AddTaskUi({super.key});

  @override
  State<AddTaskUi> createState() => _AddTaskUiState();
}

class _AddTaskUiState extends State<AddTaskUi> {
  // เธชเธฃเนเธฒเธเธ•เธฑเธงเธเธงเธเธเธธเธก TextField เนเธฅเธฐเธ•เธฑเธงเนเธเธฃเธ—เธตเนเธเธฐเธ•เนเธญเธเน€เธเนเธเธเนเธญเธกเธนเธฅเธ—เธตเนเธเธนเนเนเธเนเธเนเธญเธเธซเธฃเธทเธญเน€เธฅเธทเธญเธ เน€เธเธทเนเธญเธเธฑเธเธ—เธถเธเนเธ task_tb
  TextEditingController taskNameCtrl = TextEditingController();
  TextEditingController taskWhereCtrl = TextEditingController();
  TextEditingController taskPersonCtrl = TextEditingController();
  bool taskStatus = false;
  TextEditingController taskDuedateCtrl = TextEditingController();
  String taskImageUrl = '';

  //เธ•เธฑเธงเนเธเธฃเน€เธเนเธเนเธเธฅเนเธ—เธตเนเนเธเนเธญเธฑเธเนเธซเธฅเธ”เนเธเธขเธฑเธ task_bk
  File? file;

  //---- เน€เธเธดเธ”เธเธฅเธญเธเธ–เนเธฒเธขเธ เธฒเธ เนเธฅเธฐเธเธณเธซเธเธ”เธเนเธฒเธฃเธนเธเน€เธเธทเนเธญ upload ----

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.camera);

    if (picked != null) {
      setState(() {
        file = File(picked.path);
      });
    }
  }

  //-------------------------
  //---- เน€เธเธดเธ”เธเธเธดเธ—เธฑเธเน€เธฅเธทเธญเธเธงเธฑเธเธ—เธตเน เนเธฅเธฐเธเธณเธซเธเธ”เธเนเธฒเธงเธฑเธเธ—เธตเน ----
  DateTime? selectedDate;

  Future<void> pickDate() async {
    // เน€เธเธดเธ”เธเธเธดเธ—เธฑเธ
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    // เธเธณเธซเธเธ”เธเนเธฒเธงเธฑเธเธ—เธตเนเนเธซเน taskduedatectrl
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        taskDuedateCtrl.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }
  //-------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Task Na Ja V.1 (เน€เธเธดเนเธก)',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 30,
            left: 45,
            right: 45,
            bottom: 50,
          ),
          child: Center(
            child: Column(
              children: [
                // เธชเนเธงเธเนเธชเธ”เธเธฃเธนเธเนเธฅเธฐเธฃเธนเธเธเธฅเนเธญเธเน€เธเธทเนเธญเน€เธเธดเธ”เธเธฅเนเธญเธ
                file == null
                    ? InkWell(
                        onTap: () {
                          pickImage();
                        },
                        child: Icon(
                          Icons.add_a_photo_rounded,
                          size: 150,
                          color: Colors.grey[300],
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          pickImage();
                        },
                        child: Image.file(
                          file!,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                // เธเนเธญเธเธ—เธณเธญเธฐเนเธฃ
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'เธ—เธณเธญเธฐเนเธฃ',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                TextField(
                  controller: taskNameCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: 'เน€เธเนเธ เธเธฑเธเธเนเธฒ, เธเนเธญเธกเธซเธฅเธญเธ”เนเธ',
                  ),
                ),
                SizedBox(height: 20),
                // เธเนเธญเธเธ—เธณเธ—เธตเนเนเธซเธ
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'เธ—เธณเธ—เธตเนเนเธซเธ',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                TextField(
                  controller: taskWhereCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: 'เน€เธเนเธ เธเนเธฒเธ, เธ—เธตเนเธ—เธณเธเธฒเธ',
                  ),
                ),
                SizedBox(height: 20),
                // เธเนเธญเธเธ—เธณเธเธฑเธเธเธตเนเธเธ
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'เธ—เธณเธเธฑเธเธเธตเนเธเธ',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                TextField(
                  controller: taskPersonCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: 'เน€เธเนเธ 2, 5',
                  ),
                ),
                SizedBox(height: 20),
                // เน€เธฅเธทเธญเธเธ—เธณเน€เธชเธฃเนเธเธซเธฃเธทเธญเธขเธฑเธ
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'เธ—เธณเน€เธชเธฃเนเธเธซเธฃเธทเธญเธขเธฑเธ',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          taskStatus = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            taskStatus == true ? Colors.green : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        fixedSize: Size(
                          MediaQuery.of(context).size.width * 0.35,
                          50,
                        ),
                      ),
                      child: Text(
                        'เน€เธชเธฃเนเธเนเธฅเนเธง',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          taskStatus = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            taskStatus == false ? Colors.green : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        fixedSize: Size(
                          MediaQuery.of(context).size.width * 0.35,
                          50,
                        ),
                      ),
                      child: Text(
                        'เธขเธฑเธเนเธกเนเน€เธชเธฃเนเธ',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // เน€เธฅเธทเธญเธเธ•เนเธญเธเน€เธชเธฃเนเธเน€เธกเธทเนเธญเนเธซเธฃเน
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'เน€เธชเธฃเนเธเน€เธกเธทเนเธญเนเธซเธฃเน',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                TextField(
                  controller: taskDuedateCtrl,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: 'เน€เธเนเธ 2020-01-31',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () {
                    pickDate();
                  },
                ),
                SizedBox(height: 20),
                // เธเธธเนเธกเธเธฑเธเธ—เธถเธ
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      50,
                    ),
                  ),
                  child: Text(
                    "เธเธฑเธเธ—เธถเธ",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // เธเธธเนเธกเธขเธเน€เธฅเธดเธ
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      taskNameCtrl.clear();
                      taskWhereCtrl.clear();
                      taskPersonCtrl.clear();
                      taskDuedateCtrl.clear();
                      file = null;
                      taskStatus = false;
                      taskImageUrl = '';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      50,
                    ),
                  ),
                  child: Text(
                    "เธขเธเน€เธฅเธดเธ",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
