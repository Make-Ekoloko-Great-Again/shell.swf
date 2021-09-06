package com.vtweens.util
{
   public class P2PData
   {
      
      public static const LEFT:Boolean = false;
      
      public static const RIGHT:Boolean = true;
      
      public static const NNE_ANGLE = 60;
      
      public static const NEE_ANGLE = 20;
      
      public static const ERROR = -1;
      
      public static const S = 0;
      
      public static const W = 1;
      
      public static const N = 2;
      
      public static const E = 3;
      
      public static const SE = 4;
      
      public static const SW = 5;
      
      public static const NW = 6;
      
      public static const NE = 7;
       
      
      private var dx:int;
      
      private var dy:int;
      
      private var dist:int;
      
      private var rad:Number;
      
      private var rad2:Number;
      
      private var deg:int;
      
      private var leftRight:Boolean;
      
      public function P2PData(param1:*, param2:*, param3:*, param4:*)
      {
         super();
         this.dx = param1 - param3;
         this.dy = param2 - param4;
         this.dy = Math.abs(this.dy) < 1 ? 0 : int(this.dy);
         this.dist = Math.sqrt(Math.pow(this.dx,2) + Math.pow(this.dy,2));
         this.rad = Math.asin(this.dy / this.dist);
         this.rad2 = Math.atan2(this.dy,this.dx);
         this.deg = 180 * this.rad / Math.PI;
         this.leftRight = this.dx > 0 ? Boolean(LEFT) : Boolean(RIGHT);
      }
      
      public static function GetTileDirection(param1:*, param2:*) : int
      {
         if(param1 == null || param2 == null)
         {
            return ERROR;
         }
         var _loc3_:* = param1.center.x;
         var _loc4_:* = param1.center.y;
         var _loc5_:* = param2.center.x;
         var _loc6_:* = param2.center.y;
         var _loc7_:int = ERROR;
         if(_loc3_ > _loc5_)
         {
            if(_loc4_ > _loc6_)
            {
               _loc7_ = NW;
            }
            else if(_loc4_ < _loc6_)
            {
               _loc7_ = SW;
            }
            else
            {
               _loc7_ = W;
            }
         }
         else if(_loc3_ < _loc5_)
         {
            if(_loc4_ > _loc6_)
            {
               _loc7_ = NE;
            }
            else if(_loc4_ < _loc6_)
            {
               _loc7_ = SE;
            }
            else
            {
               _loc7_ = E;
            }
         }
         else if(_loc4_ > _loc6_)
         {
            _loc7_ = N;
         }
         else
         {
            _loc7_ = S;
         }
         return _loc7_;
      }
      
      public function getAngleDeg() : int
      {
         return this.deg;
      }
      
      public function getAngleRad() : Number
      {
         return this.rad;
      }
      
      public function getAngleRad360() : Number
      {
         return this.rad2;
      }
      
      public function getDistance() : int
      {
         return this.dist;
      }
      
      public function getLeftRight() : int
      {
         return !!this.leftRight ? 1 : -1;
      }
      
      public function getDirection() : int
      {
         var _loc1_:int = 0;
         var _loc2_:* = this.getAngleDeg();
         if(_loc2_ >= NNE_ANGLE)
         {
            _loc1_ = N;
         }
         else if(NNE_ANGLE > _loc2_ && _loc2_ > NEE_ANGLE)
         {
            if(this.leftRight == RIGHT)
            {
               _loc1_ = NW;
            }
            else
            {
               _loc1_ = NE;
            }
         }
         else if(-NEE_ANGLE <= _loc2_ && _loc2_ <= NEE_ANGLE)
         {
            if(this.leftRight == RIGHT)
            {
               _loc1_ = E;
            }
            else
            {
               _loc1_ = W;
            }
         }
         else if(-NNE_ANGLE < _loc2_ && _loc2_ < -NEE_ANGLE)
         {
            if(this.leftRight == RIGHT)
            {
               _loc1_ = SE;
            }
            else
            {
               _loc1_ = SW;
            }
         }
         else if(_loc2_ <= -NNE_ANGLE)
         {
            _loc1_ = S;
         }
         return _loc1_;
      }
   }
}
