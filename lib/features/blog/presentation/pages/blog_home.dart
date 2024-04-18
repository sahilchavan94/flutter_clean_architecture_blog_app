import 'package:blog_app/core/strings/strings.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class BlogHome extends StatefulWidget {
  const BlogHome({super.key});

  @override
  State<BlogHome> createState() => _BlogHomeState();
}

class _BlogHomeState extends State<BlogHome> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/blog_logo.png',
                      height: 32,
                      width: 32,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Discover',
                      style: AppTheme.darkThemeData.textTheme.displayLarge,
                    ),
                  ],
                ),
              ],
            ),
            Text(
              maxLines: 1,
              AppStrings.homePageString,
              style: AppTheme.darkThemeData.textTheme.displaySmall!.copyWith(
                color: AppPallete.grayLight,
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_circle),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * .018,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(
              tabs: const [
                Text('Top Blogs'),
                Text('Favourites'),
              ],
              controller: _tabController,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  SizedBox(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: Center(
                      child: Text('This will contain the top blogs'),
                    ),
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: Center(
                      child: Text('This will contain your favourite blogs'),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
