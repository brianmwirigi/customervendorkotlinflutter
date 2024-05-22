import 'package:customervendorkotlinflutter/views/customers/navigationscreens/widgets/bannerwidget.dart';
import 'package:customervendorkotlinflutter/views/customers/navigationscreens/widgets/categorytextwidget.dart';
import 'package:customervendorkotlinflutter/views/customers/navigationscreens/widgets/searchinputwidget.dart';
import 'package:customervendorkotlinflutter/views/customers/navigationscreens/widgets/welcometextwidget.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const WelcomeTextWidget(),
        const SizedBox(height: 10),
        const SearchInputWidget(),
        const SizedBox(height: 10),
        BannerWidget(),
        const SizedBox(height: 10),
        CategoryTextWidget(),
      ],
    );
  }
}
