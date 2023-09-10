import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getObj;
import 'package:mime/mime.dart';
import 'package:shop_ecomerce/utils/common.dart';
import '../../main.dart';
import '../commonThings.dart';
import 'NetworkResponse.dart';
import 'WebUrl.dart';

class DioNetworkClass {
  var dio = Dio();
  String endUrl = "";
  String filePath = "";
  String param = "";
  List<String> imageArray = [];
  late NetworkResponse networkResponse;
  Map<String, dynamic> jsonBody = {};
  late StateSetter stateSetter;
  AlertDialog? alertDialog;
  int requestCode = 0;
  bool isShowing = false;
  double progress = 0;

  DioNetworkClass(
      {required this.endUrl,
      required this.networkResponse,
      required this.requestCode});

  DioNetworkClass.fromNetworkClass(
      {required this.endUrl,
      required this.networkResponse,
      required this.requestCode,
      required this.jsonBody});

  Future<void> callRequestServiceHeader(
    bool showLoader,
    String requestType,
  ) async {
    try {
      if (showLoader && alertDialog == null && !isShowing) {
        isShowing = true;
        showLoaderDialog();
      }

      var fromData = FormData.fromMap(jsonBody);

      Options options = Options(method: requestType.toUpperCase());
      dio.options.connectTimeout = const Duration(seconds: 90);
      options.sendTimeout = const Duration(seconds: 90); //5s
      dio.options.receiveTimeout = const Duration(seconds: 90);
      dio.options.contentType = Headers.jsonContentType;

      debugPrint("${requestType}Url: ${baseUrl + endUrl}");

      if (requestType == "get" && jsonBody.isNotEmpty) {
        dio.options.queryParameters = jsonBody;
        debugPrint(
            "${requestType}Query Parameters: ${dio.options.queryParameters}");
      } else {
        debugPrint("${requestType}Map: $jsonBody");
      }

      late Response response;

      if (imageArray.isNotEmpty || filePath.isNotEmpty) {
        response = await dio.request(
          baseUrl + endUrl,
          data: fromData,
          options: options,
        );
      } else {
        response = await dio.request(baseUrl + endUrl,
            data: jsonBody.isNotEmpty ? jsonBody : {}, options: options);
      }

      debugPrint("ResultBody=========>: ${response.data.toString()}");

      if (alertDialog != null && isShowing) {
        isShowing = false;

        getObj.Get.back();
      }

      if (response.statusCode! <= 201) {
        networkResponse.onResponse(
            requestCode: requestCode, response: jsonEncode(response.data));
      }
    } on DioException catch (e) {
      if (alertDialog != null && isShowing) {
        isShowing = false;
        getObj.Get.back();
      }

      debugPrint("Error Type:- ${e.type}");
      if (e.error is SocketException) {
        commonSocketException((e.error as SocketException).osError!.errorCode,
            (e.error as SocketException).message);
      } else if (e.type == DioExceptionType.badResponse) {
        networkResponse.onApiError(
            requestCode: requestCode, response: jsonEncode(e.response!.data));
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        getObj.Get.defaultDialog(
            title: "Server Error", middleText: "Connection Time Out");
      }
    } catch (err) {
      if (alertDialog != null && isShowing) {
        debugPrint("SocketException");

        isShowing = false;
        getObj.Get.back();
      }
      debugPrint('Error While Making network call -> $err');
    }
  }

  showLoaderDialog() async {
    if (alertDialog != null && isShowing) {
      isShowing = false;
    }
    alertDialog = AlertDialog(
      elevation: 0,
      backgroundColor: Colors.white.withOpacity(0),
      content: const Center(
        child: CircularProgressIndicator(
          color: colorTheme,
        ),
      ),
    );
    await getObj.Get.defaultDialog(title: "Shop Eco");
  }

  Future<void> showPercentageLoaderDialog(
      BuildContext context, String title) async {
    if (alertDialog != null && isShowing) {
      isShowing = false;
      Navigator.pop(context);
    }
    alertDialog = AlertDialog(
      elevation: 0,
      backgroundColor: Colors.white.withOpacity(0),
      content: StatefulBuilder(builder: (context, stateSetters) {
        stateSetter = stateSetters;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(colorTheme)),
                /*CustomLoader(
                  radius: 20,
                  dotRadius: 8.0,
                  )*/
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text("$title ${(progress * 100).toInt()} %"),
            )
          ],
        );
      }),
    );
    await showDialog(
      barrierDismissible: false,
      barrierColor: Colors.white.withOpacity(0),
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () => Future.value(false), child: alertDialog!);
      },
    );
  }

  void commonSocketException(int errorCode, String errorMessage) {
    switch (errorCode) {
      case 7:
        debugPrint("Internet Connection Error");
        getObj.Get.snackbar("Error", "Internet Connection Error");

        break;

      case 8:
        debugPrint("Internet Connection Error");
        getObj.Get.snackbar("Error", "Internet Connection Error");

        break;

      case 111:
        debugPrint("Unable to connect Server");
        getObj.Get.snackbar("Error", "Unable to connect to Server");

        break;

      default:
        debugPrint("Unknown Error :$errorMessage");
        getObj.Get.snackbar("Server Error", "Unknown Error :$errorMessage");
    }
  }
}
