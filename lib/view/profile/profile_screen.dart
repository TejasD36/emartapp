import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartapp/consts/consts.dart';
import 'package:emartapp/consts/lists.dart';
import 'package:emartapp/controller/auth_controller.dart';
import 'package:emartapp/controller/profile_controller.dart';
import 'package:emartapp/service/firestore_service.dart';
import 'package:emartapp/view/auth/login_screen.dart';
import 'package:emartapp/view/cart/component/detail_card.dart';
import 'package:emartapp/view/profile/edit_profile_screen.dart';
import 'package:emartapp/widgets/bg_widget.dart';
import 'package:emartapp/widgets/loading_indicator.dart';
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

    var controller = Get.put(ProfileController());

    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirestoreService.getUser(currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

            if(!snapshot.hasData){
              return Center(
               child: loadingIndicator()
              );
            }
            else{

              var data = snapshot.data!.docs[0];

              return SafeArea(
                child: Column(
                  children: [

                    10.heightBox,

                    //Edit Profile
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Align(
                        alignment: Alignment.topRight,
                        child: Icon(Icons.edit, color: whiteColor,),
                      ).onTap((){

                        controller.nameController.text = data['name'].toString();
                        Get.to(()=>EditProfileScreen(data: data,));
                      }),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [

                          //Profile Image

                          data['imageUrl'] == ''

                          ?Image.asset(
                            imgProfile,
                            width: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make()

                          :Image.network(
                            data['imageUrl'],
                            width: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),

                          10.widthBox,

                          //Profile name & email
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                data['name'].toString().text.fontFamily(semibold).white.make(),
                                data['email'].toString().text.white.make(),
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
                              onPressed: () async{
                                await Get.put(AuthController()).signOutMethod(context);
                                Get.offAll(()=>const LoginScreen());
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
                          count: data['cart_count'].toString(),
                          title: "In Your Cart",
                          width: context.screenWidth /3.4,
                        ),
                        detailCard(
                          count: data['wishlist_count'].toString(),
                          title: "In Your Wishlists",
                          width: context.screenWidth /3.4,
                        ),
                        detailCard(
                          count: data['order_count'].toString(),
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
              );
            }
          },
        ),
      )
    );
  }
}

