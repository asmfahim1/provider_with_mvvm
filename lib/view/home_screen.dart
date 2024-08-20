import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_with_mvvm/data/response/status.dart';
import 'package:provider_with_mvvm/view_model/home_view_model.dart';
import 'package:provider_with_mvvm/view_model/user_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  HomeViewModel homeViewModel = HomeViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeViewModel.getMovieListFromApi();

  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              userViewModel.clearSession();
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: ChangeNotifierProvider<HomeViewModel>(
        create: (BuildContext context) => homeViewModel,
        child: Consumer<HomeViewModel>(
          builder: (context, value, _) {
            switch(value.movieList.status){
              case Status.LOADING :
                return Center(child: CircularProgressIndicator());
              case Status.ERROR :
                return Center(child: Text('${value.movieList.message}'));
              case Status.COMPLETED:
                return ListView.builder(
                  itemCount: value.movieList.data!.movies!.length,
                    itemBuilder: (context, index){
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: ListTile(
                      title: Text(value.movieList.data!.movies![index].title.toString()),
                      subtitle: Text(value.movieList.data!.movies![index].title.toString()),
                    ),
                  );
                });
              case null:
                // TODO: Handle this case.
            }
            return ListView();
          },
        ),
      ),
    );
  }
}
