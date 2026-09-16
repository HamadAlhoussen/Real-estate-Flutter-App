import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ChatScreen.dart';

const List<String> chatNames = [
  "Andrew",
  "Ahmad",
  "Sara",
  "Mohammad",
  "Lana",
  "Omar",
  "Dina",
  "Rami",
  "Khaled",
  "Nour",
];

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => MessagesPageState();
}

class MessagesPageState extends State<MessagesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50, left: 20, bottom: 10),
            child: Text(
              "84".tr,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () {
                showSearch(context: context, delegate: MySearchDelegate());
              },
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(233, 231, 231, 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Color.fromRGBO(175, 173, 173, 1)),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "85".tr,
                        style: TextStyle(
                          color: Color.fromRGBO(175, 173, 173, 1),
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: chatNames.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.fromLTRB(10, 4, 10, 8),
                  elevation: 6,
                  child: SizedBox(
                    height: 80,
                    child: Stack(
                      children: [
                        ListTile(
                          leading: const CircleAvatar(
                            radius: 28,
                            backgroundImage: AssetImage("images/flat1.jpg"),
                          ),
                          title: Text(
                            chatNames[index],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: const Text(
                            "dataaa",
                            style: TextStyle(fontSize: 14),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ChatScreen(userName: chatNames[index]),
                              ),
                            );
                          },
                        ),
                        if (Get.locale?.languageCode == 'en') ...[
                          Positioned(
                            top: 8,
                            right: 12,
                            child: Text(
                              "12:45 PM",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ] else ...[
                          Positioned(
                            top: 8,
                            left: 12,
                            child: Text(
                              "12:45 PM",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MySearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(icon: const Icon(Icons.close), onPressed: () => query = ""),
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => close(context, ""),
  );

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filtered = chatNames
        .where((name) => name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(filtered[index]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatScreen(userName: filtered[index]),
              ),
            );
          },
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../controllers/accounts_controllers/me_controller.dart';
// import 'ChatScreen.dart';

// class MessagesPage extends StatefulWidget {
//   const MessagesPage({super.key});

//   @override
//   State<MessagesPage> createState() => MessagesPageState();
// }

// class MessagesPageState extends State<MessagesPage> {
//   late int myId;

//   @override
//   void initState() {
//     super.initState();
//     myId = Get.find<MeController>().user.value!.id;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Padding(
//             padding: EdgeInsets.only(top: 50, left: 20, bottom: 10),
//             child: Text(
//               "Chats",
//               style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: GestureDetector(
//               onTap: () {
//                 showSearch(context: context, delegate: MySearchDelegate());
//               },
//               child: Container(
//                 height: 50,
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 decoration: BoxDecoration(
//                   color: const Color.fromRGBO(233, 231, 231, 1),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: const Row(
//                   children: [
//                     Icon(Icons.search, color: Color.fromRGBO(175, 173, 173, 1)),
//                     SizedBox(width: 10),
//                     Expanded(
//                       child: Text(
//                         "Search...",
//                         style: TextStyle(
//                           color: Color.fromRGBO(175, 173, 173, 1),
//                           fontSize: 16,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('chats')
//                   .where('users', arrayContains: myId)
//                   .orderBy('updated_at', descending: true)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 final chats = snapshot.data!.docs;

//                 return ListView.builder(
//                   itemCount: chats.length,
//                   itemBuilder: (context, index) {
//                     final data = chats[index].data() as Map<String, dynamic>;
//                     final users = List<int>.from(data['users']);
//                     final otherUserId = users.firstWhere((id) => id != myId);

//                     return Card(
//                       margin: const EdgeInsets.fromLTRB(10, 4, 10, 8),
//                       elevation: 6,
//                       child: ListTile(
//                         leading: const CircleAvatar(
//                           radius: 28,
//                           backgroundImage: AssetImage("images/flat1.jpg"),
//                         ),
//                         title: Text("User $otherUserId"),
//                         subtitle: Text(data['last_message'] ?? ''),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => ChatScreen(
//                                 userName: "User $otherUserId",
//                                 otherUserId: otherUserId,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MySearchDelegate extends SearchDelegate<String> {
//   @override
//   List<Widget>? buildActions(BuildContext context) => [
//         IconButton(icon: const Icon(Icons.close), onPressed: () => query = ""),
//       ];

//   @override
//   Widget? buildLeading(BuildContext context) => IconButton(
//         icon: const Icon(Icons.arrow_back),
//         onPressed: () => close(context, ""),
//       );

//   @override
//   Widget buildResults(BuildContext context) {
//     return const SizedBox();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // هنا نفس البحث على الـ chats في Firebase
//     return const SizedBox();
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../controllers/accounts_controllers/me_controller.dart';
// import '../../controllers/chats/chat_controller.dart';
// import 'ChatScreen.dart';

// class MessagesPage extends StatelessWidget {
//   MessagesPage({super.key});

//   final meController = Get.find<MeController>();
//   final chatController = Get.put(ChatController());

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final user = meController.user.value;

//       if (user == null) {
//         return const Center(child: CircularProgressIndicator());
//       }

//       final myId = user.id;

//       return Scaffold(
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Padding(
//               padding: EdgeInsets.only(top: 50, left: 20, bottom: 10),
//               child: Text(
//                 "Chats",
//                 style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Expanded(
//               child: StreamBuilder<QuerySnapshot>(
//                 stream: FirebaseFirestore.instance
//                     .collection('chats')
//                     .where('users', arrayContains: myId)
//                     .orderBy('updated_at', descending: true)
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) {
//                     return const Center(child: CircularProgressIndicator());
//                   }

//                   final chats = snapshot.data!.docs;

//                   if (chats.isEmpty) {
//                     return const Center(child: Text("No chats yet"));
//                   }

//                   return ListView.builder(
//                     itemCount: chats.length,
//                     itemBuilder: (context, index) {
//                       final data = chats[index].data() as Map<String, dynamic>;
//                       final users = List<int>.from(data['users']);
//                       final otherUserId = users.firstWhere((id) => id != myId);

//                       return Card(
//                         margin: const EdgeInsets.fromLTRB(10, 4, 10, 8),
//                         elevation: 6,
//                         child: ListTile(
//                           leading: const CircleAvatar(
//                             radius: 28,
//                             backgroundImage: AssetImage("images/flat1.jpg"),
//                           ),
//                           title: Text("User $otherUserId"),
//                           subtitle: Text(data['last_message'] ?? ''),
//                           onTap: () {
//                             chatController.initChat(otherUserId);
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_) => ChatScreen(
//                                   userName: "User $otherUserId",
//                                   otherUserId: otherUserId,
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../controllers/accounts_controllers/me_controller.dart';
// import 'ChatScreen.dart';

// class MessagesPage extends StatefulWidget {
//   const MessagesPage({super.key});

//   @override
//   State<MessagesPage> createState() => MessagesPageState();
// }

// class MessagesPageState extends State<MessagesPage> {
//   late int myId;

//   @override
//   void initState() {
//     super.initState();
//    
//     final currentUser = Get.find<MeController>().user.value;
//     if (currentUser == null) {
//      
//       myId = -1;
//     } else {
//       myId = currentUser.id;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (myId == -1) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Padding(
//             padding: EdgeInsets.only(top: 50, left: 20, bottom: 10),
//             child: Text(
//               "Chats",
//               style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('users')
//                   .where('id', isNotEqualTo: myId) // استثناء المستخدم الحالي
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 if (snapshot.hasError) {
//                   return Center(
//                     child: Text(
//                       "Error loading users: ${snapshot.error}",
//                       textAlign: TextAlign.center,
//                     ),
//                   );
//                 }

//                 final users = snapshot.data?.docs ?? [];

//                 if (users.isEmpty) {
//                   return const Center(
//                     child: Text("No users available"),
//                   );
//                 }

//                 return ListView.builder(
//                   itemCount: users.length,
//                   itemBuilder: (context, index) {
//                     final data = users[index].data() as Map<String, dynamic>;
//                     final userId = data['id'] as int;
//                     final userName = "${data['first_name']} ${data['last_name']}";

//                     return Card(
//                       margin: const EdgeInsets.fromLTRB(10, 4, 10, 8),
//                       elevation: 6,
//                       child: ListTile(
//                         leading: const CircleAvatar(
//                           radius: 28,
//                           backgroundImage: AssetImage("images/flat1.jpg"),
//                         ),
//                         title: Text(userName),
//                         onTap: () {
                          
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (_) => ChatScreen(
                          //       userName: userName,
                          //       otherUserId: userId,
                          //     ),
                          //   ),
                          // );
//                         },
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
