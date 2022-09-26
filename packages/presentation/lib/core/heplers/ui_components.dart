import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class AppUIHelpers {
  static Widget loadingIndicatorProgressBar({String? data}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            backgroundColor: Colors.orange,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            data ?? "Setting up your account please wait..",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  static void snackBarNetwork({
    required BuildContext context,
    String? msg,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("$msg"), const Icon(Icons.travel_explore_rounded)],
        ),
      ),
    );
  }

  static void snackBar(
      {required BuildContext context,
      required String msg,
      required GlobalKey<ScaffoldState> scaffoldState}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              msg,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  static void push({required BuildContext context, required Widget widget}) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => widget));
  }

  static void toast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Widget verticalDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 18,
      width: 1.0,
      decoration: BoxDecoration(color: Colors.black.withOpacity(.4)),
    );
  }
}
