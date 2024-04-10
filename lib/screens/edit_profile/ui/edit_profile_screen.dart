import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/screens/edit_profile/bloc/edit_profile_cubit.dart';
import 'package:app_zalo/screens/edit_profile/bloc/edit_profile_state.dart';
import 'package:app_zalo/widget/button/button_bottom_navigated.dart';
import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:app_zalo/widget/header/header_back.dart';
import 'package:app_zalo/widget/text_input/text_input_widget.dart';
import 'package:app_zalo/widget/text_input_picked_day/text_input_picked_day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatefulWidget {
  String? name;
  String? dateOfBirth;
  int? sex;
  String? phone;
  String? avatar;
  EditProfileScreen(
      {super.key,
      this.name,
      this.dateOfBirth,
      this.sex,
      this.phone,
      this.avatar});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String selectedTimeBorn = "";
  int? selectedRadio;
  String? name = "";
  @override
  void initState() {
    super.initState();
    selectedRadio = widget.sex;
    selectedTimeBorn =
        DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.dateOfBirth!));
    dateOfBirth =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.dateOfBirth!));
    name = widget.name;
  }

  String? dateOfBirth;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return DismissKeyboard(
      child: SafeArea(
          child: Scaffold(
        body: Column(children: [
          HeaderBack(
            notCheck: true,
            title: "Chỉnh sửa thông tin cá nhân",
          ),
          Row(children: [
            Padding(
              padding: EdgeInsets.only(
                left: 15.sp,
                right: 15.sp,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(80.sp),
                child: widget.avatar != ""
                    ? ImageAssets.networkImage(
                        url: widget.avatar,
                        width: 90.sp,
                        height: 90.sp,
                      )
                    : ImageAssets.pngAsset(
                        Png.imageAvatarChien,
                        width: 90.sp,
                        height: 90.sp,
                      ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50.sp),
              width: width * 0.69,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextInputWidget(
                    title: "Tên",
                    value: name,
                    onTextChanged: (text) {
                      setState(() {
                        name = text;
                      });
                    },
                  ),
                  Container(
                    height: 20.sp,
                    width: width - 20.sp,
                    margin: EdgeInsets.only(left: 20.sp),
                    child: Text(name == "" ? "Tên không được để trống" : "",
                        style: text11.textColor.error),
                  ),
                  TextInputPickedDay(
                    day: selectedTimeBorn,
                    hint: "Ngày sinh",
                    onChanged: (DateTime pickedDate) {
                      setState(() {
                        selectedTimeBorn =
                            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                        dateOfBirth =
                            "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                      });
                    },
                    onManualInput: (String pickedDate) {
                      setState(() {
                        dateOfBirth = pickedDate;
                      });
                    },
                  ),
                  Container(
                    padding: EdgeInsets.all(10.sp),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Radio(
                                  value: 1,
                                  groupValue: selectedRadio,
                                  onChanged: (index) {
                                    setState(() {
                                      selectedRadio = index;
                                    });
                                  },
                                  activeColor: primaryColor,
                                ),
                                Expanded(
                                  child: Text(
                                    'Nam',
                                    style: text14.semiBold.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Radio(
                                  value: 2,
                                  groupValue: selectedRadio,
                                  onChanged: (index) {
                                    setState(() {
                                      selectedRadio = index;
                                    });
                                  },
                                  activeColor: primaryColor,
                                ),
                                Expanded(
                                    child: Text(
                                  'Nữ',
                                  style: text14.semiBold.black,
                                ))
                              ],
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            )
          ]),
          Container(
              margin: EdgeInsets.only(top: 20.sp),
              child: BlocBuilder<EditProfileCubit, EditProfileState>(
                  builder: (context, state) {
                if (state is LoadingEditProfileState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is EditProfileSuccessState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pop(context);
                    context.read<EditProfileCubit>().resetState();
                  });
                  return Container();
                } else {
                  return ButtonBottomNavigated(
                    title: "Lưu",
                    isValidate: name != "" &&
                        dateOfBirth != "" &&
                        selectedRadio != null,
                    onPressed: () {
                      context.read<EditProfileCubit>().editProfile(
                            name!,
                            dateOfBirth!,
                            selectedRadio! == 1 ? 1 : 0,
                            widget.phone!,
                          );
                    },
                  );
                }
              }))
        ]),
      )),
    );
  }
}
