// ignore_for_file: public_member_api_docs, sort_constructors_first
class BlogEntity {
  final String uid;
  final String posterId;
  final String posterName;
  final String posterImageUrl;
  final String blogTitle;
  final String blogSubTitle;
  final String blogContent;
  final List blogCategories;
  final List imageUrlList;
  final String? date;
  BlogEntity({
    required this.uid,
    required this.posterId,
    required this.posterName,
    required this.posterImageUrl,
    required this.blogTitle,
    required this.blogSubTitle,
    required this.blogContent,
    required this.blogCategories,
    required this.imageUrlList,
    this.date,
  });
}
