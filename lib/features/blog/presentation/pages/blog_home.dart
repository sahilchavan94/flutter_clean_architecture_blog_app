import 'package:blog_app/core/common/cubits/cubit/current_user_cubit.dart';
import 'package:blog_app/core/common/cubits/managers/theme_manager.dart';
import 'package:blog_app/core/common/widgets/custom_error_widget.dart';
import 'package:blog_app/core/common/widgets/custom_image_view.dart';
import 'package:blog_app/core/strings/strings.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/presentation/blocs/favs/bloc/favs_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog.dart';
import 'package:blog_app/features/blog/presentation/widgets/fav_blogs_widget.dart';
import 'package:blog_app/features/blog/presentation/widgets/top_blogs_widget.dart';
import 'package:blog_app/features/profile/presentation/pages/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class BlogHome extends StatefulWidget {
  const BlogHome({super.key});

  @override
  State<BlogHome> createState() => _BlogHomeState();
}

class _BlogHomeState extends State<BlogHome> with TickerProviderStateMixin {
  late TabController _tabController;

  checkConnection() async {
    final res = await InternetConnectionChecker().hasConnection;
    if (!res) {
      _tabController.index = 1;
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.noInternetString),
        ),
      );
    }
  }

  @override
  void initState() {
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    checkConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is AuthSuccess) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 65,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Flutterblogs',
                        style: AppTheme.darkThemeData.textTheme.displayLarge!
                            .copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 23.5,
                          color: context.watch<ThemeManager>().currentTheme ==
                                  'dark'
                              ? Colors.white
                              : AppPallete.primaryLightColor,
                        ),
                      ),
                    ],
                  ),
                  // Text(
                  //   textAlign: TextAlign.start,
                  //   AppStrings.homePageString,
                  //   style:
                  //       AppTheme.darkThemeData.textTheme.displaySmall!.copyWith(
                  //     color: Theme.of(context).brightness == Brightness.dark
                  //         ? AppPallete.grayLight
                  //         : AppPallete.grayDark,
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.w300,
                  //   ),
                  // ),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddNewBlog(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add_circle),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileView(),
                      ),
                    );
                  },
                  icon: BlocBuilder<CurrentUserCubit, CurrentUserState>(
                    builder: (context, state) {
                      if (state is CurrentUserDataFetched) {
                        return CustomImageView(
                          width: 24,
                          height: 24,
                          fit: BoxFit.cover,
                          radius: BorderRadius.circular(20),
                          imagePath: (context.read<CurrentUserCubit>().state
                                  as CurrentUserDataFetched)
                              .userEntity
                              .profileImageUrl,
                        );
                      }
                      return const CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(
                          "https://www.gokulagro.com/wp-content/uploads/2023/01/no-images.png",
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            body: Container(
              padding: const EdgeInsets.all(2.5),
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
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        BlocConsumer<FavsBloc, FavsState>(
                          listener: (context, favState) {
                            if (favState is FavsAddToFavsSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Successfully added to favourites'),
                                ),
                              );
                            }
                            if (favState is FavsAddToFavsFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(favState.msg),
                                ),
                              );
                            }
                          },
                          builder: (BuildContext context, FavsState state) {
                            return const TopBlogsWidget();
                          },
                        ),
                        const FavouriteBlogs(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return const Scaffold(
          body: CustomErrorWidget(
            message: 'Unable to fetch the user profile',
          ),
        );
      },
    );
  }
}
