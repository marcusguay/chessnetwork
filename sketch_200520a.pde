import processing.net.*; //<>// //<>//
Server myServer;
color lightbrown = #FFFFC3;
color darkbrown  = #D8864E;
PImage wrook, wbishop, wknight, wqueen, wking, wpawn;
PImage brook, bbishop, bknight, bqueen, bking, bpawn;
boolean firstClick=true;
boolean okey, tkey, thkey, fkey, fikey, skey;
boolean itsMyTurn = true;
int letit;
int row1, col1, row2, col2;
int timer;
int WChange;
int BChange;
int ran;
int castle;
int new1, new2, new3, new4;
int check;
int Whitecastle;
int blackcastle;
char grid[][] = {
  {'R', 'B', 'N', 'Q', 'K', 'N', 'B', 'R'}, 
  {'P', 'P', 'P', 'P', 'P', 'P', 'P', 'P'}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p'}, 
  {'r', 'b', 'n', 'q', 'k', 'n', 'b', 'r'}
};

void setup() {
  size(800, 800);
  firstClick=true;
  new1=0;
  new2=0;
  new3=0;
  new4=0;
  itsMyTurn = true;


  myServer = new Server(this, 1234);
  brook = loadImage("blackRook.png");
  bbishop = loadImage("blackBishop.png");
  bknight = loadImage("blackKnight.png");
  bqueen = loadImage("blackQueen.png");
  bking = loadImage("blackKing.png");
  bpawn = loadImage("blackPawn.png");

  wrook = loadImage("whiteRook.png");
  wbishop = loadImage("whiteBishop.png");
  wknight = loadImage("whiteKnight.png");
  wqueen = loadImage("whiteQueen.png");
  wking = loadImage("whiteKing.png");
  wpawn = loadImage("whitePawn.png");
}

void draw() {
  // println(  itsMyTurn);
  //   println(  firstClick);



  println("new1", new1, new2);
  println("new2", new3, new4);
 
  println("coord", grid[7][1]);
  println("check", check);
  println(" white castle" + Whitecastle);
  println(" Black castle" + blackcastle);
  println("mouse coords", "Row", mouseY/100, "Clock", mouseX/100);
  println("letit", letit);
  println( grid[row2][col2]);
  println( grid[row1][col1]);
  println(firstClick);
  drawBoard();
  drawPieces();
  if (WChange==1) {
    if (okey) {
          grid[row2][col2]= 'p';}
   
  
          if (tkey) {
            grid[row2][col2]= 'r';
   
 
      check=1;
    firstClick = true;   
            itsMyTurn=false;    }
    if (thkey) {
      
            grid[row2][col2]= 'b';
   

   firstClick = true;   
            itsMyTurn=false;     }
  
    if (fkey) {
        grid[row2][col2]= 'n';
  
    
   firstClick = true;   
            itsMyTurn=false;     }
    if(fikey){
       grid[row2][col2]= 'q';
      
     
  firstClick = true;   
            itsMyTurn=false;      }
    if(skey){
      WChange=0;
        BChange=0;
        firstClick = true;   
        itsMyTurn=false;   
      
    }
   
  }
  if (BChange==1) {
    if (okey) {
         grid[row2][col2]= 'P';

     firstClick = true;   
            itsMyTurn=false;   }
          if (tkey) { grid[row2][col2]= 'R';
    
     
      check=1;
    firstClick = true;   
            itsMyTurn=false;    }
    if (thkey) {grid[row2][col2]= 'B';
      
      
   firstClick = true;   
            itsMyTurn=false;     }
    
    if (fkey) { grid[row2][col2]= 'N';
      
     
    firstClick = true;   
            itsMyTurn=false;    }
    if(fikey){ grid[row2][col2]= 'Q';
  
     
     firstClick = true;   
            itsMyTurn=false;   
  }
    if(skey){
      WChange=0;
        BChange=0;
        firstClick = true;   
            itsMyTurn=false;   
         
    }
    
    
  }
  receiveMove();
  fill(0);
  timer--;
}

