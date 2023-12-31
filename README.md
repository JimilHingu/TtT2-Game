��#   T t T 2 - G a m e 
 
 1. Imports and Initialization:
The necessary Flutter packages are imported.
The main() function initializes the Flutter app and sets the system UI mode to immersive before running the MyApp widget.
2. Main App Widget:
MyApp is a stateless widget that returns a MaterialApp with the home set to HomePage.
The debug banner is disabled for a cleaner UI.
3. Home Page:
HomePage is a stateful widget that serves as the landing page.
The state (_HomePageState) contains variables for player names (playerX and playerO) and a boolean to track button press state (_isButtonPressed).
The UI consists of an app bar with a welcome message and a body with a background image.
Two text fields allow players to enter their names.
A button navigates to the TicTacToe game page, passing the player names as arguments.
4. Tic Tac Toe Game Page:
TicTacToe is a stateful widget that receives player names as arguments.
The state (_TicTacToeState) contains:
A 3x3 board represented as a list of lists.
Variables to track the current player's turn, the winner, and scores for both players.
The _onTap function handles cell taps, updates the board, and checks for a winner or a draw.
The _checkWinner function checks for winning conditions in rows, columns, and diagonals.
The _checkDraw function checks if all cells are filled without a winner, indicating a draw.
The _restartGame function resets the game board, scores, and other game-related variables.
The _resetGame function only resets the game board and the current player's turn without affecting the scores.
The UI displays the players' scores, a 3x3 grid for the game board, and a button to reset the game.
5. UI Styling:
The game uses custom colors, background images, and other styling elements to enhance the user experience.
The game board cells change color based on the player's move ('X' or 'O').
