import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hafazni/Models/Message.dart';
import 'package:hafazni/Models/User.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial()) {
    user = User()..id = "user 1";
    messages = [
      Message()
        ..content =
            "مsssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssاذا",
    ];
  }
  late final List<Message> messages;
  final TextEditingController controller = TextEditingController();
  late final User user;
  final ScrollController scrollController = ScrollController();
  @override
  Future<void> close() {
    controller.dispose();
    scrollController.dispose();
    return super.close();
  }

  void sendMessage() {
    if (controller.text.isNotEmpty) {
      messages.add(Message()
        ..content = controller.text
        ..sender = user);
      controller.text = "";

      emit(ChatInitial());
      scrollController.animateTo(
        scrollController.position.maxScrollExtent + 10,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }
}
