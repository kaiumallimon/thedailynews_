class BreakingNewsModel {
  final String status;
  final BreakingNewsData data;

  BreakingNewsModel({required this.status, required this.data});

  factory BreakingNewsModel.fromJson(Map<String, dynamic> json) {
    return BreakingNewsModel(
      status: json['status'] as String,
      data: BreakingNewsData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'data': data.toJson()};
  }
}

class BreakingNewsData {
  final List<Headline> headlines;
  final Map<String, List<Headline>> categories;

  BreakingNewsData({required this.headlines, required this.categories});

  factory BreakingNewsData.fromJson(Map<String, dynamic> json) {
    return BreakingNewsData(
      headlines: (json['headlines'] as List)
          .map((e) => Headline.fromJson(e as Map<String, dynamic>))
          .toList(),
      categories: (json['categories'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          key,
          (value as List)
              .map((e) => Headline.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'headlines': headlines.map((e) => e.toJson()).toList(),
      'categories': categories.map(
        (key, value) => MapEntry(key, value.map((e) => e.toJson()).toList()),
      ),
    };
  }
}

class Headline {
  final String title;
  final String link;
  final String intro;
  final String? image;
  final String type;

  Headline({
    required this.title,
    required this.link,
    required this.intro,
    this.image,
    required this.type,
  });

  factory Headline.fromJson(Map<String, dynamic> json) {
    return Headline(
      title: json['title'] as String,
      link: json['link'] as String,
      intro: json['intro'] as String,
      image: json['image'] as String?,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'link': link,
      'intro': intro,
      'image': image,
      'type': type,
    };
  }
}
