import de.bezier.guido.*;
public final static int NUM_ROW = 50;
public final static int NUM_COL = 50;
private Life[][] buttons; //2d array of Life buttons each representing one cell
private boolean[][] buffer; //2d array of booleans to store state of buttons array
private boolean running = true; //used to start and stop program

public void setup () {
  size(400, 400);
  frameRate(6);
  // make the manager
  Interactive.make( this );
buttons = new Life[NUM_ROW][NUM_COL];
for(int row = 0; row < NUM_ROW; row++){
  for(int col = 0; col < NUM_COL; col++){
    buttons[row][col] = new Life(row, col);
  }
}
buffer = new boolean[NUM_ROW][NUM_COL];
}

public void draw () {
  background( 0 );
  if (running == false) //pause the program
    return;
  copyFromButtonsToBuffer();
  for(int row = 0; row < NUM_ROW; row++){
    for(int col = 0; col < NUM_COL; col++){
      if(countNeighbors(row, col) == 3){
        buffer[row][col] = true;
      }else if(countNeighbors(row, col) == 2 && buttons[row][col].getLife() == true){
        buffer[row][col] = true;
      }else{
        buffer[row][col] = false;
      }
      buttons[row][col].draw();
  }
}
  copyFromBufferToButtons();
}

public void keyPressed() {
if(key == ' '){
  running = !running;
}
}

public void copyFromBufferToButtons() {
  for(int row = 0; row < NUM_ROW; row++){
    for(int col = 0; col < NUM_COL; col++){
      if(buffer[row][col] == true){
        buttons[row][col].setLife(true);
      }else{
      buttons[row][col].setLife(false);
      }
    }
  }
}

public void copyFromButtonsToBuffer() {
  for(int row = 0; row < NUM_ROW; row++){
    for(int col = 0; col < NUM_COL; col++){
      if(buttons[row][col].getLife() == true){
        buffer[row][col] = true;
      }else{
      buffer[row][col] = false;
      }
    }
  }
}

public boolean isValid(int r, int c) {
  if(NUM_ROW > r && NUM_COL > c && r >=0 && c >= 0){
    return true;
  }else{
  return false;
  }
}

public int countNeighbors(int row, int col) {
  int neighbors = 0;
  if(isValid(row-1,col-1) && buttons[row-1][col-1].getLife() == true){
    neighbors++;
  }
  if(isValid(row-1,col) && buttons[row-1][col].getLife() == true){
    neighbors++;
  }
  if(isValid(row-1,col+1) && buttons[row-1][col+1].getLife() == true){
    neighbors++;
  }
  if(isValid(row,col-1) && buttons[row][col-1].getLife() == true){
    neighbors++;
  }
  if(isValid(row,col+1) && buttons[row][col+1].getLife() == true){
    neighbors++;
  }
  if(isValid(row+1,col-1) && buttons[row+1][col-1].getLife() == true){
    neighbors++;
  }
  if(isValid(row+1,col) && buttons[row+1][col].getLife() == true){
    neighbors++;
  }
  if(isValid(row+1,col+1) && buttons[row+1][col+1].getLife() == true){
    neighbors++;
  }
  return neighbors;
}

public class Life {
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean alive;

  public Life (int row, int col) {
    width = 400/NUM_COL;
    height = 400/NUM_ROW;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    alive = Math.random() < .5; // 50/50 chance cell will be alive
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () {
    alive = !alive; //turn cell on and off with mouse press
  }
  public void draw () {    
    if (alive != true)
      fill(0);
    else 
      fill( 150 );
    rect(x, y, width, height);
  }
  public boolean getLife() {
    if(alive == true){
    return true;
    }else{
    return false;
    }
  }
  public void setLife(boolean living) {
    if(living == true){
      alive = true;
    }else{
    alive = false;
    }
  }
}
