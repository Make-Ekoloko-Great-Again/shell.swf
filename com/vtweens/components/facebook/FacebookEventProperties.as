package com.vtweens.components.facebook
{
   public class FacebookEventProperties
   {
       
      
      private var _images:Array;
      
      private var _clips:Array;
      
      private var _id:int;
      
      private var _showAllImages:Boolean;
      
      private var _active:Boolean;
      
      public function FacebookEventProperties(param1:*)
      {
         this._images = [];
         this._clips = [];
         super();
         this._id = param1.attribute("id");
         this._showAllImages = String(param1.attribute("showAllImages")) == "true";
         this._active = String(param1.attribute("status")) == "on";
         var _loc2_:* = param1.images;
         var _loc3_:* = _loc2_.children().length();
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_)
         {
            this._images.push(_loc2_.child(_loc4_).attribute("url"));
            _loc4_++;
         }
         var _loc5_:*;
         var _loc6_:* = (_loc5_ = param1.clips).children().length();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            this._clips.push(_loc5_.child(_loc4_).attribute("url"));
            _loc4_++;
         }
      }
      
      public function get clips() : Array
      {
         return this._clips;
      }
      
      public function get hasClips() : Boolean
      {
         return this._clips.length > 0;
      }
      
      public function get images() : Array
      {
         return this._images;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get showAllImages() : Boolean
      {
         return this._showAllImages;
      }
      
      public function get randomImage() : String
      {
         return this._images[int(Math.random() * this._images.length)];
      }
      
      public function get randomClip() : String
      {
         return this._clips[int(Math.random() * this._clips.length)];
      }
      
      public function get active() : Boolean
      {
         return this._active;
      }
   }
}
