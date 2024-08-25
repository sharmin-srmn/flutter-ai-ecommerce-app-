class CartItemModel {
  String productId;
  String title;
  double price;
  String? image;
  int quantity;
  String? brandName;

  //CONSTRUCTOR
  CartItemModel({
    required this.productId,
    required this.quantity,
    this.image,
    this.price = 0.0,
    this.title = '',
    this.brandName,
  });

  static CartItemModel empty() => CartItemModel(productId: '', quantity: 0);

  //CONVERTING A CARTITEM TO A JSON MAP
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
      'brandName': brandName,
    };
  }

  //CREATE A CARTITEM FROM A JSON MAP
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'],
      title: json['title'],
      price: json['price']?.toDouble(),
      image: json['image'],
      quantity: json['quantity'],
      brandName: json['brandName'],
    );
  }
}
