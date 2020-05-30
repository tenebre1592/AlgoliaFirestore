class Record {
  Record({this.title, this.body});

  String title;
  String body;

  Record.fromMap(Map<String, dynamic> map) {
    title = map['title'];
    body = map['body'];
  }

  Record.fromHighlightResult(Map<String, dynamic> map) {
    title = map['title']['value'];
    body = map['body']['value'];
  }

  Map<String, dynamic> get toMap => {'title': title, 'body': body};

  @override
  String toString() => 'title: $title, body: $body';
}
