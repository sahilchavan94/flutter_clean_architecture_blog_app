import 'package:blog_app/core/common/cubits/cubit/current_user_cubit.dart';
import 'package:blog_app/core/common/widgets/custom_blog_widget.dart';
import 'package:blog_app/core/common/widgets/custom_error_widget.dart';
import 'package:blog_app/features/blog/presentation/blocs/blog/blog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopBlogsWidget extends StatefulWidget {
  const TopBlogsWidget({super.key});

  @override
  State<TopBlogsWidget> createState() => _TopBlogsWidgetState();
}

class _TopBlogsWidgetState extends State<TopBlogsWidget> {
  @override
  void initState() {
    context.read<BlogBloc>().add(
          BlogFetchBlogEvent(
            uid: (context.read<CurrentUserCubit>().state
                    as CurrentUserDataFetched)
                .userEntity
                .uid,
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlogBloc, BlogState>(
      builder: (context, state) {
        if (state is BlogGetAllBlogLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is BlogGetAllBlogFailure) {
          return const CustomErrorWidget();
        }
        if (state is BlogGetAllBlogSuccess) {
          if (state.blogList.isEmpty) {
            return const CustomErrorWidget(
              message: 'No Blogs added yet',
            );
          }
          return ListView.builder(
            itemCount: state.blogList.length,
            itemBuilder: (context, index) {
              return CustomBlogWidget(
                blogEntity: state.blogList[index],
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
