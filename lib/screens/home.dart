import 'package:carousel_slider/carousel_slider.dart';
import 'package:clover_construction/constants/static_urls.dart';
import 'package:clover_construction/constants/theme.dart';
import 'package:clover_construction/providers/auth.dart';
import 'package:clover_construction/providers/store.dart';
import 'package:clover_construction/screens/auth.dart';
import 'package:clover_construction/screens/departments.dart';
import 'package:clover_construction/screens/hired_workers.dart';
import 'package:clover_construction/screens/orders.dart';
import 'package:clover_construction/screens/profile.dart';
import 'package:clover_construction/widgets/drawer_item.dart';
import 'package:clover_construction/widgets/store_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // late Future<Store> stores;
  var _isInit = true;
  bool _isLoading = false;
  bool _depPressed = false;

  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      _isLoading = true;
      Provider.of<Stores>(context).fetchStores().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    final storeItems = Provider.of<Stores>(context, listen: false).items;
    final recentStoreItems =
        Provider.of<Stores>(context, listen: false).reacentStores;
    final userData = Provider.of<AuthProvider>(context, listen: false).userInfo;
    final username = userData['username'];
    return Scaffold(
        // appBar: PreferredSize(
        //   child: CustomAppBar(
        //       title: 'Clover Constructions', date: DateTime.now()),
        //   preferredSize: Size.fromHeight(135.0),),
        appBar: AppBar(
          title: const Text(
            "Clover Construction",
          ),
          centerTitle: true,
          iconTheme: Theme.of(context).iconTheme,
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: const TextStyle(
              color: Colors.black87,
              fontFamily: "Lato-Bold",
              fontSize: 24.0,
              fontWeight: FontWeight.w700),
        ),
        drawer: Drawer(
          child: SingleChildScrollView(
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        width: 150,
                        height: 150,
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/Husky.jpg'),
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(userData['email']),
                      const SizedBox(
                        height: 3.0,
                      ),
                      Text(
                        username,
                        style: const TextStyle(
                            color: textHighlighter,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                DrawerItem(
                    icon: Icons.home,
                    title: "Home",
                    function: () {
                      Navigator.of(context)
                          .pushReplacementNamed(HomeScreen.routeName);
                    }),
                DrawerItem(
                    icon: Icons.home,
                    title: "Profile",
                    function: () {
                      Navigator.of(context).pushNamed(ProfileScreen.routeName);
                    }),
                DrawerItem(
                    icon: Icons.work,
                    title: "Hired Workers",
                    function: () {
                      Navigator.of(context).pop();
                      Navigator.of(context)
                          .pushNamed(HiredWorkerScreen.routeName);
                    }),
                DrawerItem(
                    icon: Icons.beenhere_rounded,
                    title: "Orders",
                    function: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(OrdersScreen.routeName);
                    }),
                DrawerItem(
                    icon: Icons.logout_rounded,
                    title: "Logout",
                    function: () {
                      Provider.of<AuthProvider>(context, listen: false)
                          .logout(userData['token'])
                          .then((_) => Navigator.of(context)
                              .popAndPushNamed(AuthScreen.routeName));
                    }),
              ],
            ),
          ),
        ),
        body: _depPressed == true
            ? const DepartmentScreen()
            : (_isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Welcome $username",
                                    style: const TextStyle(
                                        color: Colors.cyan,
                                        fontFamily: "Lato-Bold",
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: Image.asset(
                                      'assets/images/constructionWorker.png',
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(DateFormat.yMMMEd().format(DateTime.now()))
                            ],
                          ),
                        ),
                        CarouselSlider.builder(
                          itemCount: recentStoreItems.length,
                          itemBuilder: ((ctx, index, i) {
                            return SizedBox(
                              width: double.infinity,
                              child: Card(
                                elevation: 3,
                                child: Image.network(
                                  domain + recentStoreItems[index].imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }),
                          options: CarouselOptions(
                            height: 180,
                            initialPage: 0,
                            aspectRatio: 16 / 8,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            scrollDirection: Axis.horizontal,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "Stores",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: storeItems.length,
                            itemBuilder: (ctx, index) => StoreItem(
                              id: storeItems[index].id,
                              title: storeItems[index].title,
                              address: storeItems[index].address,
                              contact: storeItems[index].contact,
                              image: storeItems[index].imageUrl,
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _depPressed = !_depPressed;
            });
          },
          backgroundColor: secondaryColor,
          child: _depPressed == false
              ? const Icon(Icons.work_outline_rounded)
              : const Icon(Icons.hardware),
        ));
  }
}
