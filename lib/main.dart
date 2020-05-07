import 'package:flutter/material.dart';
import 'package:quizzlersapp/question_bank.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int score = 0;
  static bool queFinish = false;
  int questionNo = 0;
  List<Widget> scoreKeeper = [];

  void showDialog() {
    Alert(
        title: 'Restart',
        desc: 'Your current score is $score',
        buttons: [
          DialogButton(
            child: Text(
              'ok',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              restartGame();
              Navigator.pop(context);
            },
          )
        ],
        context: context)
        .show();
  }

  void iconSetter(bool points) {
    if (points) {
      setState(() {
        scoreKeeper.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
      });
    } else {
      setState(() {
        scoreKeeper.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
      });
    }
  }

  void checkAnswer(bool ans) {
    if (queFinish) {
      showDialog();
    }
    if (!queFinish) {
      if (ans == QuestionClassBank.questions[questionNo].questionAnswer) {
        score += 1;
        iconSetter(true);
      } else {
        iconSetter(false);
      }
      if (questionNo < QuestionClassBank.questions.length - 1) {
        setState(() {
          questionNo = questionNo + 1;
        });
      } else {
        queFinish = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                QuestionClassBank.questions[questionNo].questionText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(false);
              },
            ),
          ),
        ),
        //TODO: Add a Row here as your score keeper
        Row(children: scoreKeeper)
      ],
    );
  }

  void restartGame() {
    setState(() {
      scoreKeeper.clear();
      questionNo = 0;
      queFinish = false;
      score = 0;
    });
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
