class Announcement {
  String title = "";
  String content = "";
  String voice = "";
  Announcement();
  Announcement.fromJson(Map<String, dynamic> mp) {
    title = mp['title'];
    content = mp['content'];
    voice = mp['voice'];
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        "content": content,
        "voice": voice,
      };
}
