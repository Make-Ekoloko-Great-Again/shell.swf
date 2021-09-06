package com.vtweens.components.loading_page
{
   import com.vtweens.util.Map;
   
   public class PagesData
   {
       
      
      private var _maxDaysPlayed:int;
      
      private var pagesArrays:Array;
      
      private var roomsMaps:Array;
      
      private var doorsMaps:Array;
      
      public function PagesData(param1:int, param2:*)
      {
         this.pagesArrays = [[],[]];
         this.roomsMaps = [new Map(),new Map()];
         this.doorsMaps = [new Map(),new Map()];
         super();
         this._maxDaysPlayed = param1;
         this.setData(param2);
      }
      
      public function get maxDaysPlayed() : int
      {
         return this._maxDaysPlayed;
      }
      
      public function getMsg(param1:int, param2:int, param3:int) : LoadingPageMessage
      {
         var _loc4_:LoadingPageMessage = null;
         if(this.doorsMaps[param1 - 1].get(param2) != null)
         {
            _loc4_ = this.doorsMaps[param1 - 1].get(param2) as LoadingPageMessage;
         }
         else if(this.roomsMaps[param1 - 1].get(param3) != null)
         {
            _loc4_ = this.roomsMaps[param1 - 1].get(param3) as LoadingPageMessage;
         }
         else
         {
            _loc4_ = this.pagesArrays[param1 - 1][int(Math.random() * this.pagesArrays[param1 - 1].length)] as LoadingPageMessage;
         }
         _loc4_.next();
         return _loc4_;
      }
      
      private function setData(param1:*) : *
      {
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc2_:* = param1.doors;
         var _loc3_:* = _loc2_.children().length();
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_)
         {
            _loc10_ = (_loc9_ = _loc2_.child(_loc4_)).attribute("id");
            this.doorsMaps[0].put(int(_loc10_),this.createMessage(_loc9_,"boy"));
            this.doorsMaps[1].put(int(_loc10_),this.createMessage(_loc9_,"girl"));
            _loc4_++;
         }
         var _loc5_:*;
         var _loc6_:* = (_loc5_ = param1.rooms).children().length();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc12_ = (_loc11_ = _loc5_.child(_loc4_)).attribute("id");
            this.roomsMaps[0].put(int(_loc12_),this.createMessage(_loc11_,"boy"));
            this.roomsMaps[1].put(int(_loc12_),this.createMessage(_loc11_,"girl"));
            _loc4_++;
         }
         var _loc7_:*;
         var _loc8_:* = (_loc7_ = param1.pages).children().length();
         _loc4_ = 0;
         while(_loc4_ < _loc8_)
         {
            _loc13_ = _loc7_.child(_loc4_);
            this.pagesArrays[1].push(this.createMessage(_loc13_,"girl"));
            this.pagesArrays[0].push(this.createMessage(_loc13_,"boy"));
            _loc4_++;
         }
      }
      
      private function createMessage(param1:*, param2:*) : *
      {
         var _loc8_:* = undefined;
         var _loc3_:* = param1.swfs;
         var _loc4_:* = _loc3_.children().length();
         var _loc5_:Array = [];
         var _loc6_:Array = [];
         var _loc7_:* = 0;
         while(_loc7_ < _loc4_)
         {
            if((_loc8_ = _loc3_.child(_loc7_)).attribute("gender") == param2 || _loc8_.attribute("gender") == "both")
            {
               _loc5_.push(_loc8_.attribute("src"));
               _loc6_.push(_loc8_.attribute("minDisplayTime"));
            }
            _loc7_++;
         }
         return new LoadingPageMessage(_loc5_,_loc6_);
      }
   }
}
