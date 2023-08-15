import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String playerX = '';
  String playerO = '';
  bool _isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Welcome to Tic Tac Toe'),
        ),
        backgroundColor: Color.fromARGB(255, 37, 35, 37),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://images.pexels.com/photos/12389878/pexels-photo-12389878.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter name for Player X',
                        filled: true,
                        fillColor: Color.fromARGB(255, 23, 187, 89),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        playerX = value;
                      },
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter name for Player O',
                        filled: true,
                        fillColor: Color.fromARGB(255, 23, 187, 89),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        playerO = value;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTapDown: (details) {
                  setState(() {
                    _isButtonPressed = true;
                  });
                },
                onTapUp: (details) {
                  setState(() {
                    _isButtonPressed = false;
                  });
                },
                child: Transform.scale(
                  scale: _isButtonPressed ? 1.3 : 1.5,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TicTacToe(
                                  playerX: playerX,
                                  playerO: playerO,
                                )),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 12, 66, 75),
                    ),
                    child: Text('Let\'s Play'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TicTacToe extends StatefulWidget {
  final String playerX;
  final String playerO;

  TicTacToe({required this.playerX, required this.playerO});

  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<List<String>> _board = List.generate(3, (i) => List.filled(3, ''));
  bool _isXTurn = true;
  String _winner = '';
  int _scoreX = 0; // Score for Player X
  int _scoreO = 0; // Score for Player O

  void _onTap(int row, int col) {
    if (_board[row][col] != '' || _winner != '') return;

    setState(() {
      _board[row][col] = _isXTurn ? 'X' : 'O';
      _isXTurn = !_isXTurn;
    });

    _checkWinner();

    if (_winner == '' && _checkDraw()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Game Over'),
          content: Text('It\'s a draw!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetGame();
              },
              child: Text('Play Again'),
            ),
          ],
        ),
      );
    }
  }
  void _checkWinner() {
    for (int i = 0; i < 3; i++) {
      if (_board[i][0] == _board[i][1] &&
          _board[i][1] == _board[i][2] &&
          _board[i][0] != '') {
        _winner = _board[i][0];
      }
      if (_board[0][i] == _board[1][i] &&
          _board[1][i] == _board[2][i] &&
          _board[0][i] != '') {
        _winner = _board[0][i];
      }
    }
    if (_board[0][0] == _board[1][1] &&
        _board[1][1] == _board[2][2] &&
        _board[0][0] != '') {
      _winner = _board[0][0];
    }
    if (_board[0][2] == _board[1][1] &&
        _board[1][1] == _board[2][0] &&
        _board[0][2] != '') {
      _winner = _board[0][2];
    }

    if (_winner == 'X') {
      _scoreX++;
    } else if (_winner == 'O') {
      _scoreO++;
    }

    if (_winner != '') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Game Over'),
          content: Text('Player $_winner won!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetGame();
              },
              child: Text('Play Again'),
            ),
          ],
        ),
      );
    }
}

  
  bool _checkDraw() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (_board[i][j] == '') {
          return false;
        }
      }
    }
    return true;
  }

  void _restartGame() {
    setState(() {
      _board = List.generate(3, (i) => List.filled(3, ''));
      _isXTurn = true;
      _winner = '';
       _scoreX = 0;
      _scoreO = 0;
    });
  }
  void _resetGame() {
    setState(() {
      _board = List.generate(3, (i) => List.filled(3, ''));
      _isXTurn = true;
      _winner = '';
      //  _scoreX = 0;
      // _scoreO = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Tic Tac Toe')),
        backgroundColor: Color(0xFF8B0000),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                  "https://images.pexels.com/photos/2604929/pexels-photo-2604929.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
              'Player ${widget.playerX}: $_scoreX',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Player ${widget.playerO}: $_scoreO',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
              for (int i = 0; i < 3; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int j = 0; j < 3; j++)
                      GestureDetector(
                        onTap: () => _onTap(i, j),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                          ),
                          child: Center(
                            child: Text(
                              _board[i][j],
                              style: TextStyle(
                                fontSize: 24,
                                color: _board[i][j] == 'X'
                                    ? Colors.blue
                                    : Color.fromARGB(255, 229, 255, 0),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _restartGame,
                child: Text('Reset Game'),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 12, 66, 75),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