void receiveMove() {
  Client myClient = myServer.available();
  if (myClient !=null) {
    String  incoming= myClient.readString();
    int r1 = int(incoming.substring(0, 1));
    int c1 = int(incoming.substring(2, 3));
    int r2 = int(incoming.substring(4, 5));
    int c2 = int(incoming.substring(6, 7));
    int castle= int(incoming.substring(8, 9));
    int new3 = int (incoming.substring(10, 11));
    int new4 = int (incoming.substring(12, 13));
    itsMyTurn=true;
    //int crow2 = int (incoming.substring(14,15));
    //int crow3 = int (incoming.substring(14,16));
    println("R2"+r2);
    if (castle==1) {
      grid[r1][c1] = grid[new3][new4];
      grid[r2][c2]= 'k';
      itsMyTurn=true;
      firstClick = true;
      timer=20;
    }
    if (castle==2) {
      grid[r1][c1] = grid[new3][new4];
      grid[r2][c2]= 'K';
      itsMyTurn=true;
      firstClick = true;
      timer=20;
    } 
    if (castle==0) {
      grid[r2][c2] = grid[r1][c1];
      grid[r1][c1] = ',';
      itsMyTurn=true;
      firstClick = true;
      timer=20;
    }
  }
}

void drawBoard() {
  for (int r = 0; r < 8; r++) {
    for (int c = 0; c < 8; c++) { 
      if ( (r%2) == (c%2) ) { 
        fill(lightbrown);
      } else { 
        fill(darkbrown);
      }
      rect(c*100, r*100, 100, 100);
    }
  }
}

void drawPieces() {
  for (int r = 0; r < 8; r++) {
    for (int c = 0; c < 8; c++) {
      if (grid[r][c] == 'r') image (wrook, c*100, r*100, 100, 100);
      if (grid[r][c] == 'R') image (brook, c*100, r*100, 100, 100);
      if (grid[r][c] == 'b') image (wbishop, c*100, r*100, 100, 100);
      if (grid[r][c] == 'B') image (bbishop, c*100, r*100, 100, 100);
      if (grid[r][c] == 'n') image (wknight, c*100, r*100, 100, 100);
      if (grid[r][c] == 'N') image (bknight, c*100, r*100, 100, 100);
      if (grid[r][c] == 'q') image (wqueen, c*100, r*100, 100, 100);
      if (grid[r][c] == 'Q') image (bqueen, c*100, r*100, 100, 100);
      if (grid[r][c] == 'k') image (wking, c*100, r*100, 100, 100);
      if (grid[r][c] == 'K') image (bking, c*100, r*100, 100, 100);
      if (grid[r][c] == 'p') image (wpawn, c*100, r*100, 100, 100);
      if (grid[r][c] == 'P') image (bpawn, c*100, r*100, 100, 100);
    }
  }
}

