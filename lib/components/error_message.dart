import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  String? errorCode;

  ErrorMessage({this.errorCode});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        SizedBox(
          height: 25,
        ),
        Container(
          width: 160,
          height: 160,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              errorCode == '404'
                  ? 'assets/images/error_404.png'
                  : errorCode == '500'
                      ? 'assets/images/error_500.png'
                      : errorCode == '300'
                          ? 'assets/images/no_data_found.png'
                          : 'assets/images/no_data_found.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          child: Text(
            errorCode == '404'
                ? 'Page Not Found.'
                : errorCode == '500'
                    ? 'Internal Server Error.'
                    : errorCode == '300'
                        ? 'No Plot Data Found'
                        : 'No Data Found !',
            style: TextStyle(
                color: Colors.grey[300],
                fontSize: 18,
                fontWeight: FontWeight.w700),
          ),
        )
      ],
    ));
  }
}
