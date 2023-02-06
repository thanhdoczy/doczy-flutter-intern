import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rewind/colors.dart';
import 'package:flutter_rewind/data/models/category.dart';
import 'package:flutter_rewind/data/models/podcast.dart';
import 'package:flutter_rewind/screens/favorite/favorite_screen.dart';
import 'package:flutter_rewind/widgets/category_slider.dart';
import 'package:flutter_rewind/widgets/my_text.dart';
import 'package:flutter_rewind/widgets/podcast_slider.dart';

class HomeScreen extends StatefulWidget {
  static List<Category> categories = [
    Category('Education', Color.fromRGBO(241, 39, 17, 1),
        Color.fromRGBO(245, 175, 25, 1)),
    Category('Society', Color.fromRGBO(98, 61, 239, 1),
        Color.fromRGBO(52, 15, 209, 1)),
    Category('Sports', Color.fromRGBO(67, 239, 29, 1),
        Color.fromRGBO(13, 128, 242, 1)),
    Category('Films', Color.fromRGBO(233, 34, 141, 1),
        Color.fromRGBO(241, 39, 17, 1)),
    Category('Politics', Color.fromRGBO(51, 51, 179, 1),
        Color.fromRGBO(0, 212, 255, 1)),
  ];
  static List<PodCast> podcasts = [
    PodCast('The Year in Mograph - 2020', 'assets/images/pod_1.png',
        DateTime(2022, 12, 30), '211'),
    PodCast('Episode 197: The World of Lettering', 'assets/images/pod_2.png',
        DateTime(2020, 12, 2), '42'),
    PodCast('How to Create Youtube Video Ads That Convert',
        'assets/images/pod_3.png', DateTime(2022, 12, 18), '52'),
    PodCast('Airbnb\'s Brian Chesky: Designing for trust',
        'assets/images/pod_4.png', DateTime(2021, 12, 15), '46'),
    PodCast('Sounds Worth Saving', 'assets/images/pod_5.png',
        DateTime(2022, 12, 09), '125'),
  ];
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 3) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => FavoriteScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0.0,
        title: Text(
          'Welcome John Doe',
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(8),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                height: 40,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(34, 43, 69, 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    MyText(
                      text: 'Search',
                      color: Color.fromRGBO(143, 155, 179, 1),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              CategorySlider(
                title: 'Categories',
                categories: HomeScreen.categories,
              ),
              SizedBox(
                height: 30,
              ),
              PodCastSlider(
                route: '/',
                title: 'Best Podcast Episodes',
                podcasts: HomeScreen.podcasts,
              ),
              SizedBox(
                height: 30,
              ),
              PodCastSlider(
                route: '/',
                title: 'Recommended For You',
                podcasts: HomeScreen.podcasts,
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //     backgroundColor: AppColors.themeBackGround,
      //     selectedItemColor: Color.fromARGB(255, 211, 39, 85),
      //     unselectedItemColor: Colors.grey[400],
      //     showSelectedLabels: false,
      //     showUnselectedLabels: false,
      //     onTap: onTapNav,
      //     currentIndex: _selectedIndex,
      //     selectedFontSize: 0,
      //     unselectedFontSize: 0,
      //     type: BottomNavigationBarType.fixed,
      //     items: [
      //       const BottomNavigationBarItem(
      //         label: 'Home',
      //         icon: Icon(Icons.apps),
      //       ),
      //       const BottomNavigationBarItem(
      //         label: 'Search',
      //         icon: Icon(Icons.manage_search_rounded),
      //       ),
      //       const BottomNavigationBarItem(
      //         label: 'Bag',
      //         icon: Icon(Icons.shopping_bag_outlined),
      //       ),
      //       const BottomNavigationBarItem(
      //         label: 'Saved',
      //         icon: Icon(Icons.favorite_outline_rounded),
      //       ),
      //       const BottomNavigationBarItem(
      //         label: 'Person',
      //         icon: Icon(Icons.person_outline_rounded),
      //       ),
      //     ]),
    );
  }
}
