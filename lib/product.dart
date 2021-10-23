import 'package:http/http.dart' as http;
import 'dart:convert';


List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  Rating rating;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    price: json["price"].toDouble(),
    description: json["description"],
    category: json["category"],
    image: json["image"],
    rating: Rating.fromJson(json["rating"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    "category": category,
    "image": image,
    "rating": rating.toJson(),
  };

  static Future<List<Product>> fetchdata() async {
    String url="https://fakestoreapi.com/products";
    var client = http.Client();
    var response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print('Tai du lieu thanh cong');
      var result = response.body;
      var jsonData = jsonDecode(result);
      print(jsonData.runtimeType);
      print(jsonData[0].runtimeType);
      List<Product> products = productFromJson(response.body);
      for (var item in jsonData) {
        var id = item['id'];
        var title = item['title'];
        var url = item['image'];
        var price = item['price'];
        var description = item['description'];
        var category = item['category'];
        var rating = item['rating'];
    //Product  p = new Product(id: id, title: title, price: price, description: description, category: category, image: url, rating: rating);
        //ls.add(p);
      }
      return products;
    }
    else {
      print('tai du lieu that bai');
      throw Exception("Loi lay du lieu: ${response.statusCode}");

    }
  }
  }

class Rating {
  Rating({
    required this.rate,
    required this.count,
  });

  double rate;
  int count;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    rate: json["rate"].toDouble(),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "rate": rate,
    "count": count,
  };
}

/*
class product{
  // "id":1,
  // "title":"Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
  // "price":109.95,
  // "description":"Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
  // "category":"men's clothing",
  // "image":"https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
  // "rating":
  // {"rate":3.9,
  // "count":120}
 // },

  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Rating rating;

 product(this.id, this.title, this.price,this.description,this.category,this.image);
static Future<List<product>> fetchdata() async{
String url="https://fakestoreapi.com/products";
var client = http.Client();
var response = await client.get(Uri.parse(url));
if(response.statusCode == 200){
print('Tai du lieu thanh cong');
var result = response.body;
var jsonData= jsonDecode(result);
print(jsonData.runtimeType);
print(jsonData[0].runtimeType);
List<product> ls = [];
for(var item in jsonData){
var id = item['id'];
var title = item['title'];
var url = item['image'];
var price = item['price'];
var description =item['description'];
var category = item['category'];
//var rating = item['rating'];
product p = new product(id, title, price , description, category, url);
ls.add(p);
}
return ls;
}
else {
  print('tai du lieu that bai');
  throw Exception("Loi lay du lieu: ${response.statusCode}");
}
}
}
class Rating {
  Rating({
    this.rate,
    this.count,
  });

  final double rate;
  final int count;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    rate: json["rate"].toDouble(),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "rate": rate,
    "count": count,
  }; */