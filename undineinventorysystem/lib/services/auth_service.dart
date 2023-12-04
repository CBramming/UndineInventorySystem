import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in with email and password using Firebase
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // TODO: Implement register
  // Register with email and password using Firebase
  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
try {
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
  return credential.user;
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
} catch (e) {
  print(e);
}
  }

static Future<void> addItemToDB(String nameId, int amount) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference items = firestore.collection('Items');

    await items.add({
      'something': nameId,
      'amount2': amount,
    });
  } catch (e) {
    print('Error');
  }
}

static Future<void> deleteItemToDB(String nameId, int amount) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference items = firestore.collection('Items');

    QuerySnapshot querySnapshot = await items.where('something', isEqualTo: nameId).get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  } catch (e) {
    print('Error');
  }
}

  // TODO: Implement signOut
  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
