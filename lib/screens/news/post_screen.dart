import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rewind/bloc/post_bloc.dart';
import 'package:flutter_rewind/data/models/post.dart';
import 'package:flutter_rewind/main.dart';
import 'package:flutter_rewind/widgets/my_text.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
  void initState()  {
    super.initState();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
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
    _postBloc = BlocProvider.of<PostBloc>(context);
    _postBloc.add(PostFetch());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostLoading && state.isFirstFetch) {
              return Center(
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
            } else if (state is PostError){
              posts = List<Post>.from(box.get('posts'));
              print('boxxxx: ${posts.length}');
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: LazyLoadScrollView(
                      onEndOfPage: () => _postBloc.add(PostFetch()),
                      child: ListView.separated(
                        // controller: _controller,
                        itemBuilder: (context, index) {
                          if (index < posts.length) {
                            return Row(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      'https://img1.hscicdn.com/image/upload/lsci/${posts[index].image}',
                                      width: 160,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )),
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      MyText(
                                        text: posts[index].title,
                                        maxLines: 2,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromRGBO(29, 26, 97, 1),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      MyText(
                                        text: posts[index].summary,
                                        maxLines: 2,
                                        color: Color.fromRGBO(29, 26, 97, 1),
                                        fontSize: 12,
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: MyText(
                                          text: DateFormat('MMMM dd, yyyy')
                                              .format(posts[index].modifiedAt),
                                          color: Color.fromRGBO(29, 26, 97, 1),
                                          fontSize: 12,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            );
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
                          return Divider(
                            color: Colors.grey,
                          );
                        },
                      ),
                    ),
                  ),
                  // if (state is PostLoading && !state.isFirstFetch)
                  //   const Padding(
                  //     padding: EdgeInsets.only(top: 10, bottom: 40),
                  //     child: Center(
                  //       child: CircularProgressIndicator(
                  //         color: Colors.amber,
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
