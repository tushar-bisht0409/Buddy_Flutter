import 'package:buddy/blocs/chat_bloc.dart';
import 'package:buddy/chats/mediamessagebubble.dart';
import 'package:buddy/chats/textmessagebubble.dart';
import 'package:buddy/main.dart';
import 'package:buddy/models/messageinfo.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  String chatID;
  Messages(this.chatID);
  bool isMe;
  final chatbloc = ChatBloc();
  final mszobj = MessageInfo();

  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: chatbloc.messageInfoStream,
      builder: (ctx, snapshot) {
        mszobj.chatID = '12';
        mszobj.action = 'receive';

        chatbloc.eventSink.add(mszobj);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final mszinfo = snapshot.data;
        // print(snapshot.data[0]['text']);
        return ListView.builder(
          shrinkWrap: true,
          reverse: true,
          itemCount: mszinfo.length,
          itemBuilder: (ctx, index) {
            userID = '1';
            if (mszinfo[index]['senderID'] == userID) {
              isMe = true;
            } else {
              isMe = false;
            }
            return
                // Column(
                //   children: [
                Align(
                    alignment: isMe == true
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: mszinfo[index]['category'] == "text"
                        ? TextMessageBubble(mszinfo[index]['text'], isMe,
                            mszinfo[index]['createdAt'])
                        : MediaMessageBubble(
                            mszinfo[index]['text'],
                            isMe,
                            mszinfo[index]['createdAt'],
                            mszinfo[index]['category'],
                            mszinfo[index]['mediaPath']));
            //   index == 0
            //       ? Text('Yooo')
            //       : SizedBox(
            //           height: 0,
            //           width: 0,
            //         )
            // ],
            // );
          },
        );
      },
    );
  }
}
