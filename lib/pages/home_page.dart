import 'package:book_app/components/app_search_box.dart';
import 'package:book_app/notifiers/app_book_explore.dart';
import 'package:book_app/pages/book_show/status_book.dart';
import 'package:book_app/services/book_services.dart';
import 'package:book_app/themes/app_colors.dart';
import 'package:book_app/utils/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Status {
  fiction,
  animeManga,
  actionAdventure,
  novel,
  horror,
}

class HomePageWrapper extends StatelessWidget {
  const HomePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExploreProvider(
        context.read<BookService>(),
      )..loadMoreBooks(),
      child: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: Status.values.length,
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ExploreProvider>().initTabController(_tabController);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: Text(
                    "Book Store",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              ),
              SliverAppBar(
                backgroundColor: AppColors.bgColor,
                flexibleSpace: const AppSearchBox(),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0)
                      .copyWith(bottom: 10.0),
                  child: Text(
                    "Top Sellers",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                floating : true,
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: AppColors.primaryC,
                      border: Border.all(
                        color: AppColors.discount,
                        width: 1.2,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    tabAlignment: TabAlignment.center,
                    indicatorColor: Colors.transparent,
                    labelStyle:  TextStyle(
                      color: AppColors.textColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                    ),
                    unselectedLabelStyle: TextStyle(
                      color: AppColors.grey.withOpacity(0.7),
                    ),
                    tabs: Status.values.map((status) {
                      return Tab(
                        height: 50.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 10.0,
                          ),
                          child: Text(
                            status.tabLabel,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: List.generate(
              Status.values.length,
              (index) => const CategoriesPage(),
            ),
          ),
        ),
      ),
    );
  }

}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: _tabBar.preferredSize.height,
      color: AppColors.bgColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}