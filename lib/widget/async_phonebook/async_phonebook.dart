import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/screens/fast_contact/bloc/async_phone_cubit.dart';
import 'package:app_zalo/screens/fast_contact/bloc/async_phone_state.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class AsyncPhonebook extends StatefulWidget {
  List<Contact>? contacts = [];
  AsyncPhonebook({super.key, this.contacts});

  @override
  State<AsyncPhonebook> createState() => _AsyncPhonebookState();
}

class _AsyncPhonebookState extends State<AsyncPhonebook> {
  bool visibility = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return visibility == true
        ? BlocProvider(
            create: (context) => AsyncPhoneBookCubit(),
            child: BlocBuilder<AsyncPhoneBookCubit, AsyncPhoneBookState>(
                builder: (context, state) {
              return Container(
                margin: EdgeInsets.only(top: 8.sp),
                height: 55.sp,
                width: width,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: lightBlue.withOpacity(0.1),
                      width: 0.5.sp,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.sp, right: 15.sp),
                      child: Icon(
                        Icons.published_with_changes_rounded,
                        color: lightBlue,
                        size: 20.sp,
                      ),
                    ),
                    state is LoadingAsyncPhoneBookState
                        ? Padding(
                            padding: EdgeInsets.only(right: 10.sp),
                            child: CircularProgressIndicator(
                              color: primaryColor,
                              strokeWidth: 2.sp,
                            ),
                          )
                        : state is AsyncSuccessState
                            ? Text("Đồng bộ thành công",
                                style: text15.medium.copyWith(
                                  color: lightBlue,
                                ))
                            : state is ErrorAsyncPhoneBookState
                                ? Text("Đồng bộ thất bại",
                                    style: text15.error.medium)
                                : InkWell(
                                    onTap: () {
                                      context
                                          .read<AsyncPhoneBookCubit>()
                                          .AsyncPhoneBookenticate(
                                              widget.contacts ??= []);
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.sp),
                                          border: Border.all(
                                              color: lightBlue.withOpacity(0.8),
                                              width: 1.sp),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.sp, vertical: 6.sp),
                                        child: Text("Đồng bộ danh bạ",
                                            style: text16.black.regular)),
                                  ),
                    const Expanded(child: SizedBox()),
                    InkWell(
                      onTap: () {
                        setState(() {
                          context.read<AsyncPhoneBookCubit>().resetState();
                          visibility = false;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: 20.sp,
                            left: 25.sp,
                            top: 10.sp,
                            bottom: 10.sp),
                        child: Icon(
                          Icons.close,
                          color: primaryColor,
                          size: 20.sp,
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
          )
        : Container();
  }
}
