import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:ev_charger/main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Messages.dart';

class chatbot extends StatefulWidget {
  const chatbot({super.key});

  @override
  State<chatbot> createState() => _chatbotState();
}

class _chatbotState extends State<chatbot> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> messages = [];
  @override
  void initState() {
    super.initState();
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
  }

  Future<void> getDataFromFirestore() async {
  // เชื่อมต่อกับ Firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // ดึงข้อมูลจาก Firestore
  QuerySnapshot querySnapshot = await firestore.collection('your_collection').get();

  // นำข้อมูลมาใช้งาน
  for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
    print(documentSnapshot.data());
  }
}

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      //27 - 46
      body: Column(
        children: [
          Expanded(child: MessagesScreen(messages: messages)),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            color: Color(0xFFF7F0F0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    cursorColor: buttoncolors,
                    style: TextStyle(color: textmain),

                  ),
                ),
                IconButton(
                  color: buttoncolors,
                  icon: Icon(Icons.send),
                  onPressed: () {
                    sendMessage(_controller.text);
                    _controller.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  void sendMessage(String text) async {
    if (text.isEmpty) return;
    setState(() {
      addMessage(
        Message(text: DialogText(text: [text])),
        true,
      );
    });

    dialogFlowtter.projectId = "evcharger-d3288";

    DetectIntentResponse response = await dialogFlowtter.detectIntent(
      queryInput: QueryInput(text: TextInput(text: text)),
    );

    if (response.message == null) return;
    setState(() {
      addMessage(response.message!);
    });
  }

  void addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({
      'message': message,
      'isUserMessage': isUserMessage,
    });
  }

  @override
  void dispose() {
    dialogFlowtter.dispose();
    super.dispose();
  }
}
