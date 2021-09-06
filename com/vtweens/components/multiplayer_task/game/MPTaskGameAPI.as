package com.vtweens.components.multiplayer_task.game
{
   import com.vtweens.util.MainGetter;
   import com.vtweens.util.Map;
   import flash.display.MovieClip;
   import flash.errors.IllegalOperationError;
   
   public class MPTaskGameAPI extends MovieClip
   {
      
      public static const LOAEDME = 0;
       
      
      protected var container;
      
      public function MPTaskGameAPI()
      {
         this.container = this.container;
         super();
      }
      
      public function setFocus() : *
      {
         if(stage)
         {
            stage.focus = this;
         }
      }
      
      public function setFrameRate(param1:int) : *
      {
         this.container.setFrameRate(param1);
      }
      
      public function setContainer(param1:*) : *
      {
         this.container = param1;
      }
      
      public function get resources() : Map
      {
         return this.container.resources;
      }
      
      public function get amILeader() : Boolean
      {
         return this.getLeaderPlayer().playerId == MainGetter.MainCaller.myPlayer.playerId;
      }
      
      private function getLeaderPlayer() : *
      {
         return this.container.playersByPosition.get(1);
      }
      
      public function getPlayerByPosition(param1:int) : *
      {
         return this.container.playersByPosition.get(param1);
      }
      
      public function getPlayerById(param1:*) : *
      {
         return this.container.playerById.get(param1);
      }
      
      public function get numActivePlayers() : int
      {
         return this.container.numActivePlayers;
      }
      
      public function get myPlayerPosition() : int
      {
         return this.container.myPlayerPosition;
      }
      
      public function get myPlayerId() : int
      {
         return MainGetter.MainCaller.MyPlayer.playerId;
      }
      
      public function sendCommand(param1:*, param2:*) : *
      {
         this.container.sendCommand(param1,param2);
      }
      
      public function sendTaskCompletedCommand() : *
      {
         this.container.sendTaskCompletedCommand();
      }
      
      public function sendTaskFailedCommand() : *
      {
         this.container.sendTaskFailedCommad();
      }
      
      public function exitClick() : *
      {
         this.container.exitGame();
      }
      
      public function exitGame() : *
      {
         this.container.exitGame();
      }
      
      public function userCommand(param1:*, param2:*, param3:*, param4:*) : void
      {
         throw new IllegalOperationError("Abstract class function not supported");
      }
      
      public function leaderCommand(param1:*, param2:*, param3:*, param4:*) : void
      {
         throw new IllegalOperationError("Abstract class function not supported");
      }
      
      public function setNewLeader(param1:*, param2:*, param3:*) : void
      {
         throw new IllegalOperationError("Abstract class function not supported");
      }
      
      public function start(param1:*, param2:Map) : void
      {
         throw new IllegalOperationError("Abstract class function not supported");
      }
      
      public function removePlayer(param1:int, param2:*) : void
      {
         throw new IllegalOperationError("Abstract class function not supported");
      }
      
      public function destroy() : void
      {
         throw new IllegalOperationError("Abstract class function not supported");
      }
   }
}
