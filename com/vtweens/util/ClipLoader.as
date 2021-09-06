package com.vtweens.util
{
   import com.adobe.errors.IllegalStateError;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   
   public class ClipLoader extends EventDispatcher
   {
       
      
      protected var loader:Loader;
      
      protected var clip:MovieClip = null;
      
      public function ClipLoader()
      {
         this.loader = new Loader();
         super();
      }
      
      public function get isLoaded() : Boolean
      {
         return this.loader == null;
      }
      
      protected function getClipURL() : *
      {
         throw new IllegalStateError("Abstract. impplementation required");
      }
      
      public function getFileName() : *
      {
         return this.getClipURL();
      }
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         super.addEventListener(param1,param2,param3,param4,param5);
         if(param1 == Event.COMPLETE && this.isLoaded)
         {
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      private function onClipLoaded(param1:*) : *
      {
         this.clip = param1.target.content;
         this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onClipLoaded);
         this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onMCLoadError);
         this.loader = null;
         DisplayObjectContainerUtils.stopAndRemoveHierarchy(this.clip);
         this.onClipLoadedEvent();
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      protected function onClipLoadedEvent() : *
      {
      }
      
      private function onMCLoadError(param1:IOErrorEvent) : *
      {
         this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onClipLoaded);
         this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onMCLoadError);
         this.loader = null;
         this.clip = new MovieClip();
         dispatchEvent(new Event(Event.COMPLETE));
         Log.error("ClipLoader error loading: " + this.getClipURL() + " -> " + param1);
      }
      
      protected function loadClip() : *
      {
         this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onClipLoaded);
         this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onMCLoadError);
         var _loc1_:URLRequest = new URLRequest(this.getClipURL());
         this.loader.load(_loc1_);
      }
      
      public function getClip() : MovieClip
      {
         var _loc1_:* = Object(this.clip).constructor;
         var _loc2_:* = new _loc1_();
         _loc2_.gotoAndStop(1);
         return _loc2_;
      }
   }
}
