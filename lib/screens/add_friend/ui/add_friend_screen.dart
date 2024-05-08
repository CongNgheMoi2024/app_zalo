import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/screens/add_friend/bloc/add_friend_cubit.dart';
import 'package:app_zalo/screens/add_friend/bloc/add_friend_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class AddFriendScreen extends StatefulWidget {
  String? idFriend;
  String? avatarFriend;
  String? nameFriend;
  AddFriendScreen(
      {super.key, this.idFriend, this.avatarFriend, this.nameFriend});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: width,
            height: 50.sp,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: boxMessShareColor, width: 2.sp),
              borderRadius: BorderRadius.circular(150.sp),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.sp),
              child: widget.avatarFriend == ""
                  ? ImageAssets.pngAsset(
                      Png.imgUserBoy,
                      width: 160.sp,
                      height: 160.sp,
                      fit: BoxFit.cover,
                    )
                  : ImageAssets.networkImage(
                      url: widget.avatarFriend!,
                      width: 160.sp,
                      height: 160.sp,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          SizedBox(
            width: width,
            height: 20.sp,
          ),
          Text(widget.nameFriend!, style: text22.regular.primary),
          BlocBuilder<AddFriendCubit, AddFriendState>(
              builder: (context, state) {
            if (state is LoadingAddFriendState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            } else if (state is ErrorAddFriendState) {
              return const Center(child: Text('Gửi kết bạn thất bại'));
            } else if (state is AddFriendSuccessState) {
              return Container(
                margin: EdgeInsets.only(
                  top: 20.sp,
                  bottom: 20.sp,
                ),
                width: width,
                child: Center(
                  child: Text("Bạn đã gửi lời mời kết bạn",
                      style: text22.regular.copyWith(color: boxMessShareColor)),
                ),
              );
            } else {
              return InkWell(
                onTap: () {
                  context.read<AddFriendCubit>().addFriends(widget.idFriend!);
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: 20.sp,
                    bottom: 20.sp,
                  ),
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: lightBlue,
                        size: 35.sp,
                      ),
                      Text("Kết bạn",
                          style: text22.regular.copyWith(color: lightBlue)),
                    ],
                  ),
                ),
              );
            }
          })
        ],
      ),
    ));
  }
}
