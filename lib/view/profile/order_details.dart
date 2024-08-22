import 'package:emartapp/consts/consts.dart';
import 'package:emartapp/view/profile/components/order_place_details.dart';
import 'package:emartapp/view/profile/components/order_status.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatefulWidget {
  final dynamic data;

  const OrderDetails({super.key, this.data});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order Details".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              orderStatus(
                color: redColor,
                icon: Icons.done,
                title: "Order Placed",
                showDone: widget.data[0]['order_placed'],
              ),
              orderStatus(
                color: Colors.blue,
                icon: Icons.thumb_up,
                title: "Confirmed",
                showDone: widget.data[0]['order_confirmed'],
              ),
              orderStatus(
                color: Colors.yellow,
                icon: Icons.car_crash,
                title: "On Delivery",
                showDone: widget.data[0]['order_on_delivery'],
              ),
              orderStatus(
                color: Colors.purple,
                icon: Icons.done_all_rounded,
                title: "Delivered",
                showDone: widget.data[0]['order_delivered'],
              ),
              const Divider(),
              10.heightBox,
              Column(
                children: [
                  orderPlaceDetails(
                    title1: "Order Source",
                    d1: widget.data[0]['order_code'],
                    title2: "Shipping Method",
                    d2: widget.data[0]['shipping_method'],
                  ),
                  orderPlaceDetails(
                    title1: "Order Date",
                    d1: intl.DateFormat().add_yMd().format((widget.data[0]['order_date'].toDate())),
                    title2: "Payment Method",
                    d2: widget.data[0]['payment_method'],
                  ),
                  orderPlaceDetails(
                    title1: "Payment Status",
                    d1: "Unpaid",
                    title2: "Delivery Status",
                    d2: "Order Placed",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Shipping Address".text.fontFamily(semibold).make(),
                            "${widget.data[0]['order_by_name']}".text.make(),
                            "${widget.data[0]['order_by_email']}".text.make(),
                            "${widget.data[0]['order_by_address']}".text.make(),
                            "${widget.data[0]['order_by_city']}".text.make(),
                            "${widget.data[0]['order_by_state']}".text.make(),
                            "${widget.data[0]['order_by_phone']}".text.make(),
                            "${widget.data[0]['order_by_postalcode']}".text.make(),
                          ],
                        ),
                        SizedBox(
                          width: 130,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Total Price:".text.fontFamily(semibold).make(),
                                "${widget.data[0]['total_amount']}".text.fontFamily(semibold).color(redColor).make(),
                              ]
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ).box.outerShadowMd.white.make(),
              const Divider(),
              10.heightBox,
              "Ordered Product".text.size(16).fontFamily(semibold).color(darkFontGrey).make(),
              10.heightBox,
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(widget.data[0]['orders'].length, (index){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlaceDetails(
                        title1: widget.data[0]['orders'][index]['title'],
                        d1: "${widget.data[0]['orders'][index]['qty']}x",
                        title2: widget.data[0]['orders'][index]['tprice'],
                        d2: "Refundable",
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: 30,
                          height: 20,
                          color: Color(widget.data[0]['orders'][index]['color']),
                        ),
                      ),
                      const Divider(),
                    ]
                  );
                }).toList(),
              ).box.outerShadowMd.white.margin(const EdgeInsets.only(bottom: 4)).make(),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
