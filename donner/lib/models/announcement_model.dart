import 'dart:convert';

class AnnouncementModel {
  String? id;
  String? title;
  String? owner;
  String? images;
  String? categoryId;
  String? description;
  bool? isDonation;
  AnnouncementModel({
    this.categoryId,
    this.description,
    this.id,
    this.isDonation,
    this.owner,
    this.title,
    this.images,
  });
  AnnouncementModel copyWith({
    String? categoryId,
    String? description,
    String? id,
    bool? isDonation,
    String? owner,
    String? title,
    String? images,
  }) {
    return AnnouncementModel(
      categoryId: categoryId ?? this.categoryId,
      description: description ?? this.description,
      id: id ?? this.id,
      isDonation: isDonation ?? this.isDonation,
      owner: owner ?? this.owner,
      title: title ?? this.title,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'description': description,
      'id': id,
      'isDonation': isDonation,
      'owner': owner,
      'title': title,
      'images': images,
    };
  }

  factory AnnouncementModel.fromMap(Map<String, dynamic> map) {
    return AnnouncementModel(
      categoryId: map['categoryId'],
      description: map['description'],
      id: map['id'],
      isDonation: map['isDonation'],
      owner: map['owner'],
      title: map['title'],
      images: map['images'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AnnouncementModel.fromJson(String source) =>
      AnnouncementModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AnnouncementModel(categoryId: $categoryId, description: $description, id: $id, isDonation: $isDonation, owner: $owner, title: $title, images: $images)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AnnouncementModel &&
        other.categoryId == categoryId &&
        other.description == description &&
        other.id == id &&
        other.isDonation == isDonation &&
        other.owner == owner &&
        other.title == title &&
        other.images == images;
  }

  @override
  int get hashCode {
    return categoryId.hashCode ^
        description.hashCode ^
        id.hashCode ^
        isDonation.hashCode ^
        owner.hashCode ^
        title.hashCode ^
        images.hashCode;
  }
}
