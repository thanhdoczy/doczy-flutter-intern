// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rewind/bloc/post_bloc.dart';
import 'package:flutter_rewind/colors.dart';
import 'package:flutter_rewind/data/models/post.dart';
import 'package:flutter_rewind/main.dart';
import 'package:flutter_rewind/widgets/my_text.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late ScrollController _controller;
  var _postBloc;

  @override
  void initState() {
    super.initState();
    // _controller = ScrollController()..addListener(_loadMore);
    _controller = ScrollController();
    _postBloc = BlocProvider.of<PostBloc>(context);
    _postBloc.add(PostFetch());
  }

  @override
  void dispose() {
    // _controller.removeListener(_loadMore);
    _controller.dispose();
    super.dispose();
  }

  void _loadMore() {
    // if (_controller.position.extentAfter < 50) {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      print(_controller.position.extentAfter);
      _postBloc.add(PostFetch());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 25),
            child: IconButton(
                padding: EdgeInsets.zero,
                splashRadius: 24,
                onPressed: () {},
                icon: Image.asset(
                  'assets/images/icon_post.png',
                  width: 24,
                  height: 24,
                )),
          ),
          toolbarHeight: 57,
          title: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 25),
            child: MyText(
              text: 'My News',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 27.24 / 20,
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: <Color>[
                Color.fromRGBO(29, 26, 91, 1),
                Color.fromRGBO(24, 218, 184, 1),
              ], begin: Alignment.centerLeft, end: Alignment.centerRight),
            ),
          ),
        ),
        body: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostLoading && state.isFirstFetch) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.amber,
              ));
            }
            List<Post> posts = [];
            bool isLoading = false;
            if (state is PostLoading) {
              posts = state.oldPosts;
              isLoading = true;
              print('old posts: ${posts.length}');
            } else if (state is PostLoaded) {
              box.put('posts', state.posts);
              posts = state.posts;
              print('boxxxx: ${List<Post>.from(box.get('posts')).length}');
              print('loaded: ${posts.length}');
            } else if (state is PostError) {
              posts = List<Post>.from(box.get('posts'));
              print('boxxxx Error Length: ${posts.length}');
            }
            return PostBody(
                postBloc: _postBloc,
                controller: _controller,
                posts: posts,
                isLoading: isLoading);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: UpTopButton(
          controller: _controller,
        ));
  }
}

class PostBody extends StatelessWidget {
  const PostBody({
    Key? key,
    required postBloc,
    required ScrollController controller,
    required this.posts,
    required this.isLoading,
  })  : _postBloc = postBloc,
        _controller = controller,
        super(key: key);

  final _postBloc;
  final ScrollController _controller;
  final List<Post> posts;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 9, left: 9, right: 9),
      child: LazyLoadScrollView(
        onEndOfPage: () {
          print(_postBloc is PostError);
          (_postBloc is! PostError) ? _postBloc.add(PostFetch()) : null;
        },
        child: SingleChildScrollView(
          controller: _controller,
          clipBehavior: Clip.none,
          child: PostSlider(posts: posts, isLoading: isLoading),
        ),
      ),
    );
  }
}

class PostSlider extends StatelessWidget {
  const PostSlider({
    Key? key,
    required this.posts,
    required this.isLoading,
  }) : super(key: key);

  final List<Post> posts;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 30,
          alignment: Alignment.centerLeft,
          child: MyText(
            text: 'News',
            color: AppColors.textColor,
            fontWeight: FontWeight.w600,
            height: 19.07 / 14,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          // controller: _controller,
          itemBuilder: (context, index) {
            if (index < posts.length) {
              return PostCard(post: posts[index]);
            } else {
              return const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 40),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.amber,
                  ),
                ),
              );
            }
          },
          itemCount: posts.length + (isLoading ? 1 : 0),
          separatorBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12.5),
              child: Divider(
                thickness: 0.5,
                color: AppColors.textColor.withOpacity(0.3),
                indent: 10,
                endIndent: 12,
                height: 0,
              ),
            );
          },
        ),
      ],
    );
  }
}

class PostCard extends StatelessWidget {
  const PostCard({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 355,
        height: 110,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  'https://img1.hscicdn.com/image/upload/lsci/${post.image}',
                  width: 160.52,
                  height: 101.54,
                  fit: BoxFit.cover,
                  errorBuilder: (context, url, error) => Container(
                    width: 160.52,
                    height: 101.54,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: <Color>[Colors.black38, Colors.black12],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight)),
                  ),
                ),
              ),
              Positioned(
                right: 5.54,
                bottom: 5.54,
                child: Material(
                  color: Color.fromRGBO(254, 152, 12, 1),
                  shape: CircleBorder(),
                  child: InkWell(
                    onTap: () {},
                    customBorder: CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        'assets/images/icon_post_2.png',
                        width: 10,
                        height: 10,
                      ),
                    ),
                  ),
                ),
              )
            ]),
            SizedBox(
              width: 10.29,
            ),
            Expanded(
              child: Container(
                height: 107,
                child: Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 2,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {},
                          child: MyText(
                            text: post.title,
                            maxLines: 3,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textColor,
                            fontSize: 12,
                            height: 16.34 / 12,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        MyText(
                          text: post.summary,
                          maxLines: 2,
                          color: AppColors.textColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          height: 13.62 / 10,
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Spacer(),
                        Expanded(
                          child: MyText(
                            text: DateFormat('MMMM dd, yyyy')
                                .format(post.modifiedAt),
                            color: AppColors.textColor,
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class UpTopButton extends StatelessWidget {
  final ScrollController controller;
  const UpTopButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: CircleBorder(),
      onTap: () => {
        controller.animateTo(0,
            duration: Duration(milliseconds: 700), curve: Curves.ease)
      },
      child: Ink(
        height: 30,
        width: 30,
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.textColor.withOpacity(0.7)),
        child: Image.asset(
          'assets/images/icon_double_arrow_up.png',
          height: 16,
        ),
      ),
    );
  }
}
