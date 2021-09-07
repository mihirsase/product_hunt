import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:product_hunt/services/pallete.dart';

class Notifier {
  static final Notifier instance = Notifier._();

  Notifier._();

  void alert({
    required final String title,
    required final NotifType notifType,
  }) {
    BotToast.showCustomNotification(
      duration: Duration(milliseconds: 4000),
      crossPage: true,
      onlyOne: true,
      backButtonBehavior: BackButtonBehavior.ignore,
      toastBuilder: (final Function onCancel) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Pallete.black.withOpacity(0.2),
                spreadRadius: 0.1,
                blurRadius: 6,
                offset: Offset(3, 3),
              ),
            ],
          ),
          child: Card(
            color: Pallete.white,
            elevation: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 14),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: notifType == NotifType.positive
                    ? Icon(
                  Icons.thumb_up,
                  size: 32,
                )
                    : Icon(
                  Icons.thumb_down,
                  size: 32,
                ),
                title: Text(title),
              ),
            ),
          ),
        );
      },
    );
  }
}

enum NotifType {
  positive,
  negative,
}
