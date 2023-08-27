import 'package:flutter/material.dart';

class ProductCategoryScreen extends StatelessWidget {
  const ProductCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: categoryWidget(size),
    );
  }
  Widget categoryWidget(size){
    return Container(

    );
  }
}
