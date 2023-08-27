import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shop_ecomerce/utils/networkClass/NetworkResponse.dart';

import '../utils/networkClass/DioNetworkClass.dart';
import '../utils/networkClass/WebUrl.dart';

class MyController extends GetxController implements NetworkResponse {
  List<ProductModel> categoryList = [];
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    callGetProduct();
  }

  void callGetProduct() {
    DioNetworkClass.fromNetworkClass(
        endUrl: productUrl,
        networkResponse: this,
        requestCode: productReq,
        jsonBody: {}).callRequestServiceHeader(false, "get");
  }

  @override
  void onApiError({required int requestCode, required String response}) {
    switch (requestCode) {
      case productReq:
        var data = jsonDecode(response);
        debugPrint('productReq-error:- $data');
        break;
    }
  }

  @override
  void onResponse({required int requestCode, required String response}) {
    switch (requestCode) {
      case productReq:
        var data = jsonDecode(response);
        debugPrint('productReq-success:- $data');
        var dataModel = data['products'] as List;
        categoryList = dataModel.map((e) => ProductModel.fromJson(e)).toList();
        debugPrint(categoryList.length.toString());
        isLoading(true);
        update();
        break;
    }
  }
}

class DetailController extends GetxController implements NetworkResponse {
  late ProductModel productDetailModel;
  var isLoading = false.obs;

  void callGetProductDetail(String value) {
    DioNetworkClass.fromNetworkClass(
        endUrl: productUrl + value,
        networkResponse: this,
        requestCode: productDetailReq,
        jsonBody: {}).callRequestServiceHeader(false, "get");
  }

  @override
  void onApiError({required int requestCode, required String response}) {
    switch (requestCode) {
      case productDetailReq:
        var data = jsonDecode(response);
        debugPrint('productDetailReq-error:- $data');
        Get.snackbar('Shop Ecom', data['message'].toString());
        break;
    }
  }

  @override
  void onResponse({required int requestCode, required String response}) {
    switch (requestCode) {
      case productDetailReq:
        var data = jsonDecode(response);
        debugPrint('productDetailReq-success:- $data');
        productDetailModel = ProductModel.fromJson(data);
        debugPrint(productDetailModel.toString());
        isLoading(true);
        update();
        break;
    }
  }
}

class SearchCon extends GetxController implements NetworkResponse {
  var isLoading = true.obs;
  final searchController = TextEditingController().obs;
  List searchCategoryList = <ProductModel>[].obs;

  void callGetProductSearch(String value) {
    DioNetworkClass.fromNetworkClass(
        endUrl: productSearchUrl + value,
        networkResponse: this,
        requestCode: productSearchReq,
        jsonBody: {}).callRequestServiceHeader(false, "get");
  }

  @override
  void onApiError({required int requestCode, required String response}) {
    switch (requestCode) {
      case productSearchReq:
        var data = jsonDecode(response);
        debugPrint('productSearchReq-error:- $data');
        Get.snackbar('Shop Ecom', data['message'].toString());
        break;
    }
  }

  @override
  void onResponse({required int requestCode, required String response}) {
    switch (requestCode) {
      case productSearchReq:
        var data = jsonDecode(response);
        var dataModel = data['products'] as List;
        var newList = dataModel.map((e) => ProductModel.fromJson(e)).toList();
        debugPrint(newList.length.toString());
        searchCategoryList.assignAll(newList);

        break;
    }
  }
}

class ProductModel {
  String? id;
  String? title;
  String? image;
  String? description;
  String? taxNo;
  String? price;
  String? discountPercentage;
  String? rating;
  String? stock;
  String? brand;
  String? category;
  List? imagesList;
  bool isSelected = false;

  ProductModel(
      {required this.title,
      required this.id,
      required this.image,
      required this.description,
      required this.isSelected,
      required this.price,
      required this.category,
      required this.brand,
      required this.imagesList,
      required this.discountPercentage,
      required this.rating,
      required this.stock,
      required this.taxNo});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      title: json['title'].toString(),
      image: json['thumbnail'].toString(),
      description: json['description'].toString(),
      taxNo: json['price'].toString(),
      isSelected: false,
      price: json['price'].toString(),
      category: json['category'].toString(),
      brand: json['brand'].toString(),
      imagesList: [],
      discountPercentage: json['discountPercentage'].toString(),
      rating: json['rating'].toString(),
      stock: json['stock'].toString(),
      id: json['id'].toString(),
    );
  }
}
