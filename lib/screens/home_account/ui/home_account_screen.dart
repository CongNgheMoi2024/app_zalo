import 'dart:io';

import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/routes/routes.dart';
import 'package:app_zalo/screens/change_password/bloc/change_password_cubit.dart';
import 'package:app_zalo/screens/change_password/ui/change_password_screen.dart';
import 'package:app_zalo/screens/edit_profile/bloc/edit_profile_cubit.dart';
import 'package:app_zalo/screens/edit_profile/ui/edit_profile_screen.dart';
import 'package:app_zalo/screens/home_account/bloc/infor_account_cubit.dart';
import 'package:app_zalo/screens/home_account/bloc/infor_account_state.dart';
import 'package:app_zalo/storages/hive_storage.dart';
import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class HomeAccountScreen extends StatefulWidget {
  const HomeAccountScreen({super.key});

  @override
  State<HomeAccountScreen> createState() => _HomeAccountScreenState();
}

class _HomeAccountScreenState extends State<HomeAccountScreen> {
  int sizeImage = 0;
  File? pathImage1;
  String phone = "";
  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();

      final XFile? pickedFile1 = await picker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile1 != null) {
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, RouterName.uploadImageCoverScreen,
            arguments: {'imageFile': File(pickedFile1.path)});
      } else {}
    } catch (e) {
      print("Error: $e");
    }
  }

  void showCustomModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 160.sp,
        child: Column(
          children: [
            Container(
              height: 50.sp,
              padding: EdgeInsets.only(left: 18.sp),
              alignment: Alignment.centerLeft,
              child: Text(
                "Ảnh bìa",
                style: text18.primary.semiBold,
              ),
            ),
            GestureDetector(
              onTap: () {
                _pickImage();
                Navigator.pop(context);
              },
              child: Container(
                height: 50.sp,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 18.sp),
                    Icon(
                      Icons.add_a_photo_outlined,
                      size: 30,
                      color: primaryColor.withOpacity(0.8),
                    ),
                    SizedBox(width: 18.sp),
                    Text(
                      "Chọn ảnh từ thư viện",
                      style: text16.primary.regular,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showModalAvatar(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(22.sp),
          ),
        ),
        builder: (context) => SizedBox(
              height: 160.sp,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8.sp),
                    height: 25.sp,
                    width: width,
                    child: Center(
                      child: Container(
                        height: 6.sp,
                        width: 50.sp,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5.sp),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.sp),
                    child: Text("Xem ảnh đại diện",
                        style: text15.regular.copyWith(color: lightBlue)),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                          context, RouterName.uploadAvatarScreen);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 13.sp),
                      padding: EdgeInsets.only(
                          top: 10.sp, bottom: 15.sp, left: 18.sp, right: 18.sp),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.withOpacity(0.2),
                            width: 1.sp,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.photo_camera_back_outlined,
                            color: primaryColor,
                            size: 30.sp,
                          ),
                          SizedBox(width: 16.sp),
                          Text("Cập nhật Avatar",
                              style: text16.regular.primary),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return DismissKeyboard(
        child: RefreshIndicator(
      onRefresh: () async {
        setState(() {
          context.read<InforAccountCubit>().GetInforAccount();
        });
      },
      child: Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          BlocConsumer<InforAccountCubit, InforAccountState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is InitialInforAccountState) {
                  context.read<InforAccountCubit>().GetInforAccount();
                  return Container();
                } else if (state is LoadingInforAccountState) {
                  return const Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.black)),
                  );
                } else if (state is ErrorInforAccountState) {
                  return SizedBox(
                    height: height * 0.3,
                    width: width,
                    child: Center(
                      child: Text("Load Thông tin không thành công",
                          style: text14.medium.error),
                    ),
                  );
                } else if (state is InforAccountSuccessState) {
                  phone = state.phone;
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showCustomModalBottomSheet(context);
                              },
                              child: Container(
                                height: 185.sp,
                                width: width,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: state.imageCover != ""
                                        ? NetworkImage(state.imageCover)
                                        : const AssetImage(Png.imgAnhBia)
                                            as ImageProvider<Object>,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                  height: 70.sp,
                                  width: width - 200.sp,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: const [
                                        0.4,
                                        0.5,
                                        0.6,
                                        0.7,
                                      ],
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.17),
                                        Colors.black.withOpacity(0.21),
                                        Colors.black.withOpacity(0.27),
                                      ],
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      showModalAvatar(context);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 8.sp),
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15.sp, right: 15.sp),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        80.sp),
                                                child: state.avatar != ""
                                                    ? ImageAssets.networkImage(
                                                        url: state.avatar,
                                                        width: 55.sp,
                                                        height: 55.sp,
                                                      )
                                                    : ImageAssets.pngAsset(
                                                        Png.imageAvatarChien,
                                                        width: 55.sp,
                                                        height: 55.sp,
                                                      ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: width * 0.22,
                                                  child: Text(
                                                    ((state.user as Map)['name']
                                                            .split(' ')
                                                        as List<String>)[0],
                                                    style: text18.white.medium,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 3.sp,
                                                ),
                                                Text(
                                                  "Xem trang cá nhân",
                                                  style: text15.regular
                                                      .copyWith(
                                                          color: Colors
                                                              .white
                                                              .withOpacity(
                                                                  0.8)),
                                                )
                                              ],
                                            )
                                          ]),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        Container(
                          width: width,
                          padding: EdgeInsets.only(
                              left: 15.sp, right: 15.sp, top: 10.sp),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 10.sp,
                                    bottom: 10.sp,
                                  ),
                                  child: Text("Thông tin cá nhân",
                                      style: text16.medium.black),
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 15.sp, bottom: 15.sp),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                              width: width * 0.25,
                                              child: Text(
                                                "Giới tính",
                                                style: text16.black.regular,
                                              )),
                                          Text(
                                              (state.user as Map)['sex']
                                                  ? "Nam"
                                                  : "Nữ",
                                              style: text16.black.regular),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 0.5.sp,
                                      width: width,
                                      color: Colors.grey.withOpacity(0.3),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 15.sp, bottom: 15.sp),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                              width: width * 0.25,
                                              child: Text(
                                                "Ngày sinh",
                                                style: text16.black.regular,
                                              )),
                                          Text(
                                            '${(state.user as Map)['birthday'].split('-')[2]}/${(state.user as Map)['birthday'].split('-')[1]}/${(state.user as Map)['birthday'].split('-')[0]}',
                                            style: text16.black.regular,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 0.5.sp,
                                      width: width,
                                      color: Colors.grey.withOpacity(0.3),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 15.sp, bottom: 15.sp),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              width: width * 0.25,
                                              child: Text(
                                                "Điện thoại",
                                                style: text16.black.regular,
                                              )),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                (state.user as Map)['phone'],
                                                style: text16.black.regular,
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 5.sp),
                                                width: width * 0.66,
                                                child: Text(
                                                  "Số điện thoại chỉ hiển thị với người có lưu số bạn trong danh bạ máy",
                                                  style:
                                                      text15.textColor.regular,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BlocProvider<EditProfileCubit>(
                                          create: (BuildContext context) =>
                                              EditProfileCubit(),
                                          child: EditProfileScreen(
                                              name: (state.user as Map)['name'],
                                              phone:
                                                  (state.user as Map)['phone'],
                                              avatar: state.avatar,
                                              dateOfBirth: (state.user
                                                  as Map)['birthday'],
                                              sex: (state.user as Map)['sex'] ==
                                                      true
                                                  ? 1
                                                  : 2),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 42.sp,
                                    margin: EdgeInsets.only(
                                        bottom: 5.sp, top: 18.sp),
                                    width: width - 30.sp,
                                    decoration: BoxDecoration(
                                        color: grey03,
                                        borderRadius:
                                            BorderRadius.circular(28.sp)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.edit,
                                          color: blackColor.withOpacity(0.8),
                                          size: 20.sp,
                                        ),
                                        SizedBox(
                                          width: 5.sp,
                                        ),
                                        Text(
                                          "Chỉnh sửa",
                                          style: text15.medium.copyWith(
                                            color: blackColor.withOpacity(0.8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 15.sp),
                            height: 10.sp,
                            width: width,
                            color: grey03.withOpacity(0.5)),
                      ]);
                } else {
                  return SizedBox(
                    height: height * 0.3,
                    width: width,
                    child: Center(
                      child: Text("Load Thông tin không thành công",
                          style: text14.medium.error),
                    ),
                  );
                }
              }),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              padding: EdgeInsets.only(
                left: 15.sp,
                right: 15.sp,
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BlocProvider<ChangePasswordCubit>(
                            create: (BuildContext context) =>
                                ChangePasswordCubit(),
                            child: ChangePasswordScreen(
                              phone: phone,
                            ),
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 18.sp, bottom: 18.sp),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: width * 0.15,
                              child: Icon(
                                Icons.published_with_changes,
                                size: 25.sp,
                                color: blackColor.withOpacity(0.8),
                              )),
                          Text("Đổi mật khẩu", style: text16.black.regular),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 0.5.sp,
                    width: width,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 18.sp, bottom: 18.sp),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: width * 0.15,
                            child: Icon(
                              Icons.live_help_outlined,
                              size: 25.sp,
                              color: blackColor.withOpacity(0.8),
                            )),
                        Text("Liên hệ hỗ trợ", style: text16.black.regular),
                      ],
                    ),
                  ),
                  Container(
                    height: 0.5.sp,
                    width: width,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  GestureDetector(
                    onTap: () {
                      HiveStorage().clearIdUser();
                      HiveStorage().clearRefreshToken();
                      HiveStorage().clearTokenAccess();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RouterName.onBoardingScreen,
                        (route) => false,
                      );
                    },
                    child: Container(
                      height: 45.sp,
                      margin: EdgeInsets.only(bottom: 15.sp, top: 15.sp),
                      width: width - 40.sp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28.sp),
                        border: Border.all(color: errorColor, width: 1.sp),
                      ),
                      child: Center(
                        child: Text(
                          "Đăng xuất",
                          style: text15.medium.error,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ])
        ]),
      ))),
    ));
  }
}
