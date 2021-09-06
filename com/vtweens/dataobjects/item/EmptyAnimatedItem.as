package com.vtweens.dataobjects.item
{
   import flash.display.MovieClip;
   
   public class EmptyAnimatedItem extends AnimatedItem
   {
       
      
      public var layerId = null;
      
      public function EmptyAnimatedItem(param1:int)
      {
         super();
         this.layerId = param1;
      }
      
      override public function getLayerId() : int
      {
         return this.layerId;
      }
      
      override public function getOrdinal() : int
      {
         return 0;
      }
      
      override public function isLoaded() : Boolean
      {
         return true;
      }
      
      override public function gotoAndPlayAction(param1:int) : *
      {
      }
      
      override public function gotoAndStopAction(param1:int) : *
      {
      }
      
      override public function setFaceEmotion(param1:String) : *
      {
      }
      
      override public function deactivate() : *
      {
      }
      
      override public function get mc() : MovieClip
      {
         return new MovieClip();
      }
      
      override public function setMask(param1:AnimatedItem) : *
      {
      }
      
      override public function removeMask() : *
      {
      }
   }
}
