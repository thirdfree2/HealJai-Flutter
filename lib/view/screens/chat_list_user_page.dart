import 'package:flutter/material.dart';

class ChatListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายการแชท'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/doctor2.jpg'), // รูปโปรไฟล์ผู้ใช้งาน 1
            ),
            title: Text('ชื่อผู้ใช้งาน 1'),
            subtitle: Text('ข้อความล่าสุด: สวัสดีครับ'),
            onTap: () {
              // กระทำเมื่อแถวรายการถูกคลิก
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatPage(user: 'ชื่อผู้ใช้งาน 1')),
              );
            },
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/doctor2.jpg'), // รูปโปรไฟล์ผู้ใช้งาน 2
            ),
            title: Text('ชื่อผู้ใช้งาน 2'),
            subtitle: Text('ข้อความล่าสุด: ยินดีที่ได้รู้จักครับ'),
            onTap: () {
              // กระทำเมื่อแถวรายการถูกคลิก
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatPage(user: 'ชื่อผู้ใช้งาน 2')),
              );
            },
          ),
          // เพิ่มรายการแชทเพิ่มเติมตามความต้องการของคุณ
        ],
      ),
    );
  }
}

class ChatPage extends StatelessWidget {
  final String user;

  ChatPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แชทกับ $user'),
      ),
      body: Center(
        child: Text('เนื้อหาแชทกับ $user จะปรากฏที่นี่'),
      ),
    );
  }
}