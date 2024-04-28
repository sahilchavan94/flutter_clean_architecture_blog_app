import 'package:blog_app/features/blog/presentation/pages/blog_preview.dart';
import 'package:blog_app/features/blog/presentation/pages/edit_blog.dart';
import 'package:flutter/material.dart';

class AddNewBlog extends StatefulWidget {
  const AddNewBlog({super.key});

  @override
  State<AddNewBlog> createState() => _AddNewBlogState();
}

class _AddNewBlogState extends State<AddNewBlog> with TickerProviderStateMixin {
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
        title: const Text('Upload Blog'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 6.0,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.check),
            ),
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
                Text('Edit Blog'),
                Text('Preview'),
              ],
              controller: _tabController,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  EditBlog(),
                  BlogPreview(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
