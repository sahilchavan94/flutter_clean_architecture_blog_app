import 'package:blog_app/core/common/cubits/cubit/current_user_cubit.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/features/blog/domain/entities/upload_blog_params.dart';
import 'package:blog_app/features/blog/presentation/blocs/blog/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/managers/edit_blog_manager.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_preview.dart';
import 'package:blog_app/features/blog/presentation/pages/edit_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

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
    return BlocConsumer<BlogBloc, BlogState>(
      listener: (context, state) {
        if (state is BlogSuccess) {
          Navigator.pop(context);
          context.read<BlogBloc>().add(
                BlogFetchBlogEvent(
                  uid: (context.read<CurrentUserCubit>().state
                          as CurrentUserDataFetched)
                      .userEntity
                      .uid,
                ),
              );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Blog uploaded successfully'),
            ),
          );
        }
        if (state is BlogFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (BuildContext context, BlogState state) {
        return Consumer<EditBlogManager>(
          builder: (context, editBlogManager, child) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Upload Blog'),
                centerTitle: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6.0,
                    ),
                    child: Visibility(
                      visible: state.runtimeType != BlogLoading,
                      child: IconButton(
                        onPressed: () {
                          final validationResult =
                              editBlogManager.validateBlog();
                          if (validationResult.isNotEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(validationResult),
                              ),
                            );
                            return;
                          }
                          final currentUserId = context
                              .read<CurrentUserCubit>()
                              .state as CurrentUserDataFetched;
                          final salt = const Uuid().v4();
                          context.read<BlogBloc>().add(
                                BlogUploadBlogEvent(
                                  uploadBlogParams: UploadBlogParams(
                                    uid: salt,
                                    posterId: currentUserId.userEntity.uid,
                                    blogTitle: editBlogManager.blogTitle.text,
                                    posterName:
                                        "${currentUserId.userEntity.firstname} ${currentUserId.userEntity.lastname}",
                                    posterImageUrl: currentUserId
                                        .userEntity.profileImageUrl,
                                    blogSubTitle:
                                        editBlogManager.blogSubTitle.text,
                                    blogContent:
                                        editBlogManager.blogContent.text,
                                    blogCategories:
                                        editBlogManager.blogCategories,
                                    imageFileList:
                                        editBlogManager.blogImageList,
                                  ),
                                ),
                              );
                        },
                        icon: const Icon(Icons.check),
                      ),
                    ),
                  ),
                ],
              ),
              body: BlocBuilder<BlogBloc, BlogState>(
                builder: (context, state) {
                  if (state is BlogLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is BlogFailure) {
                    return Center(
                      child: Column(
                        children: [
                          const Icon(
                            Icons.error_outline_outlined,
                            size: 50,
                            color: AppPallete.errorColor,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            state.message,
                            style: AppTheme
                                .darkThemeData.textTheme.displayLarge!
                                .copyWith(
                              fontSize: 17,
                            ),
                          )
                        ],
                      ),
                    );
                  }

                  return Container(
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
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
