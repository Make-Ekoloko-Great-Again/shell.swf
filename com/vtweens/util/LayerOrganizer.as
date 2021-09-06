package com.vtweens.util
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   
   public class LayerOrganizer
   {
      
      public static const BUBBLE = 1;
      
      public static const QUICK = 2;
       
      
      private var container2Organize:DisplayObjectContainer = null;
      
      private var sortMethod = 1;
      
      public function LayerOrganizer(param1:DisplayObjectContainer, param2:int = 1)
      {
         super();
         this.container2Organize = param1;
         this.sortMethod = param2;
      }
      
      public static function MoveToTop(param1:DisplayObject) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc2_:DisplayObjectContainer = param1.parent;
         if(_loc2_)
         {
            _loc3_ = _loc2_.getChildIndex(param1);
            _loc4_ = _loc2_.numChildren;
            _loc5_ = _loc3_;
            while(_loc3_ < _loc4_ - 1)
            {
               _loc2_.swapChildrenAt(_loc3_,++_loc5_);
               _loc3_ = _loc2_.getChildIndex(param1);
            }
         }
      }
      
      public static function MoveToBack(param1:DisplayObject) : *
      {
         var _loc3_:* = undefined;
         var _loc2_:* = param1.parent;
         if(_loc2_)
         {
            _loc3_ = _loc2_.getChildIndex(param1);
            while(_loc3_ > 0)
            {
               _loc2_.swapChildrenAt(_loc3_,_loc3_ - 1);
               _loc3_--;
            }
         }
      }
      
      public static function TraceLayerChildren(param1:DisplayObjectContainer, param2:* = 1000, param3:int = 0) : *
      {
         var mc:DisplayObjectContainer = param1;
         var maxIndx:* = param2;
         var tabIndx:int = param3;
         var trcStrg:String = "";
         var tab:* = 0;
         while(tab < tabIndx)
         {
            trcStrg += "--";
            tab++;
         }
         var i:* = 0;
         while(true)
         {
            try
            {
               mc.getChildAt(i);
            }
            catch(e:*)
            {
               break;
            }
            try
            {
               if(tabIndx < maxIndx)
               {
                  TraceLayerChildren(DisplayObjectContainer(mc.getChildAt(i)),maxIndx,tabIndx + 1);
               }
            }
            catch(e:*)
            {
               continue;
            }
         }
      }
      
      public function deactivate() : *
      {
         this.container2Organize = null;
      }
      
      public function eventListener(param1:*) : *
      {
         if(this.sortMethod == BUBBLE)
         {
            this.bubbleSort();
         }
         else
         {
            this.quickSort();
         }
      }
      
      public function set method(param1:int) : *
      {
         if(param1 == BUBBLE || param1 == QUICK)
         {
            this.sortMethod = param1;
         }
      }
      
      public function get method() : *
      {
         return this.sortMethod;
      }
      
      private function quickSort() : *
      {
         var _loc1_:Array = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < this.container2Organize.numChildren)
         {
            _loc1_[_loc1_.length] = this.container2Organize.getChildAt(_loc2_);
            _loc2_++;
         }
         _loc1_.sortOn("y",Array.NUMERIC);
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            this.container2Organize.setChildIndex(_loc1_[_loc2_],_loc2_);
            _loc2_++;
         }
      }
      
      private function bubbleSort() : *
      {
         this.bubbleSortTraverse();
         while(this.bubbleSortTraverse())
         {
         }
      }
      
      private function bubbleSortTraverse() : Boolean
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc1_:* = this.container2Organize.numChildren;
         var _loc2_:Boolean = false;
         var _loc3_:* = 0;
         while(_loc3_ < _loc1_ - 1)
         {
            _loc4_ = this.container2Organize.getChildAt(_loc3_);
            _loc5_ = this.container2Organize.getChildAt(_loc3_ + 1);
            if(_loc4_.y > _loc5_.y)
            {
               this.container2Organize.swapChildren(_loc4_,_loc5_);
               _loc2_ = true;
            }
            _loc3_++;
         }
         return _loc2_;
      }
   }
}