void mouseReleased() {
  if (timer<0) {
    if (  itsMyTurn==true) {
      if (firstClick==true) {
        row1 = mouseY/100;
        col1 = mouseX/100;
     


        new1=row1;
        new2=col1;
        

        if (grid[row1][col1] == 'k'   
          ||  grid[row1][col1] == 'K'   ) {

          if (col1==2 || col1==1 ) {

            if (grid[7][1] == ','||  grid[7][1] == 'k') {
              check=1;
              if (row1==7) {
                check=1;
                Whitecastle=1;
              }
            }
          }

          if (col1==5 || col1==6 ) {
            if (grid[7][6] == ','||  grid[7][6] == 'k') {
              if (row1==7) {
                Whitecastle=2;
              }
            }
          }

          if (col1==1 ||col1==2 ) {
            if (grid[0][1] == ','||  grid[0][1] == 'K') {
              if (row1==0) {
                blackcastle=1;
              }
            }
          }
          if (col1==5 ||col1==6 ) { 
            if (grid[0][6] == ','||  grid[0][6] == 'K')
              if (row1==0) {
                blackcastle=2;
              }
          }
        }


        if (grid[row1][col1] == 'p' && row1 == 1 ||grid[row1][col1] == 'P'&& row1 == 6) {
          letit=1;
         
        }
           firstClick = false;
      } 
      if (firstClick==false) {

        row2 = mouseY/100;
        col2 = mouseX/100;


        if (grid[row2][col2] == 'r'   
          || grid[row2][col2] == 'R' && Whitecastle > 0  || blackcastle > 0) {



          new3=row2;
          new4=col2;


          if (Whitecastle==1) {
            if (col2==0) {
              if (row2==7) {

                grid[row1][col1] = grid[new3][new4];
                grid[row2][col2]= 'k';

                castle=1;
                myServer.write(row1 + "," + col1 + "," +row2 + "," +col2 + "," + castle  + "," + new3 + "," + new4 );
                firstClick=true;
                itsMyTurn=false;
              }
            }
          }
          if (Whitecastle==2) {
            if (col2==7) {
              if (row2==7) {
                grid[row1][col1] = grid[new3][new4];
                grid[row2][col2]= 'k';
                castle=1;
                myServer.write(row1 + "," + col1 + "," +row2 + "," +col2 + "," + castle  + "," + new3 + "," + new4 );
                firstClick=true;
                itsMyTurn=false;
              }
            }
          }
          if (blackcastle==1) {
            if (col2==0) {
              if (row2==0) {
                grid[row1][col1] = grid[new3][new4];
                grid[row2][col2]= 'K';
                castle=2;
                myServer.write(row1 + "," + col1 + "," +row2 + "," +col2 + "," + castle  + "," + new3 + "," + new4 );
                firstClick=true;
                itsMyTurn=false;
              }
            }
          }
          if (blackcastle==2) {
            if (col2==7) {
              if (row2==0) {
                grid[row1][col1] = grid[new3][new4];
                grid[row2][col2]= 'K';
                castle=2;
                myServer.write(row1 + "," + col1 + "," +row2 + "," +col2 + "," + castle  + "," + new3 + "," + new4 );
                firstClick=true;  
                itsMyTurn=false;
              }
            }
          }
        } else {
          if (letit==1) {
            row2 = mouseY/100;
            col2 = mouseX/100;
            if (letit==1 && row2==0 || row2==7  ) {
              grid[row2][col2] = grid[row1][col1];
              grid[row1][col1] = ' ';
              myServer.write(row1 + "," + col1 + "," + row2 + "," +col2 + "," + castle  + "," + new3 + "," + new4 );

              if (grid[row2][col2] == 'p' && row2 == 0) {
                WChange=1;
                 firstClick = true;   
        itsMyTurn=false;
              }


              if (grid[row2][col2] == 'P' && row2 == 7) {
                BChange=1;
                 firstClick = true;   
        itsMyTurn=false;
              }
            }} else {
              row2 = mouseY/100;
              col2 = mouseX/100;
              if (!(itsMyTurn==true&&row2 == row1 && col2 == col1)) {
                grid[row2][col2] = grid[row1][col1];
                grid[row1][col1] = ' ';
                myServer.write(row1 + "," + col1 + "," + row2 + "," +col2 + "," + castle  + "," + new3 + "," + new4 );

                castle=0;
               letit=0;
                firstClick = true;   
                itsMyTurn=false;
              }
            }
          }
        }
      }
    }
    
  }
  



  public void keyPressed() {
    if (key=='1'|| key=='1') okey = true;
    if (key=='2'|| key=='2') tkey = true;
    if (key=='3'|| key=='3') thkey = true;
    if (key=='4'|| key=='4') fkey = true;  
    if (key=='5'|| key=='5') fikey = true;
    if (key=='6'|| key=='6') skey = true;
  }
  public void keyReleased() {
    if (key=='1'|| key=='1') okey = false;
    if (key=='2'|| key=='2') tkey = false;
    if (key=='3'|| key=='3') thkey = false;
    if (key=='4'|| key=='4') fkey = false;  
    if (key=='5'|| key=='5') fikey = false;
    if (key=='6'|| key=='6') skey = false;
  }
