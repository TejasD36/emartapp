import 'package:emartapp/consts/consts.dart';
import 'package:emartapp/consts/lists.dart';
import 'package:emartapp/views/auth/login_screen.dart';
import 'package:emartapp/views/cart/component/detail_card.dart';
import 'package:emartapp/widgets/bg_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../splash_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [

              10.heightBox,

              //Edit Profile
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Icon(Icons.edit, color: whiteColor,),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [

                    //Profile Image
                    Image.asset(
                      imgProfile,
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make(),

                    10.widthBox,

                    //Profile name & email
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Dummy user".text.fontFamily(semibold).white.make(),
                            "customer@example.com ".text.white.make(),
                          ],
                        ),
                    ),

                    //Logout Button
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: whiteColor,
                        ),
                      ),
                      onPressed: (){
                        Get.to(()=>const SplashScreen());
                      },
                      child: logout.text.fontFamily(semibold).white.make()
                    ),
                  ],
                ),
              ),

              10.heightBox,

              //Profile Shopping Detail Cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  detailCard(
                    count: "00",
                    title: "In Your Cart",
                    width: context.screenWidth /3.4,
                  ),
                  detailCard(
                    count: "32",
                    title: "In Your Wishlists",
                    width: context.screenWidth /3.4,
                  ),
                  detailCard(
                    count: "175",
                    title: "Your Orders",
                    width: context.screenWidth /3.4,
                  )
                ],
              ),

              10.heightBox,


              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index){
                  return const Divider(color: lightGrey,);
                },

                itemCount: profileButtonsList.length,
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    leading: Image.asset(
                      profileButtonsIcon[index],
                      width: 22,
                    ),
                    title: profileButtonsList[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                  );
                },
              ).box.white.rounded.margin(const EdgeInsets.all(12)).padding(const EdgeInsets.symmetric(horizontal: 16)).shadowSm.make().box.color(redColor).make(),
            ],
          ),
        ),
      )
    );
  }
}

