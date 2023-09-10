import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:payu_checkoutpro_flutter/payu_checkoutpro_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shop_ecomerce/ui/cartScreen/cartScreen.dart';
import 'package:shop_ecomerce/utils/networkClass/NetworkResponse.dart';
import 'package:shop_ecomerce/utils/paymentGateWay/payuClasses/commonPayu.dart';

import '../utils/networkClass/DioNetworkClass.dart';
import '../utils/networkClass/WebUrl.dart';

class MyController extends GetxController implements NetworkResponse {
  List<ProductModel> categoryList = [];
  var isLoading = true.obs;
  var isProductDetail = true.obs;
  late ProductModel productDetailModel;
  var quantityCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    callGetProduct();
  }

  void callAddToCart(String id, String quantity) {
    Map<String, dynamic> map = {
      "userId": '1',
      "products": [
        {
          'id': id,
          'quantity': quantity,
        },
      ]
    };

    DioNetworkClass.fromNetworkClass(
            endUrl: addCart,
            networkResponse: this,
            requestCode: reqAddCart,
            jsonBody: map)
        .callRequestServiceHeader(true, "post");
  }

  void callGetProduct() {
    DioNetworkClass.fromNetworkClass(
        endUrl: productUrl,
        networkResponse: this,
        requestCode: productReq,
        jsonBody: {}).callRequestServiceHeader(false, "get");
  }

  void callGetProductDetail(String value) {
    DioNetworkClass.fromNetworkClass(
        endUrl: "$productUrl$value",
        networkResponse: this,
        requestCode: productDetailReq,
        jsonBody: {}).callRequestServiceHeader(false, "get");
  }

  @override
  void onApiError({required int requestCode, required String response}) {
    switch (requestCode) {
      case productReq:
        var data = jsonDecode(response);
        debugPrint('productReq-error:- $data');
        break;

      case reqAddCart:
        var data = jsonDecode(response);
        debugPrint('reqAddCart-error:- $data');
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
        update();
        break;

      case productDetailReq:
        var data = jsonDecode(response);
        debugPrint('productDetailReq-success:- $data');
        productDetailModel = ProductModel.fromJson(data);
        debugPrint(productDetailModel.toString());
        isProductDetail(false);
        update();
        break;

      case reqAddCart:
        var data = jsonDecode(response);
        debugPrint('reqAddCart-success:- $data');
        Get.snackbar('Shop Ecom', "Product Added Successfully");
        Get.to(CartScreen());
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

class ShowCartController extends GetxController
    implements NetworkResponse, PayUCheckoutProProtocol {
  List<ProductModel> showCartList = [];
  var isLoading = true.obs;
  late PayUCheckoutProFlutter checkoutPro;
  Razorpay razorpay = Razorpay();

  @override
  void onInit() {
    super.onInit();
    debugPrint(runtimeType.toString());
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callShowCart('1');
    });
    checkoutPro = PayUCheckoutProFlutter(this);
  }

  callShowCart(String id) {
    DioNetworkClass.fromNetworkClass(
        endUrl: showCart + id,
        networkResponse: this,
        requestCode: reqShowCart,
        jsonBody: {}).callRequestServiceHeader(true, "get");
  }

  @override
  void onApiError({required int requestCode, required String response}) {
    switch (requestCode) {
      case reqShowCart:
        var data = jsonDecode(response);
        debugPrint('reqShowCart-error:- $data');
        Get.snackbar('Shop Ecom', data['message'].toString());
        break;
    }
  }

  @override
  void onResponse({required int requestCode, required String response}) {
    switch (requestCode) {
      case reqShowCart:
        var data = jsonDecode(response);
        debugPrint('reqShowCart-success:- $data');
        var dataModel = data['products'] as List;
        showCartList = dataModel.map((e) => ProductModel.fromJson(e)).toList();
        isLoading(false);
        update();
        break;
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    debugPrint("success- :$response");

    Get.snackbar("Razorpay", response.toString());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint("error- :$response");

    Get.snackbar("Razorpay", response.toString());
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint("_handleExternalWallet- :$response");

    Get.snackbar("Razorpay", response.toString());
  }

  @override
  generateHash(Map<dynamic, dynamic> response) {
    Map hashResponse = {};

    hashResponse = HashService.generateHash(response);
    debugPrint("hashResponse--:$hashResponse");
    checkoutPro.hashGenerated(hash: hashResponse);
  }

  @override
  onError(Map<dynamic, dynamic>? response) {
    debugPrint("onPaymentFailure- :$response");

    Get.snackbar("Payu", 'your transaction is successfully cancelled');
  }

  @override
  onPaymentCancel(Map<dynamic, dynamic>? response) {
    debugPrint("onPaymentFailure- :$response");

    Get.snackbar("Payu", 'your transaction is successfully cancelled');
  }

  @override
  onPaymentFailure(response) {
    debugPrint("onPaymentFailure- :$response");

    Get.snackbar("Payu", 'your transaction is successfully cancelled');
  }

  @override
  onPaymentSuccess(response) {
    debugPrint("onPaymentFailure- :$response");

    Get.snackbar("Payu", 'your transaction is successfully');
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
  List<String> imagesList = [];
  bool isSelected = false;
  String? cartTotal;
  String? cartQuantity;

  ProductModel(
      {required this.title,
      this.cartTotal = '0',
      this.cartQuantity = '0',
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
    List<String> imageListTem = [];

    if (json["images"] != null) {
      var dataModal = json["images"] as List;
      for (var element in dataModal) {
        imageListTem.add(element.toString());
      }
    }

    return ProductModel(
      cartQuantity: json['quantity'].toString(),
      cartTotal: json['total'].toString(),
      title: json['title'].toString(),
      image: json['thumbnail'].toString(),
      description: json['description'].toString(),
      taxNo: json['price'].toString(),
      isSelected: false,
      price: json['price'].toString(),
      category: json['category'].toString(),
      brand: json['brand'].toString(),
      imagesList: imageListTem,
      discountPercentage: json['discountPercentage'].toString(),
      rating: json['rating'].toString(),
      stock: json['stock'].toString(),
      id: json['id'].toString(),
    );
  }
}
