import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rewind/bloc/favorite_bloc.dart';
import 'package:flutter_rewind/colors.dart';
import 'package:flutter_rewind/data/models/post.dart';
import 'package:flutter_rewind/data/services/favorite_podcast_service.dart';
import 'package:flutter_rewind/screens/favorite/favorite_screen2.dart';
import 'package:flutter_rewind/screens/home/home_screen.dart';
import 'package:flutter_rewind/theme.dart';
import 'package:flutter_rewind/widgets/my_text.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box box;
late Box box2;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PostAdapter());
  // Hive.registerAdapter(PodCastAdapter());
  box = await Hive.openBox('posts');
  // box2 = await Hive.openBox('favorites');
  // box2.clear();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => FavoritePodCastService())
      ],
      child: BlocProvider(
        create: (context) =>
            FavoriteBloc(RepositoryProvider.of<FavoritePodCastService>(context))
              ..add(RegisterServiceFavoriteEvent()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: theme(),
          // home: RepositoryProvider(
          //   create: (context) => PostRepository(PostService()),
          //   child: BlocProvider(
          //     create: (context) => PostBloc(RepositoryProvider.of<PostRepository>(context)),
          //     child: const PostScreen(),
          //   ),
          // ),
          home: const MainScreen(),
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        if (state is FavoriteRegisterService || state is FavoriteLoaded) {
          BlocProvider.of<FavoriteBloc>(context).add(FetchFavoriteEvent());

          return CupertinoTabScaffold(
              tabBar: CupertinoTabBar(
                  backgroundColor: AppColors.themeBackGround,
                  activeColor: Color.fromARGB(255, 222, 36, 86),
                  inactiveColor: Colors.grey.shade400,
                  iconSize: 26,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.apps,
                      ),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.local_fire_department_outlined),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.explore_outlined),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_outline_rounded),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline_rounded),
                    ),
                  ]),
              tabBuilder: (context, index) {
                return CupertinoTabView(builder: (context) {
                  switch (index) {
                    case 0:
                      return CupertinoPageScaffold(child: HomeScreen());
                    case 1:
                      return CupertinoPageScaffold(
                        child: Center(
                          child: MyText(text: 'Trend Screen'),
                        ),
                      );
                    case 2:
                      return CupertinoPageScaffold(
                        child: Center(
                          child: MyText(text: 'Explore Screen'),
                        ),
                      );
                    case 3:
                      return CupertinoPageScaffold(child: FavoriteScreen2());
                    case 4:
                      return CupertinoPageScaffold(
                        child: Center(
                          child: MyText(text: 'Profile Screen'),
                        ),
                      );
                    default:
                      return CupertinoPageScaffold(child: HomeScreen());
                  }
                });
              });
        }
        return Container();
      },
    );
  }
}
// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Home Page'),
//       ),
//       body: Container(
//         margin: const EdgeInsets.all(8),
//         padding: const EdgeInsets.all(8),
//         height: 300,
//         decoration: BoxDecoration(
//           color: Colors.amber,
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: <BoxShadow>[
//             BoxShadow(
//               color: Colors.black26,
//               offset: Offset(0, 5),
//             ),
//             BoxShadow(
//               color: Colors.blueGrey,
//               offset: Offset(-5, -5),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Container(
//               width: 30,
//               height: 30,
//               color: Colors.red,
//             ),
//             Container(
//               width: 30,
//               height: 30,
//               color: Colors.blue,
//             ),
//             Container(
//               width: 30,
//               height: 30,
//               color: Colors.green,
//             ),
//             Container(
//               width: 120,
//               color: Colors.cyan,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Container(
//                     height: 30,
//                     width: 30,
//                     color: Colors.purple,
//                   ),
//                   Text(
//                     'This is textThis is textThis is textThis is text',
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 1,
//                     style: TextStyle(
//                         fontSize: 20,
//                         backgroundColor: Colors.black26,
//                         color: Colors.white70,
//                         fontWeight: FontWeight.bold),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
