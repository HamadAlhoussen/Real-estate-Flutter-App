// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../models/user_account_model.dart';

// class FirebaseUserService {
//   final _firestore = FirebaseFirestore.instance;

//   Future<void> syncUser(UserAccountModel user) async {
//     final docRef =
//         _firestore.collection('users').doc(user.id.toString());

//     final snapshot = await docRef.get();

//     if (!snapshot.exists) {
//       await docRef.set({
//         'id': user.id,
//         'first_name': user.firstName,
//         'last_name': user.lastName,
//         'phone': user.phone,
//         // 'created_at': FieldValue.serverTimestamp(),
//       });
//     }
//   }
// }
