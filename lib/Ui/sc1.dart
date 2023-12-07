import 'package:demo1/Bloc/anime_bloc.dart';
import 'package:demo1/repostory/modelclass/AnimeModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class sc1 extends StatefulWidget {
  const sc1({super.key});

  @override
  State<sc1> createState() => _sc1State();
}

late AnimeModel data;

class _sc1State extends State<sc1> {
  @override
  void initState() {
    BlocProvider.of<AnimeBloc>(context).add(FetchAnime());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<AnimeBloc, AnimeState>(
        builder: (context, state) {
          if (state is AnimeblocLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AnimeblocError) {
            return Center(child: Text("Error!"));
          }
          if (state is AnimeblocLoaded) {
            data = BlocProvider.of<AnimeBloc>(context).animeModel;
            return ListView.separated(
              padding: EdgeInsets.only(top: 60),
              itemCount: data.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    width: 150,
                    height: 150,
                    color: Colors.grey,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 25,
                        ),
                        Image.network(
                          data.data![index].image.toString(),
                          width: 100,
                          height: 100,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [SizedBox(height: 20,),
                            Text(
                              data.data![index].title.toString(),
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              data.data![index].episodes.toString(),
                              style: TextStyle(fontWeight: FontWeight.w400),
                            )
                          ],
                        )
                      ],
                    ));
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 5,
                );
              },
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
