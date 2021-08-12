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
