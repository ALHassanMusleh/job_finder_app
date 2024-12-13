import 'package:flutter/material.dart';
import 'package:job_finder_app/utils/app_styles.dart';

class ChatsTab extends StatelessWidget {
  const ChatsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildChatsTitle(),
        buildChatCard(),
      ],
    );
  }

  Expanded buildChatCard() {
    return Expanded(
      child: ListView.separated(
          separatorBuilder: (context, i) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(),
            );
          },
          itemCount: 5,
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) {
                //   return ChatPage();
                // }));
              },
              child: ListTile(
                leading: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFFF9F9FA),
                      width: 1,
                    ),
                  ),
                  child: Image.asset(
                    'assets/images/businessman.png',
                    height: 60,
                    width: 60,
                  ),
                ),
                title: Text(
                  'Hassan mu ',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.titlesJobTextStyle.copyWith(fontSize: 16),
                ),
                subtitle: Text(
                  'Last seen yesterday',
                  style: AppStyle.labelStyle.copyWith(fontSize: 14),
                ),
              ),
            );
          }),
    );
  }

  Padding buildChatsTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Chats', style: AppStyle.titlesTextStyle),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
