class ChoosePlayerscreen extends Screen {
  Button[] playerOptions;
  Player selectedPlayer;

  ChoosePlayerscreen() {
  }

  void update(Game game) {
    ArrayList<Player> players = game.getPlayers();
    int numPlayers = players.size();
    playerOptions = new Button[numPlayers];
    for (int i = 0; i < numPlayers; i++) {
      Player player = players.get(i);
      String name = player.getName();
      Button button = new Button(width/2, (height/5)*(i+1), 120, 60, name);
      playerOptions[i] = button;
    }
  }

  Button[] getButtons(){
    return playerOptions;
  }
  
  void selectPlayer(Player player){
    selectedPlayer = player;
  }
  
  Player getSelectedPlayer(){
    return selectedPlayer;
  }
  
  void show() {
    text("Which Player?",width/2, height/13);
    for (Button button : playerOptions){
      button.display();
    }
  }
}
