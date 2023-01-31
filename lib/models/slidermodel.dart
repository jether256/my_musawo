
class SliderModel {
  final String ID;
  final String title;
  final String uid;
  final String owner;
  final String shop;
  final String image;
  final String paid;
  final String amount;
  final String duration;
  final String date;

  SliderModel({required this.ID, required this.title, required this.uid, required this.owner, required this.shop, required this.image, required this.paid, required this.amount, required this.duration, required this.date});

  factory  SliderModel.fromJson(data) {
    return  SliderModel(
        ID: data['id'],
        title: data['title'],
        uid: data['user_id'],
        owner: data['ownerName'],
        shop: data['shopName'],
        image: data['image'],
        paid: data['paid'],
        amount: data['amount'],
        duration: data['duration'],
        date: data['date']);

  }
}
