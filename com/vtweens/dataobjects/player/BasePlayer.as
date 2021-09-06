package com.vtweens.dataobjects.player
{
   import com.greensock.TweenMax;
   import com.vtweens.dataobjects.avatar.Avatar;
   import com.vtweens.util.P2PData;
   import fl.motion.easing.Linear;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class BasePlayer extends Player
   {
      
      public static const DESTINATION_REACHED:String = "destination_reached";
      
      public static const RUN:Boolean = true;
      
      public static const WALK:Boolean = false;
       
      
      private var WALK_SPEED = 0.08333333333333333;
      
      private var RUN_SPEED = 0.041666666666666664;
      
      private var speed;
      
      private var dx = 0;
      
      private var dy = 0;
      
      private var walking:Boolean = false;
      
      private var tileIndex = 0;
      
      private var tilePath:Array = null;
      
      private var pathFinder = null;
      
      public function BasePlayer(param1:Avatar, param2:*)
      {
         this.speed = this.WALK_SPEED;
         super(param1);
         this.pathFinder = param2;
      }
      
      public function setPathFinder(param1:*) : *
      {
         this.pathFinder = param1;
      }
      
      public function getPathFinder() : *
      {
         return this.pathFinder;
      }
      
      public function setDoubleSpeed() : *
      {
         this.WALK_SPEED = 0.1 / 18;
         this.RUN_SPEED = 0.75 / 18;
      }
      
      private function destinationReached() : *
      {
         dispatchEvent(new Event(DESTINATION_REACHED));
      }
      
      public function getAnimal() : *
      {
         return null;
      }
      
      private function walk(param1:*, param2:int) : *
      {
         if(this.tileIndex <= 0 || param1 == null || avatar == null)
         {
            this.stopWalking();
            return;
         }
         var _loc3_:* = new P2PData(x,y,param1.center.x,param1.center.y);
         avatar.animateTurnAndWalk(_loc3_);
         if(clonedAvatar)
         {
            clonedAvatar.animateTurnAndWalk(_loc3_);
         }
         var _loc4_:*;
         if(_loc4_ = this.getAnimal())
         {
            _loc4_.performAction(avatar.getAction());
         }
         TweenMax.to(this,param2 * this.speed,{
            "ease":Linear.easeNone,
            "x":param1.center.x,
            "y":param1.center.y,
            "onComplete":this.walkStep
         });
      }
      
      public function walkTo(param1:int, param2:int, param3:Boolean = false) : *
      {
         if(param1 == x && param2 == y)
         {
            this.destinationReached();
            return;
         }
         this.tilePath = this.pathFinder.getPath(x,y,param1,param2);
         if(this.tilePath.length > 0)
         {
            this.speed = !!param3 ? this.RUN_SPEED : this.WALK_SPEED;
            this.tileIndex = this.tilePath.length - 1;
            this.walkStep();
            return new P2PData(x,y,param1,param2).getDirection();
         }
         return -1;
      }
      
      public function standAt(param1:*, param2:*) : *
      {
         var _loc3_:Point = this.pathFinder.getPosition(param1,param2);
         x = _loc3_.x;
         y = _loc3_.y;
         avatar.stopWalking();
         if(clonedAvatar)
         {
            clonedAvatar.stopWalking();
         }
         if(this.getAnimal())
         {
            this.getAnimal().performAction(avatar.getAction());
         }
         this.stopWalking();
      }
      
      private function walkStep() : *
      {
         this.walking = true;
         var _loc1_:* = this.tilePath[this.tileIndex];
         var _loc2_:* = 0;
         var _loc3_:* = this.tilePath[this.tileIndex - 1];
         var _loc4_:*;
         var _loc5_:* = _loc4_ = P2PData.GetTileDirection(_loc1_,_loc3_);
         var _loc6_:* = _loc1_;
         while(_loc5_ == _loc4_)
         {
            _loc3_ = _loc6_;
            if(this.tileIndex - _loc2_ - 1 <= 0)
            {
               break;
            }
            _loc2_++;
            _loc6_ = this.tilePath[this.tileIndex - _loc2_];
            if((_loc5_ = P2PData.GetTileDirection(_loc3_,_loc6_)) == P2PData.ERROR)
            {
               break;
            }
         }
         this.tileIndex -= _loc2_;
         if(_loc2_ > 0)
         {
            this.walk(_loc3_,_loc2_);
         }
         else
         {
            this.destinationReached();
            this.stopWalking();
         }
      }
      
      override public function stopWalking() : *
      {
         if(this.walking && avatar != null)
         {
            avatar.stopWalking();
            if(clonedAvatar)
            {
               clonedAvatar.stopWalking();
            }
            if(this.getAnimal())
            {
               this.getAnimal().performAction(avatar.getAction());
            }
            this.walking = false;
         }
      }
   }
}
