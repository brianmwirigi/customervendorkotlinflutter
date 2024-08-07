import 'package:customervendorkotlinflutter/views/customers/navigationscreens/widgets/bannerwidget.dart';
import 'package:customervendorkotlinflutter/views/customers/navigationscreens/widgets/categorytextwidget.dart';
import 'package:customervendorkotlinflutter/views/customers/navigationscreens/widgets/welcometextwidget.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WelcomeTextWidget(),
          BannerWidget(),
          CategoryTextWidget(),
        ],
      ),
    );
  }
}
