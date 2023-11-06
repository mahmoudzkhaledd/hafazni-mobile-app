import 'Announcement.dart';

class Group {
  String id = "";
  String name = "";
  List<String> users = [];
  String groupChat = "";
  bool suspended = false;
  List<String> programs = [];
  List<Announcement> announcements = [];
  DateTime startedAt = DateTime.now();
  Group();

  Group.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    users = json['users'];
    groupChat = json['groupChat'];
    suspended = json['suspended'];
    programs = json['programs'];
    startedAt = DateTime.parse(json['startedAt'].toString());
    json['announcements'].forEach((e) {
      announcements.add(Announcement.fromJson(e));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['users'] = users;
    data['name'] = name;
    data['groupChat'] = groupChat;
    data['suspended'] = suspended;
    data['programs'] = programs;
    data['startedAt'] = startedAt;
    data['announcements'] = announcements.map((v) => v.toJson()).toList();
    return data;
  }
}
