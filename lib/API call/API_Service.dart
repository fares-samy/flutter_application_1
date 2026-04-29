import 'package:dio/dio.dart';
import 'package:flutter_application_1/Model/Product.dart';

class ApiService {
  final Dio dio = Dio();

  Future<List<Product>> getProducts() async {
    final response =
        await dio.get("https://fakestoreapi.com/products");

    List data = response.data;

    return data.map((e) => Product.fromJson(e)).toList();
  }
}