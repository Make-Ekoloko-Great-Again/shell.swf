package com.vtweens.dataobjects.throwing
{
   import com.vtweens.consts.COMMANDS;
   import com.vtweens.consts.ZONEEXTENSIONS;
   import com.vtweens.shell.ThrowingGameHelper;
   import com.vtweens.util.MainGetter;
   import flash.display.MovieClip;
   import flash.errors.IllegalOperationError;
   
   public class ThrowingGameAPI extends MovieClip
   {
      
      public static const loadme = 0;
       
      
      private var bg:MovieClip = null;
      
      private var fg:MovieClip = null;
      
      private var objects:MovieClip = null;
      
      public var gameID = null;
      
      private var targetID = null;
      
      private var target:Target = null;
      
      private var items:Array;
      
      private var gauge:ThrowingGameGauge = null;
      
      public function ThrowingGameAPI()
      {
         this.items = new Array();
         super();
      }
      
      public function init(param1:int, param2:int, param3:*, param4:MovieClip, param5:MovieClip, param6:MovieClip, param7:*) : *
      {
         this.bg = param5;
         this.fg = param4;
         this.objects = param6;
         this.targetID = param3;
         this.target = this.createTarget();
         this.target.x = param1;
         this.target.y = param2;
         this.target.room = param7;
         this.target.setIds(param3,this.gameID);
         var _loc8_:ThrowingGameAnimationHelper;
         (_loc8_ = this.getAminationHelper()).init(this.target,this.getItemsMCs(),MainGetter.MainCaller.MyPlayer,param5,param4,this.getResultPane(),this.getHitCount());
         this.target.setAnimationHelper(_loc8_);
         param6.addChild(this.target);
         this.gauge = this.getGauge();
         this.target.setGauge(this.gauge);
         this.items = this.getItemsMCs();
      }
      
      public function startGame(param1:Boolean = true) : *
      {
         var _loc2_:* = new Object();
         if(param1)
         {
            _loc2_[COMMANDS.V_GAME_ID] = this.gameID;
            MainGetter.MainCaller.SFS.sendXtMessage(ZONEEXTENSIONS.ThrowingGame,COMMANDS.C_THROWING_GAME_START,_loc2_,"json");
         }
         ThrowingGameHelper.ThrowingGameTarget = this.target;
         this.target.enabled = true;
      }
      
      public function deactivate() : *
      {
         this.target.deactivate();
         this.gauge.deactivate();
      }
      
      public function getTarget() : Target
      {
         return this.target;
      }
      
      protected function getGameId() : *
      {
         return this.gameID;
      }
      
      public function setGameId(param1:int) : *
      {
         this.gameID = param1;
      }
      
      public function get gameId() : *
      {
         return this.gameID;
      }
      
      public function createTarget() : Target
      {
         throw new IllegalOperationError("abstract function to be implemented by decendants");
      }
      
      protected function getGauge() : ThrowingGameGauge
      {
         throw new IllegalOperationError("abstract function to be implemented by decendants");
      }
      
      protected function getItemsMCs() : Array
      {
         throw new IllegalOperationError("abstract function to be implemented by decendants");
      }
      
      protected function getAminationHelper() : ThrowingGameAnimationHelper
      {
         throw new IllegalOperationError("abstract function to be implemented by decendants");
      }
      
      protected function getResultPane() : *
      {
         throw new IllegalOperationError("abstract function to be implemented by decendants");
      }
      
      protected function getHitCount() : *
      {
         throw new IllegalOperationError("abstract function to be implemented by decendants");
      }
      
      public function getTargetId() : *
      {
         return this.targetID;
      }
   }
}
