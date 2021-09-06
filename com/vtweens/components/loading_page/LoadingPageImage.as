package com.vtweens.components.loading_page
{
   import com.vtweens.consts.VERSION;
   import com.vtweens.util.DisplayObjectContainerUtils;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   
   public class LoadingPageImage extends MovieClip
   {
       
      
      private var mc:MovieClip;
      
      private var loader:Loader;
      
      private var url:String;
      
      public function LoadingPageImage(param1:String = null)
      {
         super();
         this.url = param1;
      }
      
      private function load() : *
      {
         this.loader = new Loader();
         if(this.url == null)
         {
            this.onImageLoadError(null);
            return;
         }
         var _loc1_:URLRequest = new URLRequest(this.url + "?r=" + VERSION.PRELOADERS_VERSION);
         this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onImageLoad,false,0,true);
         this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onImageLoadError,false,0,true);
         this.loader.load(_loc1_);
      }
      
      private function onImageLoad(param1:Event) : *
      {
         param1.target.removeEventListener(Event.COMPLETE,this.onImageLoad);
         param1.target.removeEventListener(IOErrorEvent.IO_ERROR,this.onImageLoadError);
         if(this.loader)
         {
            this.mc = this.loader.content as MovieClip;
            this.mc.gotoAndStop(1);
            this.show();
         }
      }
      
      private function onImageLoadError(param1:*) : *
      {
         this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onImageLoad);
         this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onImageLoadError);
         this.mc = new MovieClip();
         this.show();
      }
      
      public function show() : *
      {
         if(this.loader == null)
         {
            this.load();
         }
         else
         {
            this.loader = null;
            if(this.mc)
            {
               addChild(this.mc);
               this.mc.gotoAndPlay(1);
            }
         }
      }
      
      public function hide() : *
      {
         if(this.mc && contains(this.mc))
         {
            removeChild(this.mc);
         }
         if(this.mc)
         {
            DisplayObjectContainerUtils.stopHierarchy(this.mc);
         }
      }
   }
}
