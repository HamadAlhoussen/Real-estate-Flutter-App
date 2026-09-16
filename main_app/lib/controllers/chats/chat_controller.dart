// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../accounts_controllers/me_controller.dart';

// class ChatController extends GetxController {
//   final me = Get.find<MeController>();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Rxn<String> chatId = Rxn<String>();

//   void initChat(int otherUserId) {
//     final user = me.user.value;
//     if (user == null) return;
//     final myId = user.id;

//     chatId.value = myId < otherUserId
//         ? 'chat_${myId}_$otherUserId'
//         : 'chat_${otherUserId}_$myId';
//   }

//   Stream<QuerySnapshot>? messagesStream() {
//     final id = chatId.value;
//     if (id == null) return null;

//     return _firestore
//         .collection('chats')
//         .doc(id)
//         .collection('messages')
//         // .orderBy('created_at')
//         .snapshots();
//   }

//   Future<void> sendMessage(String text, int otherUserId) async {
//     final user = me.user.value;
//     if (user == null) return;

//     final myId = user.id;
//     initChat(otherUserId);

//     final id = chatId.value;
//     if (id == null) return;

//     final chatRef = _firestore.collection('chats').doc(id);

//     await chatRef.set({
//       'users': [myId, otherUserId],
//       'updated_at': FieldValue.serverTimestamp(),
//       'last_message': text,
//     }, SetOptions(merge: true));

//     await chatRef.collection('messages').add({
//       'text': text,
//       'sender_id': myId,
//       // 'created_at': FieldValue.serverTimestamp(),
//     });
//   }
// }
