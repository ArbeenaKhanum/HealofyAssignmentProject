class ContentModel {
  final String type;
  final Map<String, dynamic> item;

  ContentModel({required this.type, required this.item});

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(
      type: json['type'],
      item: Map<String, dynamic>.from(json['item']),
    );
  }
}
