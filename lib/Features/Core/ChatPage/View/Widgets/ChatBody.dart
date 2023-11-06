import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/Features/Core/ChatPage/Blocs/Chat/chat_cubit.dart';
import 'package:hafazni/GeneralWidgets/CustomIconButton.dart';
import 'package:hafazni/GeneralWidgets/CustomTextBox.dart';

import 'MessageWidget.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChatCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //const SizedBox(height: 20),
        BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            return Expanded(
              child: ListView.builder(
                //reverse: true,
                controller: cubit.scrollController,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: cubit.messages.length,
                itemBuilder: (ctx, idx) => MessageWidget(
                  message: cubit.messages[idx],
                  reversed: cubit.user.id != cubit.messages[idx].sender.id,
                ),
              ),
            );
          },
        ),
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                width: 0.5,
                color: Colors.black26,
              ),
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: RotatedBox(
                  quarterTurns: 2,
                  child: CustomIconButton(
                    verticalPadding: 10,
                    horizontalPadding: 10,
                    icon: Icons.send,
                    iconColor: Colors.white,
                    backColor: const Color.fromRGBO(0, 128, 105, 1),
                    onTap: cubit.sendMessage,
                  ),
                ),
              ),
              Expanded(
                child: CustomTextBox(
                  hintText: "اكتب رسالتك هنا ...",
                  borderRadius: 0,
                  backgroundColor: Colors.white,
                  controller: cubit.controller,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
