import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_ecomerce/UI/searchScreen/searchScreen.dart';

import '../../controller/controllerLogic.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({super.key});

  final detailCon = Get.put(DetailController);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(body: productWidget(size));
  }

  Widget productWidget(size) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          pinned: true,
          floating: false,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.black,
                  size: size.width * 0.05,
                )),
          ),
          leadingWidth: size.width * 0.14,
          title: Text(
            "Product Details",
            style: TextStyle(
                color: Colors.black,
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            InkWell(
              onTap: () {
                Get.to(SearchScreen());
              },
              child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Icon(Icons.search,
                      size: size.width * 0.07, color: Colors.black)),
            )
          ],
        ),
        Obx(() {
          /*if (detailCon.isLoading.value) {
            return CircularProgressIndicator();
          }*/
          return SliverList(
              delegate: SliverChildListDelegate([
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: size.height / 1.8,
                        child: PageView.builder(
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Image.network(
                                '',
                                fit: BoxFit.contain,
                                height: 100,
                                width: 100,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    "assets/image_Place_Holder.png",
                                    fit: BoxFit.contain,
                                    height: 100,
                                  );
                                },
                              );
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ]));
        })
      ],
    );
  }
}
