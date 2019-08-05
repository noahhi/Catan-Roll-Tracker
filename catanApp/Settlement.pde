class Settlement{
  String resource;
  int tileNumber;
  boolean blocked;
  
  Settlement(String type, int num){
    this.resource = type;
    this.tileNumber = num;
    blocked = false;
  }
  
  String getType(){
    return resource;
  }
  
  int getTileNumber(){
    return tileNumber;
  }
  
  boolean blocked(){
    return blocked;
  }

  void block(){
    blocked = true;
  }
  
  void unblock(){
    blocked = false;
  }
  
  String toString(){
    return "type: " + resource + ". num: " + tileNumber;
  }
}
