import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/Features/Core/ChatPage/Blocs/Chat/chat_cubit.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';

import 'Widgets/ChatBody.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText("محادثة"),
      ),
      backgroundColor: const Color.fromRGBO(236, 236, 236, 1),
      body: BlocProvider(
        create: (context) => ChatCubit(),
        child: const ChatBody(),
      ),
    );
  }
}
