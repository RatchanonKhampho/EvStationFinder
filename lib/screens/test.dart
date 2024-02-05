import 'package:flutter/material.dart';

class PDPAFormDialog extends StatefulWidget {
  @override
  _PDPAFormDialogState createState() => _PDPAFormDialogState();
}

class _PDPAFormDialogState extends State<PDPAFormDialog> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  bool _acceptedPDPA = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('กรุณากรอกข้อมูล'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Checkbox(
                value: _acceptedPDPA,
                onChanged: (value) {
                  setState(() {
                    _acceptedPDPA = value!;
                  });
                },
              ),
              Text('ยอมรับข้อตกลงตาม PDPA'),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('ยกเลิก'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_acceptedPDPA) {
              // บันทึกข้อมูลที่ได้จากฟอร์ม
              String name = _nameController.text;
              String email = _emailController.text;

              // นำข้อมูลไปใช้ต่อ หรือบันทึกลงฐานข้อมูล
              print('ชื่อ-สกุล: $name');
              print('อีเมล: $email');

              // ปิด dialog
              Navigator.of(context).pop();
            } else {
              // แสดงข้อความเตือนถ้ายังไม่ยอมรับ PDPA
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('กรุณายอมรับข้อตกลงตาม PDPA'),
                ),
              );
            }
          },
          child: Text('ยืนยัน'),
        ),
      ],
    );
  }
}
