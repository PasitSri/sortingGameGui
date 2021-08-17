import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class sortingGameGui extends PApplet {

int w=800, h=600;
int[] blank_position={2, 2};
String[][] board={{"A", "B", "C", "D"}, {"E", "F", "G", "H"}, {"I", "J", " ", "K"}};
int size=200;
File f = new File("data.txt");
boolean check=true;

public void saveGame(){
  String[] saveBoard = new String[13];
  int i=0;
 for(int r=0; r<3; r++){
    for(int c=0; c<4; c++){
      saveBoard[i] = board[r][c];
      i++;
    }
  }
  saveStrings("data.txt", saveBoard);
}

public void loadGame(){
  String[] loadBoard = loadStrings("data.txt");
  int i=0;
  for(int r=0; r<3; r++){
    for(int c=0; c<4; c++){
      if(loadBoard[i] != null && i<13){
        board[r][c] = loadBoard[i];
        i++;
      }
      if(board[r][c].contains(" ")){
        blank_position[0]=r;
        blank_position[1]=c;
      }
    }
  }
}

public void setup(){
  
  background(255);
  randomAlpha();
}

public void draw(){
  if(check){
    WScreen();
  }
  else{
    saveButton();
    createBoard();
    swapChar();
    if(checkWinner(board)){
      win_sceen();
    }
  }
  println(mouseX, mouseY);
}

public void WScreen(){
  background(255);
  textSize(40);
  fill(0);
  text("You have saved game", 90, 220);
  textSize(50);
  text("Do you want to continue?", 90, 270);
  textSize(30);
  File file = new File("data.txt");
  if(file.exists()){
    if(mouseX > 150 && mouseX < 350 && mouseY > 300 && mouseY < 350){
      fill(50);
      text("No, New Game", 400, 350);
      fill(0, 100, 200);
      text("Yes, Continue", 150, 350);
      if(mousePressed == true){
        loadGame();
        check=false;
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
        saveGame();
        check=false;
        clear();
        redraw();
      }
    }
    else{
      fill(50);
      text("Yes, Continue", 150, 350);
      text("No, New Game", 400, 350);
    }
  }else{
    if(mouseX > 330 && mouseX < 480 && mouseY > 300 && mouseY < 350){
      fill(0, 100, 200);
      text("New Game", 330, 350);
      if(mousePressed == true){
        saveGame();
        check=false;
        clear();
        redraw();
      }
    }
    else{
      fill(50);
      text("New Game", 330, 350);
    }
  }
}

public void randomAlpha(){
  String buffer;
  for(int r=0; r<3; r++){
    for(int c=0; c<4; c++){
      int ranRow = PApplet.parseInt( random( 3 ) );
      int ranCol = PApplet.parseInt( random( 4 ) );
      buffer = board[r][c];
      board[r][c] = board[ranRow][ranCol];
      board[ranRow][ranCol] = buffer;
      if(board[ranRow][ranCol].contains(" ")){
        blank_position[0] = ranRow;
        blank_position[1] = ranCol;
      }
      else if(board[r][c].contains(" ")){
        blank_position[0] = r;
        blank_position[1] = c;
      }
    }
  }  
}

public void createBoard(){
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

public void swapChar(){
  int col;
  int row;
  if(mousePressed == true){
    col = (mouseX)/200;
    row = (mouseY)/200;
    if(((row-1==blank_position[0]||row+1==blank_position[0]) && col==blank_position[1]) || ((col-1==blank_position[1]||col+1==blank_position[1]) &&row==blank_position[0]) && mouseY < 600 ){
      board[blank_position[0]][blank_position[1]] = board[row][col];
      board[row][col] = " ";
      blank_position[0] = row;
      blank_position[1] = col;
    }
  }
}

public void saveButton(){
  if(mousePressed == true){
    if(mouseX>0 && mouseX<400 && mouseY>600 && mouseY<650){
      saveGame();
      exit();
    }
    if(mouseX>400 && mouseX<800 && mouseY>600 && mouseY<650){
      exit();

    }
  }
}

public boolean checkWinner(String[][] board){
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

public void win_sceen(){
  if(checkWinner(board) == true){
    background(255);
    textSize(125);
    text("VICTORY", 130, 350);
  }
}
  public void settings() {  size(800, 650); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sortingGameGui" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
