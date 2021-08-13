int w=800, h=600;
int[] blank_position={2, 2};
String[][] board={{"A", "B", "C", "D"}, {"E", "F", "G", "H"}, {"I", "J", " ", "K"}};
int size=200;

void saveGame(){
  String[] saveBoard = new String[14];
  int i=0;
  for(int r=0; r<3; r++){
  for(int c=0; c<4; c++){
    saveBoard[i] = board[r][c];
    i++;
  }
  }
  saveBoard[12] = str(blank_position[0]);
  saveBoard[13] = str(blank_position[1]);
  saveStrings("data.txt", saveBoard);
}

void loadGame(){
  String[] loadBoard = loadStrings("data.txt");
  int i=0;
  for(int r=0; r<3; r++){
  for(int c=0; c<4; c++){
    board[r][c] = loadBoard[i];
    print(loadBoard[i]);
    if(loadBoard[i] == " "){
      blank_position[0]=r;
      blank_position[1]=c;
      println(r,c);
    }
    i++;
  }
  }
  blank_position[0] = int(loadBoard[12]);
  blank_position[1] = int(loadBoard[13]);
}


void setup(){
  size(800, 650);
  background(255);
  randomAlpha();
  File f = new File("data.txt");
  if(f.exists() && !f.isDirectory()){
	  loadGame();
  }
}

void draw(){
  createBoard();
  swapChar();
  if(checkWinner(board)){
    win_sceen();
  }
  saveGame();
}

void randomAlpha(){
  String buffer;
  for(int r=0; r<3; r++){
    for(int c=0; c<4; c++){
      int ranRow = int( random( 3 ) );
      int ranCol = int( random( 4 ) );
      buffer = board[r][c];
      board[r][c] = board[ranRow][ranCol];
      board[ranRow][ranCol] = buffer;
      if(board[ranRow][ranCol] == " "){
        blank_position[0] = ranRow;
        blank_position[1] = ranCol;
      }
    else if(board[r][c] == " "){
      blank_position[0] = r;
      blank_position[1] = c;
    }
    }
  }  
}

void createBoard(){
  background(255);
  int text_x=80, text_y=100;
  for(int r=0; r<3; r++){
    line(0, size*r, w, size*r);
    for(int c=0; c<4; c++){
      fill(0);
      textSize(70);
      text(board[r][c], text_x, text_y);
      text_x += size;
      line(size*c, 0, size*c, h);
    }
    text_y += size;
    text_x = 65;
  }
  textSize(30);
  text("SAVE", 360, 640);
}

void swapChar(){
  int block_x=0;
  int block_y=0;
  if(mousePressed == true){
      for(int r=0; r<3; r++){
        line(0, size*r, w, size*r);
        for(int c=0; c<4; c++){
          if(mouseX>block_x && mouseX<block_x+size && mouseY>block_y && mouseY<block_y+size){
            if(((r-1==blank_position[0]||r+1==blank_position[0]) && c==blank_position[1]) || ((c-1==blank_position[1]||c+1==blank_position[1]) &&r==blank_position[0])){
            board[blank_position[0]][blank_position[1]] = board[r][c];
            board[r][c] = " ";
            blank_position[0] = r;
            blank_position[1] = c;

            }
          }
          block_x += size;
        }
        block_x =0;
        block_y += size;
    }
  }
}

boolean checkWinner(String[][] board){
  String[][] boardWinner={{"A", "B", "C", "D"}, {"E", "F", "G", "H"}, {"I", "J", "K", " "}};
  for(int r=0; r<3; r++){
    for(int c=0; c<4; c++){
      if(board[r][c] != boardWinner[r][c]){
        return false;
      }
    }
  }
  return true;
}

void win_sceen(){
  if(checkWinner(board) == true){
    background(255);
    textSize(125);
    text("VICTORY", 130, 350);
  }
}
