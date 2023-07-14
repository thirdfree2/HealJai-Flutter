import "package:flutter/material.dart";
import "package:flutter_application_1/utils/global.colors.dart";
import "package:flutter_application_1/view/widgets/emoticon.face.dart";
import "package:flutter_application_1/view/widgets/exercises.view.dart";

class IndexView extends StatelessWidget {
  const IndexView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
      ]),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 30, 25, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, Jisoo!',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '23 Jan, 2021',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: GlobalColors.appbarColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: const Icon(
                          Icons.notifications,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: GlobalColors.appbarColor,
                        borderRadius: BorderRadius.circular(12)),
                    padding: EdgeInsets.all(12),
                    child: const Row(children: [
                      Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Search',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'How do you feel?',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                        ),
                      ),
                      Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      EmotionFaceView(
                        emotionFace: 'Worry',
                      ),
                      EmotionFaceView(
                        emotionFace: 'Bad',
                      ),
                      EmotionFaceView(
                        emotionFace: 'Sad',
                      ),
                      EmotionFaceView(
                        emotionFace: 'Crazy',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(25),
                color: Colors.grey[300],
                child: Center(
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Excercises',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Icon(Icons.more_horiz),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            ExercisesView(
                              colorProfile: Colors.lightBlue,
                              icon: Icons.account_box,
                              doctorName: 'Dr. Sirikanya Onthetraps',
                              typeOffelling: 'Education Problem',
                            ),
                            ExercisesView(
                              colorProfile: Colors.lightGreen,
                              icon: Icons.account_box,
                              doctorName: 'Dr. Panyawut Keawomp',
                              typeOffelling: 'Love Problem',
                            ),
                            ExercisesView(
                              colorProfile: Colors.deepOrange,
                              icon: Icons.account_box,
                              doctorName: 'Dr. Nokia Wasuwan',
                              typeOffelling: 'Family Problem',
                            ),
                            ExercisesView(
                              colorProfile: Color.fromARGB(255, 27, 46, 56),
                              icon: Icons.account_box,
                              doctorName: 'Dr. Chanchai Pengbusom',
                              typeOffelling: 'All Problem',
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
