
class CategoryModel {
  final String ID;
  final String category;
  final String image;
  final String status;

  CategoryModel({required this.ID, required this.category, required this.image, required this.status});




  // factory  CategoryModel.fromJson(data) {
  //   return  CategoryModel(
  //       ID: data['ID'],
  //       category: data['category'],
  //       image: data['image'],
  //       status: data['ono']);
  // }


  factory  CategoryModel.fromJson(data) {
    return  CategoryModel(
        ID: data['ID'],
        category: data['category'],
        image: data['image'],
        status: data['ono']);
  }


}
