package com.vtweens.dataobjects.throwing
{
   import com.vtweens.shell.ThrowingGameHelper;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class Target extends Sprite
   {
      
      private static const READY = 0;
      
      private static const SEEK = 1;
      
      private static const ON_TARGET = 2;
      
      private static const POWER = 3;
      
      private static const WAIT_FOR_HIT = 5;
      
      private static var glowFilter:GlowFilter = new GlowFilter(16777215,1,25,25,2,BitmapFilterQuality.MEDIUM);
       
      
      private var TURN_TIME_LIMIT = 12;
      
      private var SERVER_REPLY_LIMIT = 6;
      
      private var isEnabled:Boolean = false;
      
      private var hostingRoom = null;
      
      private var state:int = 0;
      
      private var score:int = 0;
      
      private var gauge:ThrowingGameGauge = null;
      
      private var hitPoint;
      
      private var reward = null;
      
      private var gaugeFadeTimer:Timer;
      
      private var shootTimer:Timer;
      
      private var serverReplyTimer:Timer;
      
      private var miss:Boolean = false;
      
      private var GAUGE_BASE_Y:int = 85;
      
      private var gameId:int;
      
      private var targetId;
      
      private var animationHelper:ThrowingGameAnimationHelper;
      
      public function Target()
      {
         this.hitPoint = new Point(0,0);
         this.gaugeFadeTimer = new Timer(20);
         this.shootTimer = new Timer(this.TURN_TIME_LIMIT * 1000,1);
         this.serverReplyTimer = new Timer(this.SERVER_REPLY_LIMIT * 1000,1);
         super();
         this.shootTimer.addEventListener(TimerEvent.TIMER,this.onShootTimer,false,0,true);
         this.gaugeFadeTimer.addEventListener(TimerEvent.TIMER,this.onGaugeFade,false,0,true);
         this.serverReplyTimer.addEventListener(TimerEvent.TIMER,this.onNoServerResponse,false,0,true);
         this.reset();
      }
      
      public function getTargetLocation() : Point
      {
         var _loc1_:* = getChildByName("targetLoc");
         if(_loc1_)
         {
            return new Point(_loc1_.x,_loc1_.y);
         }
         return new Point(0,0);
      }
      
      public function setGaugeBaseY(param1:int) : *
      {
         this.GAUGE_BASE_Y = param1;
      }
      
      protected function getGameMaxShots() : *
      {
         return 15;
      }
      
      public function hitTestThrowingPosition(param1:*, param2:*) : *
      {
         return this.animationHelper.hitTestThrowingPosition(param1,param2);
      }
      
      public function setAnimationHelper(param1:ThrowingGameAnimationHelper) : *
      {
         this.animationHelper = param1;
      }
      
      public function get popupClass() : *
      {
         return this.animationHelper.popupClass;
      }
      
      public function getTargetId() : *
      {
         return this.targetId;
      }
      
      public function getGameId() : *
      {
         return this.gameId;
      }
      
      public function setIds(param1:*, param2:int) : *
      {
         this.targetId = param1;
         this.gameId = param2;
      }
      
      public function deactivate() : *
      {
         this.shootTimer.reset();
         this.shootTimer.removeEventListener(TimerEvent.TIMER,this.onShootTimer);
         this.shootTimer = null;
         this.gaugeFadeTimer.reset();
         this.gaugeFadeTimer.removeEventListener(TimerEvent.TIMER,this.onGaugeFade);
         this.gaugeFadeTimer = null;
         this.serverReplyTimer.reset();
         this.serverReplyTimer.removeEventListener(TimerEvent.TIMER,this.onShootTimer);
         this.serverReplyTimer = null;
      }
      
      public function setGauge(param1:ThrowingGameGauge) : *
      {
         this.gauge = param1;
         this.gauge.reset();
      }
      
      private function onGaugeFade(param1:TimerEvent) : void
      {
         if(this.gauge.alpha > 0)
         {
            this.gauge.alpha -= 0.1;
         }
         else if(contains(this.gauge))
         {
            removeChild(this.gauge);
            this.gauge.alpha = 1;
            this.gaugeFadeTimer.reset();
         }
      }
      
      public function get hitTarget() : Point
      {
         return new Point(this.hitPoint.x + x,this.hitPoint.y + y);
      }
      
      public function set hitTarget(param1:Point) : *
      {
         this.hitPoint = param1;
      }
      
      public function get shootPhase() : *
      {
         return this.state >= POWER;
      }
      
      public function get findTragetPahse() : *
      {
         return this.state == SEEK;
      }
      
      public function get enabled() : *
      {
         return this.isEnabled;
      }
      
      public function set enabled(param1:Boolean) : *
      {
         this.isEnabled = param1;
      }
      
      public function set room(param1:*) : *
      {
         this.hostingRoom = param1;
      }
      
      public function set throwsscore(param1:int) : *
      {
         this.score = param1;
      }
      
      public function get throwsscore() : int
      {
         return this.score;
      }
      
      public function step() : *
      {
         if(this.enabled)
         {
            switch(this.state)
            {
               case READY:
                  this.serverReplyTimer.reset();
                  this.placeThrowingLocation();
                  this.state = SEEK;
                  break;
               case SEEK:
                  break;
               case ON_TARGET:
                  ThrowingGameHelper.SetPlayerPosition();
                  this.showGauge();
                  this.state = POWER;
                  break;
               case POWER:
                  this.shoot();
                  this.serverReplyTimer.start();
                  this.gauge.reset();
                  this.state = WAIT_FOR_HIT;
                  break;
               case WAIT_FOR_HIT:
                  this.serverReplyTimer.start();
            }
         }
      }
      
      public function playerIsOnTarget() : *
      {
         if(this.state == SEEK)
         {
            this.state = ON_TARGET;
            this.highlight(true);
         }
      }
      
      public function playerIsOffTarget() : *
      {
         if(this.state == ON_TARGET)
         {
            this.state = SEEK;
            this.highlight(false);
         }
      }
      
      private function placeThrowingLocation() : *
      {
         var _loc1_:Point = this.hostingRoom.getLegitLocation(200 + int(Math.random() * 550),400 + int(Math.random() * 200));
         this.animationHelper.showThrowingPosition(_loc1_);
         this.serverReplyTimer.reset();
         this.shootTimer.start();
      }
      
      private function onShootTimer(param1:TimerEvent) : *
      {
         this.callTimeoutOperation();
         this.shootTimer.reset();
         this.serverReplyTimer.start();
         this.miss = true;
         this.highlight(false);
         this.enabled = false;
      }
      
      private function onNoServerResponse(param1:TimerEvent) : void
      {
         this.callTimeoutOperation();
         this.reset();
      }
      
      public function callTimeoutOperation() : *
      {
         ThrowingGameHelper.ThrowGameTimeout(this);
      }
      
      private function reset() : *
      {
         this.getReady();
         this.score = 0;
         this.reward = null;
         this.miss = false;
         this.shootTimer.reset();
         this.serverReplyTimer.reset();
         this.enabled = false;
         if(this.gauge)
         {
            this.gauge.reset();
            if(contains(this.gauge))
            {
               removeChild(this.gauge);
               this.gauge.alpha = 1;
               this.gaugeFadeTimer.reset();
            }
         }
         if(this.animationHelper)
         {
            this.animationHelper.hidePosition();
         }
      }
      
      private function getReady() : *
      {
         this.state = READY;
      }
      
      private function highlight(param1:Boolean) : *
      {
         if(param1)
         {
            filters = [glowFilter];
         }
         else
         {
            filters = [];
         }
      }
      
      private function showGauge() : *
      {
         addChild(this.gauge);
         this.gauge.start(this.score);
      }
      
      private function shoot() : *
      {
         var _loc1_:Point = this.hitPoint;
         var _loc2_:Boolean = this.gauge.checkHit();
         ++this.score;
         var _loc3_:Number = -this.gauge.getNormalizedPower();
         this.animationHelper.myPlayerThrowItemAt(_loc3_,_loc2_,this.score);
         this.miss = !_loc2_;
         this.highlight(false);
         if(this.miss)
         {
            this.enabled = false;
         }
         this.gaugeFadeTimer.start();
         this.shootTimer.reset();
      }
      
      public function shotFlightEnded(param1:Boolean) : *
      {
         if(this.reward != null)
         {
            ThrowingGameHelper.ShowThrowGameOverData(this.reward);
            ThrowingGameHelper.ThrowTragetGameEnd();
            this.reset();
         }
         else if(param1)
         {
            if(this.score < this.getGameMaxShots())
            {
               this.placeThrowingLocation();
               this.state = SEEK;
            }
            else
            {
               this.onShootTimer(null);
            }
         }
      }
      
      public function setGameOver(param1:*) : *
      {
         this.reward = param1;
         if(this.miss == true)
         {
            ThrowingGameHelper.ShowThrowGameOverData(this.reward);
            this.reset();
         }
      }
      
      public function throwItem(param1:int, param2:int, param3:int, param4:int, param5:int, param6:Boolean, param7:int) : *
      {
         var _loc8_:* = this.hostingRoom.getPlayer(param1);
         var _loc9_:* = {
            "x":param2,
            "y":param3
         };
         var _loc10_:* = {
            "x":param4,
            "y":param5
         };
         this.animationHelper.playerThrowItemAt(_loc8_,_loc9_,_loc10_,param6,param7);
      }
   }
}
