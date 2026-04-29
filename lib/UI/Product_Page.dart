import 'package:flutter/material.dart';
import 'package:flutter_application_1/API%20call/API_Service.dart';
import 'package:flutter_application_1/Model/Product.dart';

class ProductPage extends StatefulWidget {
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ApiService api = ApiService();
  late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    products = api.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Product>>(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error loading data"));
          }

          final items = snapshot.data!;

          return GridView.builder(
            padding: EdgeInsets.all(10),

            // 🔥 أهم تعديل هنا
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),

            itemCount: items.length,
            itemBuilder: (context, index) {
              final product = items[index];

              return SizedBox(
                height: 100, // 🔥 بيحدد حجم الكارد
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,

                  child: Column(
                    children: [
                      SizedBox(height: 8),

                      // 🔥 الصورة أصغر دلوقتي
                      SizedBox(
                        height: 500,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: Image.network(
                            product.image,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      SizedBox(height: 8),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          product.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}