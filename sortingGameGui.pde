int w=800, h=600;
int[] blank_position={2, 2};
char[][] board={ {'A','B','C','D'},{'E','F','G','H'},{'I','J',' ','K'}};
int size=200;
boolean check=true;
Table table;
String filename = "gamesave.xml";
XML xml;
 
void SaveGame(String filename) {
  String data = "<SortingGame>" + "<Alphabet><Row1>" + board[0][0] + board[0][1] + board[0][2] + board[0][3] + "</Row1><Row2>" +  board[1][0] + board[1][1] + board[1][2] + board[1][3] + "</Row2><Row3>"+  board[2][0] + board[2][1] + board[2][2] + board[2][3] + "</Row3></Alphabet></SortingGame>";
  xml = parseXML(data);
  saveXML(xml,filename);
  exit();
}

void LoadGame(String filename) {
    final XML xml = loadXML(filename);
    XML Alphabet = xml.getChildren("Alphabet")[0];
    String[] row = {Alphabet.getChildren("Row1")[0].getContent(),Alphabet.getChildren("Row2")[0].getContent(),Alphabet.getChildren("Row3")[0].getContent()};
    int i = 0;
    for (int y = 0;y < 3;y++) {
        for (int x = 0;x < 4;x++) {
            board[y][x] = row[i].charAt(0);
            if(board[y][x]== ' '){
              blank_position[0]=y;
              blank_position[1]=x;
            }
            i++;
        }
    }
}

void setup(){
  size(800, 650);
  background(255);
  randomAlpha();
  check = true;
}

void draw(){
  if(check){
    WScreen();
  }
  else{
    createBoard();
    swapChar();
    if(checkWinner(board)){
      win_sceen();
    }
  }
}

void WScreen(){
  String[] loadBoard = loadStrings(filename);
  String[] br = split(loadBoard[0],',');
  byte[] saveBoard = {' '};
  background(255);
  if(br.length < 10){
    textSize(40);
    fill(50);
    text("New Game", w/2-100, h/2+30);
    if(mouseX > w/2-100 && mouseX < w/2+100 && mouseY > h/2 && mouseY < h/2+30){
      fill(0, 100, 200);
      text("New Game", w/2-100, h/2+30);
      if(mousePressed == true){
        randomAlpha();
        check = false;
        clear();
        redraw();
      }
    }  
  }
  else{
    textSize(40);
    fill(0);
    text("You have saved game", 90, 220);
    textSize(50);
    text("Do you want to continue?", 90, 270);
    textSize(30);
    if(mouseX > 150 && mouseX < 350 && mouseY > 300 && mouseY < 350){
      fill(50);
      text("No, New Game", 400, 350);
      fill(0, 100, 200);
      text("Yes, Continue", 150, 350);
      if(mousePressed == true){
        LoadGame(filename);
        check = false;
        clear();
        redraw();
      }
    }
    else if(mouseX > 400 && mouseX < 600 && mouseY > 300 && mouseY < 350){
      fill(0, 100, 200);
      text("No, New Game", 400, 350);
      fill(50);
      text("Yes, Continue", 150, 350);
      if(mousePressed == true){
        saveBytes(filename, saveBoard);
        randomAlpha();
        check = false;
        clear();
        redraw();
      }
    }
    else{
      fill(50);
      text("Yes, Continue", 150, 350);
      text("No, New Game", 400, 350);
    }
  }
}

void randomAlpha(){
  char buffer;
  for(int r=0; r<3; r++){
    for(int c=0; c<4; c++){
      int ranRow = int( random( 3 ) );
      int ranCol = int( random( 4 ) );
      buffer = board[r][c];
      board[r][c] = board[ranRow][ranCol];
      board[ranRow][ranCol] = buffer;
      if(board[ranRow][ranCol] == ' '){
        blank_position[0] = ranRow;
        blank_position[1] = ranCol;
      }
      else if(board[r][c] == ' '){
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
  line(800, 600, 0, 600);
  line(400, 650, 400, 600);
  text("SAVE and QUIT", 90, 640);
  text("QUIT", 570, 640);
}

void swapChar(){
  int block_x=0;
  int block_y=0;
  byte[] saveBoard = {' '};
  if(mousePressed == true){
      for(int r=0; r<3; r++){
        line(0, size*r, w, size*r);
        for(int c=0; c<4; c++){
          if(mouseX>block_x && mouseX<block_x+size && mouseY>block_y && mouseY<block_y+size){
            if(((r-1==blank_position[0]||r+1==blank_position[0]) && c==blank_position[1]) || ((c-1==blank_position[1]||c+1==blank_position[1]) &&r==blank_position[0])){
              board[blank_position[0]][blank_position[1]] = board[r][c];
              board[r][c] = ' ';
              blank_position[0] = r;
              blank_position[1] = c;
            }
          }
          if(mouseX>0 && mouseX<400 && mouseY>600 && mouseY<650){
            SaveGame(filename);
          }
          if(mouseX>400 && mouseX<800 && mouseY>600 && mouseY<650){
            saveBytes(filename, saveBoard);
            exit();
          }
          block_x += size;
        }
        block_x =0;
        block_y += size;
    }
  }
}

boolean checkWinner(char[][] board){
  char[][] boardWinner = { {'A','B','C','D'},{'E','F','G','H'},{'I','J','K',' '}};  
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
