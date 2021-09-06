package com.vtweens.components.loading_page
{
   import flash.display.MovieClip;
   
   public class LoadingPageMessage extends MovieClip
   {
       
      
      var swfs:Array;
      
      var times:Array;
      
      var currMsg:int = 0;
      
      public function LoadingPageMessage(param1:Array, param2:Array)
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         this.swfs = [];
         this.times = [];
         super();
         for each(_loc3_ in param1)
         {
            this.swfs.push(new LoadingPageImage(_loc3_));
         }
         for each(_loc4_ in param2)
         {
            this.times.push(_loc4_);
         }
      }
      
      public function get swf() : LoadingPageImage
      {
         return this.swfs[this.currMsg % this.swfs.length];
      }
      
      public function get time() : Number
      {
         return this.times[this.currMsg % this.times.length];
      }
      
      public function next() : *
      {
         ++this.currMsg;
      }
   }
}
