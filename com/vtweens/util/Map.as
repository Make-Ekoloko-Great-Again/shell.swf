package com.vtweens.util
{
   import com.adobe.utils.DictionaryUtil;
   import flash.utils.Dictionary;
   
   public class Map
   {
       
      
      private var map:Dictionary;
      
      private var numOfElements:int = 0;
      
      public function Map()
      {
         this.map = new Dictionary(true);
         super();
      }
      
      public function put(param1:Object, param2:Object) : Object
      {
         var _loc3_:* = this.map[param1];
         this.map[param1] = param2;
         if(_loc3_ == undefined)
         {
            ++this.numOfElements;
         }
         return _loc3_;
      }
      
      public function get(param1:Object) : *
      {
         return this.map[param1];
      }
      
      public function size() : int
      {
         return this.numOfElements;
      }
      
      public function isEmpty() : Boolean
      {
         return this.numOfElements == 0;
      }
      
      public function contains(param1:*) : Boolean
      {
         return this.get(param1) != null;
      }
      
      public function remove(param1:*) : *
      {
         var _loc2_:* = this.map[param1];
         if(_loc2_ != undefined)
         {
            --this.numOfElements;
         }
         this.map[param1] = null;
         return _loc2_;
      }
      
      public function removeAll() : *
      {
         this.map = new Dictionary(true);
      }
      
      public function getKeys() : Array
      {
         return DictionaryUtil.getKeys(this.map);
      }
      
      public function getValues() : Array
      {
         var _loc3_:* = undefined;
         var _loc1_:* = new Array();
         var _loc2_:Array = DictionaryUtil.getValues(this.map);
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_ != null)
            {
               _loc1_[_loc1_.length] = _loc3_;
            }
         }
         return _loc1_;
      }
      
      public function toString() : String
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc1_:* = "{ ";
         for each(_loc2_ in this.getKeys())
         {
            _loc3_ = this.get(_loc2_);
            if(_loc3_ != null)
            {
               _loc1_ += _loc2_ + ":" + _loc3_ + " ";
            }
         }
         return _loc1_ + "}";
      }
   }
}
