import 'package:flutter/material.dart';
import 'package:speed_vpn/helpers/constants.dart';
import 'package:speed_vpn/helpers/size_config.dart';

class UpDownWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final String speed;
  final String speedType;
  final String title2;
  final IconData icon2;
  final String speed2;
  final String speedType2;
  UpDownWidget({
    this.title,
    this.icon,
    this.speed,
    this.speedType,
    this.title2,
    this.icon2,
    this.speed2,
    this.speedType2,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: SizeConfig.screenWidth / 2.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(.2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        icon,
                        color: kWhiteColor,
                        size: 16,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      title.toUpperCase(),
                      style: kDescriptionText2.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    speed,
                    style: kDescriptionText.copyWith(
                      color: kBlackColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    speedType,
                    style: kSmallText.copyWith(
                      color: kBlackColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          width: SizeConfig.screenWidth / 2.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(.2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        icon2,
                        color: kWhiteColor,
                        size: 16,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      title2.toUpperCase(),
                      style: kDescriptionText2.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    speed2,
                    style: kDescriptionText.copyWith(
                      color: kBlackColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    speedType2,
                    style: kSmallText.copyWith(
                      color: kBlackColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
