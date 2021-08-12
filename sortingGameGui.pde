int w=1200, h=900;
int[] blank_position={2, 2};
char[][] board={{'A', 'B', 'C', 'D'}, {'E', 'F', 'G', 'H'}, {'I', 'J', ' ', 'K'}};
int size=300;

void setup(){
  size(1200, 900);
  background(255);
  textSize(100);
}

void draw(){
  createBoard();
  swapChar();
  if(checkWinner(board)){
    println("Winner");
    createBoard();
    swapChar();
  }
}

void createBoard(){
  background(255);
  int text_x=125, text_y=200;

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
