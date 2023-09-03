import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shop_ecomerce/utils/networkClass/NetworkResponse.dart';

import '../utils/networkClass/DioNetworkClass.dart';
import '../utils/networkClass/WebUrl.dart';

class MyController extends GetxController implements NetworkResponse {
  List<ProductModel> categoryList = [];
  var isLoading = true.obs;

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
        isLoading(false);

        break;
    }
  }
}

class DetailController extends GetxController implements NetworkResponse {
  late ProductModel productDetailModel;
  var isLoading = true.obs;

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
        isLoading(false);
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

class CategoryController extends GetxController implements NetworkResponse {
  var isLoading = true.obs;
  List categoryList = <String>[].obs;
  List<ProductModel> categoryByNameList = [];
  var showData = false.obs;

  @override
  void onInit() {
    callGetCategory();
    super.onInit();
  }

  void callGetCategory() {
    DioNetworkClass.fromNetworkClass(
        endUrl: productCategoryUrl,
        networkResponse: this,
        requestCode: productCategoryReq,
        jsonBody: {}).callRequestServiceHeader(false, "get");
  }

  void callGetCategoryByName(String value) {
    DioNetworkClass.fromNetworkClass(
        endUrl: productCategoryByName + value,
        networkResponse: this,
        requestCode: productCategoryByNameReq,
        jsonBody: {}).callRequestServiceHeader(false, "get");
  }

  @override
  void onApiError({required int requestCode, required String response}) {
    switch (requestCode) {
      case productCategoryReq:
        var data = jsonDecode(response);
        debugPrint('productCategoryReq-error:- $data');
        Get.snackbar('Shop Ecom', data['message'].toString());
        break;
      case productCategoryByNameReq:
        var data = jsonDecode(response);
        debugPrint('productCategoryReq-error:- $data');
        Get.snackbar('Shop Ecom', data['message'].toString());
        break;
    }
  }

  @override
  void onResponse({required int requestCode, required String response}) {
    switch (requestCode) {
      case productCategoryReq:
        var data = jsonDecode(response);
        var dataModal = data as List;
        // var newList = dataModel.map((e) => ProductModel.fromJson(e)).toList();
        debugPrint(data.length.toString());
        for (var e in dataModal) {
          debugPrint(e.toString());
          categoryList.add(e.toString());
        }
        isLoading(false);
        break;

      case productCategoryByNameReq:
        var data = jsonDecode(response);
        debugPrint('productCategoryByNameReq-success:- $data');
        var dataModel = data['products'] as List;
        categoryByNameList.clear();
        var categoryByName =
            dataModel.map((e) => ProductModel.fromJson(e)).toList();
        debugPrint(categoryByNameList.length.toString());
        categoryByNameList.assignAll(categoryByName);
        showData(true);
        update();
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
