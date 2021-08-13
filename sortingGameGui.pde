int w=800, h=600;
int[] blank_position={2, 2};
char[][] board={{'A', 'B', 'C', 'D'}, {'E', 'F', 'G', 'H'}, {'I', 'J', ' ', 'K'}};
//char[][] board[3][4];
int size=200;
boolean firsttime = true;
int[] Space = {0,0};

void setup(){
  size(800, 600);
  background(255);
  textSize(100);
}

void draw(){
  if(firsttime){
    randomAlpha();
    firsttime = false;
  }
  createBoard();
  swapChar();
  if(checkWinner(board)){
    win_sceen();
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
    }
  }  
}

void createBoard(){
  background(255);
  int text_x=70, text_y=140;
  for(int r=0; r<3; r++){
    line(0, size*r, w, size*r);
    for(int c=0; c<4; c++){
      fill(0);
      text(board[r][c], text_x, text_y);
      text_x += size;
      line(size*c, 0, size*c, h);
    }
    text_y += size;
    text_x = 125;
  }
      
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
            board[r][c] = ' ';
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

boolean checkWinner(char[][] board){
  char[][] boardWinner={{'A', 'B', 'C', 'D'}, {'E', 'F', 'G', 'H'}, {'I', 'J', 'K', ' '}};
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
    rect(100,50,50,300,28);
    rect(100,300,300,50,28);
    rect(350,50,50,300,28);
    rect(225,150,50,200,28);
    rect(410,50,50,300,28);
    rect(480,50,50,300,28);
    rect(480,50,100,50,28);
    rect(540,50,50,300,28);
    rect(540,300,100,50,28);
    rect(600,50,50,300,28);
    rect(480,370,50,300,28);
    rect(480,370,100,50,28);
    rect(540,370,50,300,28);
    rect(540,620,100,50,28);
    rect(600,370,50,300,28);
    rect(670,370,50,300,28);
    rect(670,370,200,50,28);
    rect(670,495,170,50,28);
    rect(670,620,200,50,28);
    rect(890,370,50,300,28);
    rect(890,370,200,50,28);
    rect(890,495,200,50,28);
    rect(1045,370,50,170,28);
    rect(1000,495,50,170,28);
  }
}
