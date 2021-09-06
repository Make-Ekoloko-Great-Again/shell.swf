package com.vtweens.dataobjects.item
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.errors.IllegalOperationError;
   
   public class AnimatedItem extends Sprite
   {
       
      
      public function AnimatedItem()
      {
         super();
      }
      
      public function getLayerId() : int
      {
         throw new IllegalOperationError("Abstract class function not supported");
      }
      
      public function getOrdinal() : int
      {
         throw new IllegalOperationError("Abstract class function not supported");
      }
      
      public function gotoAndPlayAction(param1:int) : *
      {
         throw new IllegalOperationError("Abstract class function not supported");
      }
      
      public function gotoAndStopAction(param1:int) : *
      {
         throw new IllegalOperationError("Abstract class function not supported");
      }
      
      public function setFaceEmotion(param1:String) : *
      {
         throw new IllegalOperationError("Abstract class function not supported");
      }
      
      public function isLoaded() : Boolean
      {
         throw new IllegalOperationError("Abstract class function not supported");
      }
      
      public function deactivate() : *
      {
         throw new IllegalOperationError("Abstract class function not supported");
      }
      
      public function setMask(param1:AnimatedItem) : *
      {
         throw new IllegalOperationError("Abstract class function not supported");
      }
      
      public function removeMask() : *
      {
         throw new IllegalOperationError("Abstract class function not supported");
      }
      
      public function get mc() : MovieClip
      {
         throw new IllegalOperationError("Abstract class function not supported");
      }
   }
}
