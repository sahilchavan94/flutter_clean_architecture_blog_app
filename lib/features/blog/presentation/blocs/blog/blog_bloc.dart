import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/entities/upload_blog_params.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blog.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog_images.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta/meta.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogImagesUseCase _uploadBlogImagesUseCase;
  final UploadBlogUseCase _uploadBlogUseCase;
  final GetAllBlogUseCase _getAllBlogUseCase;
  BlogBloc(
    this._uploadBlogImagesUseCase,
    this._uploadBlogUseCase,
    this._getAllBlogUseCase,
  ) : super(BlogInitial()) {
    on<BlogUploadBlogEvent>(_blogUploadBlogImageEvent);
    on<BlogFetchBlogEvent>(_blogFetchBlogEvent);
  }

  FutureOr<void> _blogUploadBlogImageEvent(
      BlogUploadBlogEvent event, Emitter<BlogState> emit) async {
    //uploading the images to the firebase storage
    emit(BlogLoading());
    List<File?> imageList = event.uploadBlogParams.imageFileList;
    imageList = imageList.filter((e) => e != null).toList();

    final response = await _uploadBlogImagesUseCase.call(
      imageList,
      event.uploadBlogParams.uid,
    );
    if (response.isRight()) {
      final imageList2 = response.getOrElse((l) => []);
      if (imageList.isEmpty) {
        emit(
          BlogFailure(message: 'Something went wrong'),
        );
      } else {
        final res2 = await _uploadBlogUseCase.call(
          event.uploadBlogParams.uid,
          event.uploadBlogParams.posterId,
          event.uploadBlogParams.posterName,
          event.uploadBlogParams.posterImageUrl,
          event.uploadBlogParams.blogTitle,
          event.uploadBlogParams.blogSubTitle,
          event.uploadBlogParams.blogContent,
          event.uploadBlogParams.blogCategories,
          imageList2,
        );
        if (res2.isRight()) {
          emit(BlogSuccess());
        } else {
          emit(
            BlogFailure(message: 'Something went wrong'),
          );
        }
      }
    }
  }

  FutureOr<void> _blogFetchBlogEvent(
      BlogFetchBlogEvent event, Emitter<BlogState> emit) async {
    emit(BlogGetAllBlogLoading());
    final response = await _getAllBlogUseCase.call();
    response.fold(
      (l) {
        emit(
          BlogGetAllBlogFailure(message: 'Something went wrong'),
        );
      },
      (r) {
        //filter the blog list
        List<BlogEntity> blogList = r.filter(
          (e) {
            return e.posterId != event.uid;
          },
        ).toList();
        List<BlogEntity> personalBlogs = r.filter(
          (e) {
            return e.posterId == event.uid;
          },
        ).toList();
        emit(
          BlogGetAllBlogSuccess(
            blogList: blogList,
            personalBlogs: personalBlogs,
          ),
        );
      },
    );
  }
}
