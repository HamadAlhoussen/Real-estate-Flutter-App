import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatMessage {
  final String text;
  final bool mee;

  ChatMessage({required this.text, required this.mee});
}

final List<ChatMessage> messages = [
  ChatMessage(text: "aaaaaa", mee: false),
  ChatMessage(text: "aaaaaaa", mee: true),
  ChatMessage(text: "aaaaaaaa", mee: false),
];

class ChatScreen extends StatefulWidget {
  final String userName;

  const ChatScreen({super.key, required this.userName});

  @override
  State<ChatScreen> createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.userName,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromRGBO(6, 10, 53, 1),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return Align(
                  alignment: msg.mee
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    decoration: BoxDecoration(
                      color: msg.mee
                          ? const Color.fromRGBO(6, 10, 53, 1)
                          : Colors.grey.shade300,
                      borderRadius: msg.mee
                          ? BorderRadius.only(
                              topLeft: Radius.circular(40),
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                            )
                          : BorderRadius.only(
                              topRight: Radius.circular(40),
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                            ),
                    ),
                    child: Text(
                      msg.text,
                      style: TextStyle(
                        color: msg.mee ? Colors.white : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "75".tr,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: const Color.fromRGBO(6, 10, 53, 1),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../controllers/accounts_controllers/me_controller.dart';
// import '../../controllers/chats/chat_controller.dart';

// class ChatScreen extends StatefulWidget {
//   final String userName;
//   final int otherUserId;

//   const ChatScreen({super.key, required this.userName, required this.otherUserId});

//   @override
//   State<ChatScreen> createState() => ChatScreenState();
// }

// class ChatScreenState extends State<ChatScreen> {
//   final ChatController chatController = Get.put(ChatController());
//   final TextEditingController messageController = TextEditingController();
//   late int myId;

//   @override
//   void initState() {
//     super.initState();
//     myId = Get.find<MeController>().user.value!.id;
//     chatController.initChat(widget.otherUserId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.userName,
//           style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         iconTheme: const IconThemeData(color: Colors.white),
//         backgroundColor: const Color.fromRGBO(6, 10, 53, 1),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: chatController.messagesStream(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 final docs = snapshot.data!.docs;

//                 return ListView.builder(
//                   padding: const EdgeInsets.all(12),
//                   itemCount: docs.length,
//                   itemBuilder: (context, index) {
//                     final data = docs[index].data() as Map<String, dynamic>;
//                     final isMe = data['sender_id'] == myId;

//                     return Align(
//                       alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(vertical: 4),
//                         padding: const EdgeInsets.all(12),
//                         constraints: BoxConstraints(
//                           maxWidth: MediaQuery.of(context).size.width * 0.7,
//                         ),
//                         decoration: BoxDecoration(
//                           color: isMe
//                               ? const Color.fromRGBO(6, 10, 53, 1)
//                               : Colors.grey.shade300,
//                           borderRadius: isMe
//                               ? const BorderRadius.only(
//                                   topLeft: Radius.circular(40),
//                                   bottomLeft: Radius.circular(40),
//                                   bottomRight: Radius.circular(40),
//                                 )
//                               : const BorderRadius.only(
//                                   topRight: Radius.circular(40),
//                                   bottomLeft: Radius.circular(40),
//                                   bottomRight: Radius.circular(40),
//                                 ),
//                         ),
//                         child: Text(
//                           data['text'] ?? '',
//                           style: TextStyle(
//                             color: isMe ? Colors.white : Colors.black,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),


//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5),
//               ],
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: messageController,
//                     decoration: const InputDecoration(
//                       hintText: "Write a message..",
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.send),
//                   color: const Color.fromRGBO(6, 10, 53, 1),
//                   onPressed: () {
//                     if (messageController.text.trim().isEmpty) return;

//                     chatController.sendMessage(
//                       messageController.text.trim(),
//                       widget.otherUserId,
//                     );

//                     messageController.clear();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../controllers/chats/chat_controller.dart';
// import '../../controllers/accounts_controllers/me_controller.dart';

// class ChatScreen extends StatelessWidget {
//   final String userName;
//   final int otherUserId;

//   ChatScreen({super.key, required this.userName, required this.otherUserId});

//   final chatController = Get.find<ChatController>();
//   final meController = Get.find<MeController>();
//   final TextEditingController messageController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final user = meController.user.value;
//       if (user == null) {
//         return const Scaffold(
//           body: Center(child: CircularProgressIndicator()),
//         );
//       }

//       final messagesStream = chatController.messagesStream();

//       return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             userName,
//             style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//           iconTheme: const IconThemeData(color: Colors.white),
//           backgroundColor: const Color.fromRGBO(6, 10, 53, 1),
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               child: messagesStream == null
//                   ? const Center(child: Text("Loading chat..."))
//                   : StreamBuilder<QuerySnapshot>(
//                       stream: messagesStream,
//                       builder: (context, snapshot) {
//                         if (!snapshot.hasData) {
//                           return const Center(child: CircularProgressIndicator());
//                         }

//                         final docs = snapshot.data!.docs.reversed.toList();

//                         return ListView.builder(
//                           reverse: true,
//                           padding: const EdgeInsets.all(12),
//                           itemCount: docs.length,
//                           itemBuilder: (context, index) {
//                             final data = docs[index].data() as Map<String, dynamic>;
//                             final isMe = data['sender_id'] == user.id;

//                             return Align(
//                               alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//                               child: Container(
//                                 margin: const EdgeInsets.symmetric(vertical: 4),
//                                 padding: const EdgeInsets.all(12),
//                                 constraints: BoxConstraints(
//                                   maxWidth: MediaQuery.of(context).size.width * 0.7,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: isMe
//                                       ? const Color.fromRGBO(6, 10, 53, 1)
//                                       : Colors.grey.shade300,
//                                   borderRadius: isMe
//                                       ? const BorderRadius.only(
//                                           topLeft: Radius.circular(40),
//                                           bottomLeft: Radius.circular(40),
//                                           bottomRight: Radius.circular(40),
//                                         )
//                                       : const BorderRadius.only(
//                                           topRight: Radius.circular(40),
//                                           bottomLeft: Radius.circular(40),
//                                           bottomRight: Radius.circular(40),
//                                         ),
//                                 ),
//                                 child: Text(
//                                   data['text'] ?? '',
//                                   style: TextStyle(
//                                     color: isMe ? Colors.white : Colors.black,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         );
//                       },
//                     ),
//             ),

//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: messageController,
//                       decoration: const InputDecoration(
//                         hintText: "Write a message..",
//                         border: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.send),
//                     color: const Color.fromRGBO(6, 10, 53, 1),
//                     onPressed: () {
//                       final text = messageController.text.trim();
//                       if (text.isEmpty) return;

//                       chatController.sendMessage(text, otherUserId);
//                       messageController.clear();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }
