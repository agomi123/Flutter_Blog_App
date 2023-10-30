class Blog {
  
  String? id;
  String? title;
  String? image_url;

  Blog({this.id, this.title, this.image_url});

  Blog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image_url = json['image_url'];
  }
}