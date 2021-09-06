package com.vtweens.dataobjects.throwing
{
   import com.greensock.TweenMax;
   import com.vtweens.shell.ThrowingGameHelper;
   import fl.motion.easing.Linear;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class ThrowingGameAnimationHelper
   {
       
      
      protected var target:Target = null;
      
      protected var myPlayer = null;
      
      private var throwingPosition:MovieClip;
      
      private var throwingPositionContainer:Sprite;
      
      private var thrownItemContainer:Sprite;
      
      private var throwItems:Array;
      
      private var popup = null;
      
      private var hitCount = null;
      
      public function ThrowingGameAnimationHelper()
      {
         super();
      }
      
      public function init(param1:*, param2:Array, param3:*, param4:Sprite, param5:Sprite, param6:*, param7:*) : *
      {
         this.target = param1;
         this.myPlayer = param3;
         this.throwingPositionContainer = param4;
         this.thrownItemContainer = param5;
         this.throwItems = param2;
         this.popup = param6;
         this.hitCount = param7;
         this.throwingPosition = new ThrowingPosition();
         this.throwingPosition.visible = false;
         param4.addChild(this.throwingPosition);
      }
      
      public function get popupClass() : *
      {
         return this.popup;
      }
      
      public function hitTestThrowingPosition(param1:*, param2:*) : *
      {
         return this.throwingPosition.hitTestPoint(param1,param2,true);
      }
      
      public function showThrowingPosition(param1:Point) : *
      {
         this.throwingPosition.x = param1.x;
         this.throwingPosition.y = param1.y;
         this.throwingPosition.beem.visible = true;
         this.throwingPosition.beem.alpha = 1;
         this.throwingPosition.visible = true;
         this.throwingPosition.scaleX = this.throwingPosition.scaleY = 0;
         TweenMax.to(this.throwingPosition.beem,1,{
            "alpha":0,
            "ease":Linear.easeNone
         });
         TweenMax.to(this.throwingPosition,1,{
            "scaleX":1,
            "scaleY":1,
            "ease":Linear.easeIn,
            "onComplete":this.onTrowingBeemPlaceEnd
         });
      }
      
      public function hidePosition() : *
      {
         this.throwingPosition.visible = false;
      }
      
      private function onTrowingBeemPlaceEnd() : *
      {
         this.throwingPosition.beem.visible = false;
         this.throwingPosition.beem.alpha = 1;
      }
      
      public function myPlayerThrowItemAt(param1:Number, param2:Boolean, param3:int) : *
      {
         var _loc4_:* = {
            "x":this.target.hitTarget.x,
            "y":this.target.hitTarget.y
         };
         var _loc5_:* = {
            "x":int((this.myPlayer.x + _loc4_.x) / 2),
            "y":int((this.myPlayer.y - this.myPlayer.height + _loc4_.y) / 2) - 200 - param1 * 100
         };
         this.itemThrowOperation(_loc4_,_loc5_,param2,param3,this.target.getGameId(),this.target.getTargetId());
      }
      
      protected function getItem(param1:int) : MovieClip
      {
         return new this.throwItems[int(Math.random() * this.throwItems.length)]();
      }
      
      public function playerThrowItemAt(param1:*, param2:*, param3:*, param4:*, param5:*) : *
      {
         var _loc6_:MovieClip;
         (_loc6_ = this.getItem(param5)).x = param1.x;
         _loc6_.y = param1.y;
         this.addItemToContainer(_loc6_);
         if(param4)
         {
            this.throwItemTween(_loc6_,param2,param3,param1,param5,param4,this.onItemFlightEnd);
         }
         else
         {
            this.throwItemTween(_loc6_,param2,param3,param1,param5,param4,this.onItemFlightEndMiss);
         }
      }
      
      public function addItemToContainer(param1:MovieClip) : *
      {
         this.thrownItemContainer.addChild(param1);
      }
      
      protected function itemThrowOperation(param1:*, param2:*, param3:Boolean, param4:*, param5:*, param6:*) : *
      {
         ThrowingGameHelper.ThrowItemAtTraget(param1,param2,param3,param4,param5,param6);
      }
      
      protected function performRoomEvent(param1:String, param2:int) : *
      {
      }
      
      private function throwItemTween(param1:MovieClip, param2:*, param3:*, param4:*, param5:int, param6:Boolean, param7:Function) : *
      {
         TweenMax.to(param1,1,{
            "x":param2.x,
            "y":param2.y,
            "ease":Linear.easeIn,
            "bezier":[{
               "x":param3.x,
               "y":param3.y
            }],
            "onComplete":param7,
            "onCompleteParams":[param1,param4,param5,param6]
         });
      }
      
      private function onItemFlightEndMiss(param1:MovieClip, param2:*, param3:int, param4:Boolean) : *
      {
         var _loc5_:* = int(Math.random() * 100) * (Math.random() > 0.5 ? 1 : -1);
         TweenMax.to(param1,0.7,{
            "x":param1.x + _loc5_,
            "y":param1.y + 100,
            "ease":Linear.easeIn,
            "bezier":[{
               "x":param1.x + _loc5_ / 2,
               "y":param1.y - 150
            }],
            "onComplete":this.onItemFlightEnd,
            "onCompleteParams":[param1,this.myPlayer,param3,param4]
         });
      }
      
      public function onItemFlightEnd(param1:MovieClip, param2:*, param3:int, param4:Boolean) : *
      {
         var _loc5_:* = undefined;
         param1.parent.removeChild(param1);
         if(param4)
         {
            (_loc5_ = new this.hitCount()).count.text = "" + param3;
            param2.showHitCount(_loc5_);
            this.performRoomEvent(param2.getPlayerName(),param3);
         }
         if(param2 == this.myPlayer)
         {
            this.target.shotFlightEnded(param4);
         }
      }
   }
}
