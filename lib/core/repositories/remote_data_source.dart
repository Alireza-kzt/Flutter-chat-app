import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference _users = FirebaseFirestore.instance.collection('users');
  CollectionReference _chatRoom = FirebaseFirestore.instance.collection("chatRoom");

  Future getDisplayName() async {
    return await _auth.currentUser.displayName;
  }

  Future getUserByUsername(String username) async {
    return await _users.where("name", isEqualTo: username, isNotEqualTo: _auth.currentUser.displayName).get();
  }

  Future loginUser(String mail, String pass) async {
    var result = await _auth.signInWithEmailAndPassword(email: mail, password: pass);
    return result.user;
  }

  Future registerUser(String mail, String pass) async {
    var result = await _auth.createUserWithEmailAndPassword(email: mail, password: pass);
    return result.user;
  }

  Future addUser(String mail, String name) async {
    _auth.currentUser.updateProfile(displayName: name);
    return _users.add({"email": mail, "name": name});
  }

  Future updateName(String name) async {
    _auth.currentUser.updateProfile(displayName: name);
  }

  Future addChatRoom(chatRoom, chatRoomId) {
    return _chatRoom.doc(chatRoomId).set(chatRoom);
  }

  Future getUserChats() async {
    return await _chatRoom.where('users', arrayContains: _auth.currentUser.displayName).snapshots();
  }

  Future getChats(String chatRoomId) async{
    return _chatRoom.doc(chatRoomId).collection("chats").orderBy('time').snapshots();
  }

  Future addMessage(String chatRoomId, chatMessageData){
    return _chatRoom.doc(chatRoomId).collection("chats").add(chatMessageData);
  }
}
