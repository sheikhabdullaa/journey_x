// import 'package:flutter/material.dart';

class Favorite  {

  List<Map<String, dynamic>> shoesdetails = [
    {'Name': 'Nike', 'price': '\$500', 'isFavorite': false,'image':'assets/image1.png'},
    {'Name': 'Adidas', 'price': '\$300', 'isFavorite': false,'image':'assets/image2.png'},
    {'Name': 'jordan', 'price': '\$200', 'isFavorite': false,'image':'assets/image3.png'},
    {'Name': 'ABS', 'price': '\$400', 'isFavorite': false,'image':'assets/image1.png'},
    {'Name': 'ANV', 'price': '\$500', 'isFavorite': false,'image':'assets/image2.png'},
    {'Name': 'BORJAN', 'price': '\$600', 'isFavorite': false,'image':'assets/image3.png'},
  ];

  // void toggle(Map<String, dynamic> shoe) {
  //   final index = shoesdetails.indexOf(shoe);
  //   if (index == -1) return;
  //   shoesdetails[index]['isFavorite'] =
  //       !(shoesdetails[index]['isFavorite'] as bool);

  //   if (shoesdetails[index]['isFavorite'] == true) {
  //     favoriteShoes.add(shoesdetails[index]);
  //   } else {
  //     favoriteShoes.remove(shoesdetails[index]);
  //   }
  //   notifyListeners();
  // }
}
