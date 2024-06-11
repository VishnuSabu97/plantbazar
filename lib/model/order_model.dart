class OrderModel {
  String? id;
  String? status;
  String? productName;
  String? quantity;
  String? totalPrice;
  String? description;
  String? category;
  String? imageUrl;
  String? orderId;
  String? date;
  OrderModel({
    this.id,
    this.status,
    this.productName,
    this.quantity,
    this.totalPrice,
    this.category,
    this.description,
    this.imageUrl,
    this.orderId,
    this.date,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    productName = json['productName'];
    quantity = json['quantity'];
    totalPrice = json['totalPrice'];
    category = json['category'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    orderId = json['orderId'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['productName'] = productName;
    data['quantity'] = quantity;
    data['totalPrice'] = totalPrice;
    data['category'] = category;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    data['orderId'] = orderId;
    data['date'] = date;
    return data;
  }
}
