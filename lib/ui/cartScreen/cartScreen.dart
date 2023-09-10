import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_ecomerce/controller/controllerLogic.dart';
import 'package:shop_ecomerce/ui/productDetailScreen/produtDetailScreen.dart';
import 'package:shop_ecomerce/utils/common.dart';
import 'package:shop_ecomerce/utils/commonThings.dart';
import 'package:shop_ecomerce/utils/paymentGateWay/payuClasses/commonPayu.dart';
import 'package:shop_ecomerce/utils/paymentGateWay/razorPayClasses/razorPayCommon.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final cartController = Get.put(ShowCartController());

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
          "Cart",
          style: TextStyle(
              color: Colors.black,
              fontSize: size.width * 0.05,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: colorTheme),
            onPressed: () {
              Get.bottomSheet(Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(children: [
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: colorTheme.withOpacity(0.5),
                          shape: const BeveledRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      onPressed: () {
                        ///payu checkout pro
                        var response =
                            cartController.checkoutPro.openCheckoutScreen(
                          payUPaymentParams: PayUParams.createPayUPaymentParams(
                            cartController.showCartList.first.cartTotal
                                .toString(),
                            cartController.showCartList.first.title!,
                          ),
                          payUCheckoutProConfig:
                              PayUParams.createPayUConfigParams(
                            cartController.showCartList.first.cartTotal!,
                            cartController
                                .showCartList.first.discountPercentage!,
                          ),
                        );
                      },
                      icon: const Icon(Icons.payment),
                      label: const Text("Pay with payU")),
                  SizedBox(height: size.width * 0.02),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.withOpacity(0.5),
                          shape: const BeveledRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      onPressed: () {
                        cartController.razorpay.open(razorPayParam);
                      },
                      icon: const Icon(Icons.payment),
                      label: const Text("Pay with RazorPay")),
                ]),
              ));
            },
            child: const Text("Proceed To Pay")),
      ),
      body: cartWidget(size),
    );
  }

  Widget cartWidget(size) {
    return Obx(() {
      if (cartController.isLoading.value == true) {
        return showLoader();
      }
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: size.width * 0.04,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: Text(
                "Cart Items: ${cartController.showCartList.length}",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: size.width * 0.03),
              ),
            ),
            ListView.separated(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02, vertical: size.width * 0.01),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.02,
                        vertical: size.width * 0.02),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(size.width * 0.02)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(ProductDetailScreen());
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.01,
                                    vertical: size.width * 0.01),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(
                                        size.width * 0.02)),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(size.width * 0.02),
                                  child: Image.network(
                                    cartController.showCartList[index].image!,
                                    width: size.width * 0.25,
                                    height: size.width * 0.25,
                                    fit: BoxFit.cover,
                                    errorBuilder: (s, p, o) {
                                      return Image.asset(
                                          "assets/images/image_placeholder.png",
                                          height: size.width * 0.25,
                                          width: size.width * 0.25,
                                          fit: BoxFit.cover);
                                    },
                                    loadingBuilder: (s, p, o) {
                                      if (o == null) return p;
                                      return Image.asset(
                                          "assets/images/image_placeholder.png",
                                          height: size.width * 0.25,
                                          width: size.width * 0.25,
                                          fit: BoxFit.cover);
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: size.width * 0.01,
                                ),
                                Text(
                                  cartController.showCartList[index].title!,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: size.width * 0.03),
                                ),
                                SizedBox(
                                  height: size.width * 0.02,
                                ),
                                Container(
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text:
                                              "$rupeeSymbol${cartController.showCartList[index].price}",
                                          style: TextStyle(
                                            color: colorTheme,
                                            fontSize: size.width * 0.04,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ]),
                                  ),
                                ),
                                SizedBox(
                                  height: size.width * 0.03,
                                ),
                              ],
                            )),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: size.width * 0.27,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.width * 0.01))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        int qty = int.parse(cartController
                                            .showCartList[index].cartQuantity!);

                                        if (qty > 1) {
                                          qty = qty - 1;
                                          /* callUpdateCart(
                                              showCartList[index].productId,
                                              qty.toString());*/
                                        }
                                      },
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: size.width * 0.01),
                                          child: Icon(
                                            Icons.remove_circle,
                                            color: Colors.grey,
                                            size: size.width * 0.06,
                                          ))),
                                  Text(
                                      "  ${cartController.showCartList[index].cartQuantity.toString()}  ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: size.width * 0.035,
                                          fontWeight: FontWeight.bold)),
                                  InkWell(
                                      onTap: () {
                                        int qty = int.parse(cartController
                                                .showCartList[index]
                                                .cartQuantity!) +
                                            1;
                                        /* callUpdateCart(
                                            showCartList[index].productId,
                                            qty.toString());*/
                                      },
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: size.width * 0.01),
                                          child: Icon(
                                            Icons.add_circle,
                                            color: colorTheme,
                                            size: size.width * 0.06,
                                          ))),
                                ],
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                /* callUpdateCart(
                                  cartController.showCartList[index].cartQuantity,
                                  "0",
                                );
                                _type = "delete";*/
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: colorTheme),
                              ),
                              child: Icon(
                                Icons.delete_forever,
                                size: size.width * 0.05,
                                color: colorTheme,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: size.width * 0.04,
                  );
                },
                itemCount: cartController.showCartList.length),

            SizedBox(
              height: size.width * 0.04,
            ),
            Divider(
              thickness: 15,
              color: Colors.grey.shade100,
            ),

            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.02, vertical: size.width * 0.03),
              child: Text(
                "Coupons & Discounts",
                style: TextStyle(
                    fontSize: size.width * 0.03,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.02, vertical: size.width * 0.03),
              child: Row(
                children: [
                  Icon(
                    Icons.local_offer_outlined,
                    color: Colors.black,
                    size: size.width * 0.05,
                  ),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: size.width * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Apply Coupon",
                          style: TextStyle(
                              fontSize: size.width * 0.03,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        Text(
                          "Hurry up! Don't miss it",
                          style: TextStyle(
                              fontSize: size.width * 0.028,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade400),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: size.width * 0.05,
                    color: Colors.black,
                  )
                ],
              ),
            ),

            Divider(
              color: Colors.grey.shade100,
              thickness: 15,
            ),

            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.02, vertical: size.width * 0.03),
              child: Text(
                "PRICE DETAILS (${cartController.showCartList.length} Item)",
                style: TextStyle(
                    fontSize: size.width * 0.035,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.02, vertical: size.width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// SubTotal
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Unit Price",
                        style: TextStyle(
                            color: Colors.black, fontSize: size.width * 0.035),
                      ),
                      Text(
                        "$rupeeSymbol${(cartController.showCartList.first.cartTotal!)}",
                        style: TextStyle(
                            color: Colors.black, fontSize: size.width * 0.035),
                      ),
                    ],
                  ),
                  const Divider(),
                  SizedBox(
                    height: size.width * 0.02,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "DISCOUNT",
                        style: TextStyle(
                            color: Colors.black, fontSize: size.width * 0.035),
                      ),
                      Text(
                        "-$rupeeSymbol${cartController.showCartList.first.discountPercentage}/-",
                        style: TextStyle(
                            color: Colors.green, fontSize: size.width * 0.035),
                      ),
                    ],
                  ),

                  const Divider(),
                  SizedBox(height: size.width * 0.02),

                  /// total
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Subtotal",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: size.width * 0.04),
                          ),
                        ],
                      ),
                      Text(
                        "$rupeeSymbol${cartController.showCartList.first.cartTotal!}/-",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: size.width * 0.04),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: Text(
                "*MRP is inclusive of all taxes",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: size.width * 0.028),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            /// checkout
          ],
        ),
      );
    });
  }
}
