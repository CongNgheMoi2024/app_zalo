import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/screens/add_friend/bloc/add_friend_cubit.dart';
import 'package:app_zalo/screens/add_friend/ui/add_friend_screen.dart';
import 'package:app_zalo/screens/search/bloc/search_cubit.dart';
import 'package:app_zalo/screens/search/bloc/search_state.dart';
import 'package:app_zalo/utils/regex.dart';
import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<StatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isButtonVisible = false;
  String phone = "";
  bool isPhoneValid = false;
  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
        child: SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor.withOpacity(0.9),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primaryColor.withOpacity(0.9),
                  primaryColor.withOpacity(0.7),
                  primaryColor.withOpacity(0.6)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [
                  0.1,
                  0.6,
                  0.9,
                ],
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 300.sp,
                  margin: EdgeInsets.only(
                    left: 70.sp,
                    top: 10.sp,
                    bottom: 10.sp,
                  ),
                  padding: EdgeInsets.only(
                    left: 14.sp,
                  ),
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        autofocus: true,
                        controller: _controller,
                        onChanged: (value) {
                          setState(() {
                            _isButtonVisible = value.isNotEmpty;
                            phone = value;
                            isPhoneValid = Regex.isPhone(phone);
                          });
                        },
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (value) {
                          context.read<SearchCubit>().search(phone);
                        },
                        decoration: const InputDecoration(
                            hintText: "Nhập số điện thoại...",
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent))),
                      )),
                      Visibility(
                        visible: _isButtonVisible,
                        child: IconButton(
                          onPressed: () {
                            _controller.clear();
                            setState(() {
                              phone = "";
                            });
                          },
                          icon: const Icon(Icons.cancel),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            if (state is LoadingSearchState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            } else if (state is ErrorSearchState) {
              return const Center(child: Text('Không tìm thấy người dùng'));
            } else if (state is SuccessSearchState) {
              String imgUrl = state.data.containsKey('avatar') &&
                      state.data['avatar'] != null
                  ? state.data['avatar']
                  : "";
              return GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider<AddFriendCubit>(
                              create: (BuildContext context) =>
                                  AddFriendCubit(),
                              child: AddFriendScreen(
                                idFriend: state.data['id'],
                                avatarFriend: imgUrl,
                                nameFriend: state.data['name'],
                              ))));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10.sp),
                  height: 50,
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: whiteColor, width: 0.5),
                        top: BorderSide(color: whiteColor, width: 0.5)),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20.sp),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: imgUrl != ""
                            ? NetworkImage(imgUrl)
                            : state.data['sex']
                                ? const AssetImage(Png.imgUserBoy)
                                : const AssetImage(Png.imgUserGirl)
                                    as ImageProvider,
                      ),
                      SizedBox.fromSize(
                        size: Size.fromWidth(30.sp),
                      ),
                      Expanded(child: Text(state.data['name'])),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.sp, vertical: 7.sp),
                        margin: EdgeInsets.only(right: 20.sp, left: 20.sp),
                        child: Text(state.data['phone'],
                            style: text16.regular
                                .copyWith(color: lightBlue.withOpacity(0.5))),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    ));
  }
}
