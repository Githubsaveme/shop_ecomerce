import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shop_ecomerce/UI/searchScreen/searchScreen.dart';
import 'package:shop_ecomerce/utils/common.dart';
import 'package:shop_ecomerce/utils/commonThings.dart';

import '../../controller/controllerLogic.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({super.key});

  final detailCon = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
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
        bottomNavigationBar: SizedBox(
          height: 50,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: colorTheme),
              onPressed: () {
                detailCon.callAddToCart(detailCon.productDetailModel.id!,
                    detailCon.quantityCount.toString());
              },
              child: const Text("Add to Cart")),
        ),
        body: SingleChildScrollView(child: productWidget(size)));
  }

  Widget productWidget(size) {
    return Obx(() {
      if (detailCon.isProductDetail.value == true) {
        return showLoader();
      } else {
        return Column(
          children: [
            Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                      onPageChanged: (index, value) {
                        debugPrint("CarouselOptions:-${value.toString()}");
                      },
                      viewportFraction: 1,
                      autoPlayCurve: Curves.easeInCubic,
                      autoPlay: true,
                      aspectRatio: 2),
                  items: detailCon.productDetailModel.imagesList.map((index) {
                    return Builder(
                      builder: (BuildContext context) {
                        return CachedNetworkImage(
                          placeholder: (context, url) => Image.asset(
                              "assets/images/image_placeholder.png",
                              height: size.height / 3,
                              fit: BoxFit.cover,
                              width: double.infinity),
                          errorWidget: (context, url, error) => Image.asset(
                              "assets/images/image_placeholder.png",
                              height: size.height / 1,
                              fit: BoxFit.cover,
                              width: double.infinity),
                          imageUrl:
                              detailCon.productDetailModel.imagesList.first,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.width * 0.02),
                    Text(detailCon.productDetailModel.title!,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: size.width * 0.04)),
                    SizedBox(height: size.width * 0.02),
                    Row(
                      children: [
                        Text(
                            "$rupeeSymbol ${detailCon.productDetailModel.discountPercentage!}",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: size.width * 0.035)),
                        SizedBox(width: size.width * .02),
                        Text(
                            "$rupeeSymbol ${detailCon.productDetailModel.price!}",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                                fontSize: size.width * 0.03)),
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                      endIndent: 2,
                      indent: 2,
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              detailCon.quantityCount++;
                            },
                            icon: const Icon(Icons.add)),
                        IconButton(
                            onPressed: () {
                              detailCon.quantityCount--;
                            },
                            icon: const Icon(Icons.remove)),
                        Text(detailCon.quantityCount.toString())
                      ],
                    ),
                    SizedBox(
                      height: 300,
                      child: DefaultTabController(
                          length: 4,
                          child: Scaffold(
                            appBar: AppBar(
                              actions: [
                                RatingBarIndicator(
                                    rating: double.parse(
                                        detailCon.productDetailModel.rating!),
                                    itemCount: 5,
                                    itemSize: 30.0,
                                    itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        ))
                              ],
                              automaticallyImplyLeading: false,
                              backgroundColor: Colors.redAccent,
                              elevation: 10,
                              bottom: TabBar(
                                  labelColor: Colors.redAccent,
                                  unselectedLabelColor: Colors.white,
                                  indicatorSize: TabBarIndicatorSize.label,
                                  labelStyle:
                                      TextStyle(fontSize: size.width * 0.025),
                                  indicator: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      color: Colors.white),
                                  tabs: const [
                                    Tab(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text("DESCRIPTION"),
                                      ),
                                    ),
                                    Tab(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text("STOCK"),
                                      ),
                                    ),
                                    Tab(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text("BRAND"),
                                      ),
                                    ),
                                    Tab(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text("CATEGORY"),
                                      ),
                                    ),
                                  ]),
                            ),
                            body: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: size.width * 0.02),
                              child: TabBarView(children: [
                                Text(detailCon.productDetailModel.description!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: size.width * 0.03,
                                        fontStyle: FontStyle.italic)),
                                Text(detailCon.productDetailModel.stock!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: size.width * 0.03,
                                        fontStyle: FontStyle.italic)),
                                Text(detailCon.productDetailModel.brand!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: size.width * 0.03,
                                        fontStyle: FontStyle.italic)),
                                Text(detailCon.productDetailModel.category!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: size.width * 0.03,
                                        fontStyle: FontStyle.italic)),
                              ]),
                            ),
                          )),
                    ),
                  ],
                ))
          ],
        );
      }
    });
  }
}
