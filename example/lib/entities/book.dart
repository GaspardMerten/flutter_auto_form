class Book {
  Book({required this.title, required this.pages});

  final String title;
  final List<Page> pages;

  @override
  String toString() => title;
}

class Page {
  Page({required this.content, required this.number});

  final String content;
  final int number;
}
