package com.vtweens.components.multiplayer_task.game
{
   import com.vtweens.dataobjects.avatar.Avatar;
   import com.vtweens.dataobjects.life_level.LifeLevelGauge;
   import com.vtweens.dataobjects.life_level.LifeLevelGaugePlayer;
   import com.vtweens.dataobjects.player.Player;
   
   public class MPTaskPlayer extends Player
   {
      
      public static const LOADME = 0;
       
      
      private var _isPremium:Boolean;
      
      private var _isMod:Boolean;
      
      private var _rangerLevel:int;
      
      private var _level:int;
      
      private var _lifeType:int;
      
      private var _startLife:int;
      
      private var _maxLife:int;
      
      public function MPTaskPlayer(param1:Avatar, param2:*, param3:*, param4:*, param5:*, param6:*, param7:*, param8:* = 0, param9:* = 0, param10:* = 0)
      {
         super(param1);
         playerId = param2;
         playerName = param3;
         this._isPremium = param4;
         this._isMod = param5;
         this._rangerLevel = param6;
         this._level = param7;
         this._lifeType = param8;
         this._startLife = param9;
         this._maxLife = param10;
      }
      
      public function get isPremium() : Boolean
      {
         return this._isPremium;
      }
      
      public function get isMod() : Boolean
      {
         return this._isMod;
      }
      
      public function get rangerLevel() : int
      {
         return this._rangerLevel;
      }
      
      public function get level() : int
      {
         return this._level;
      }
      
      public function get lifeType() : int
      {
         return this._lifeType;
      }
      
      public function get startLife() : int
      {
         return this._startLife;
      }
      
      public function get maxLife() : int
      {
         return this._maxLife;
      }
      
      public function getSmallLifeGauge(param1:* = true, param2:* = false, param3:* = true) : *
      {
         var _loc4_:LifeLevelGaugePlayer;
         (_loc4_ = new LifeLevelGaugePlayer(this._lifeType,param1,param2,param3)).updateScore(this.startLife,this.maxLife);
         return _loc4_;
      }
      
      public function getBigLifeGauge() : *
      {
         var _loc1_:LifeLevelGauge = new LifeLevelGauge(this._lifeType);
         _loc1_.updateScore(this.startLife,this.maxLife);
         return _loc1_;
      }
      
      public function reset() : *
      {
         x = 0;
         y = -106;
         scaleX = scaleY = 1;
         alpha = 1;
         filters = [];
      }
   }
}
