import 'package:hafazni/Models/User.dart';

enum MessageState {
  notSent,
  sent,
  seen,
}

class Message {
  User sender = User();
  DateTime time = DateTime.now();
  MessageState state = MessageState.notSent;
  String content = "";
  String chatId = "";
}
