package com.vtweens.dataobjects.throwing
{
   import flash.display.MovieClip;
   import flash.errors.IllegalOperationError;
   
   public class ThrowingGameGauge extends MovieClip
   {
       
      
      private var _level:int;
      
      public function ThrowingGameGauge()
      {
         super();
      }
      
      public function deactivate() : void
      {
         throw new IllegalOperationError("Abstract class must be implemented by inheriting class");
      }
      
      protected function setGaugeDiaplay(param1:int) : void
      {
         throw new IllegalOperationError("Abstract class must be implemented by inheriting class");
      }
      
      protected function startGaugeAnimation() : void
      {
         throw new IllegalOperationError("Abstract class must be implemented by inheriting class");
      }
      
      public function reset() : void
      {
         throw new IllegalOperationError("Abstract class must be implemented by inheriting class");
      }
      
      public function checkHit() : Boolean
      {
         throw new IllegalOperationError("Abstract class must be implemented by inheriting class");
      }
      
      public function getNormalizedPower() : Number
      {
         throw new IllegalOperationError("Abstract class must be implemented by inheriting class");
      }
      
      public final function start(param1:int) : *
      {
         this._level = param1;
         this.setGaugeDiaplay(this._level);
         this.startGaugeAnimation();
      }
      
      public final function get level() : int
      {
         return this._level;
      }
   }
}
