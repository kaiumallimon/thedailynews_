// ignore_for_file: non_constant_identifier_names

class NewsCategoryResponse {
  final String status;
  final int total_categories;
  final List<NewsCategoryModel> categories;

  NewsCategoryResponse({
    required this.categories,
    required this.status,
    required this.total_categories,
  });

  factory NewsCategoryResponse.fromJson(Map<String, dynamic> json) {
    var list = json['categories'] as List;
    List<NewsCategoryModel> categoriesList = list
        .map((i) => NewsCategoryModel.fromJson(i))
        .toList();
    String status = json['status'] as String? ?? 'ok';
    int total_categories = json['total_categories'] as int? ?? 0;

    return NewsCategoryResponse(
      categories: categoriesList,
      status: status,
      total_categories: total_categories,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'total_categories': total_categories,
      'categories': categories.map((e) => e.toJson()).toList(),
    };
  }
}

class NewsCategoryModel {
  final int id;
  final String name;
  final String image;

  NewsCategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory NewsCategoryModel.fromJson(Map<String, dynamic> json) {
    return NewsCategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'image': image};
  }
}
