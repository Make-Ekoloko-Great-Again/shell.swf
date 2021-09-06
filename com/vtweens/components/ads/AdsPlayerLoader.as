package com.vtweens.components.ads
{
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   
   public class AdsPlayerLoader extends Sprite
   {
       
      
      private var loader:Loader;
      
      private var baseUrl:String;
      
      private var player;
      
      private var allowComplete;
      
      private var allowSkipAfter;
      
      private var volume;
      
      private var adLink:String;
      
      private var controller;
      
      public function AdsPlayerLoader(param1:String, param2:*, param3:Boolean = true, param4:* = 0, param5:* = 0.2, param6:String = ".")
      {
         this.loader = new Loader();
         super();
         this.baseUrl = param6;
         this.adLink = param1;
         this.allowSkipAfter = param4;
         this.allowComplete = param3;
         this.controller = param2;
         this.volume = param5;
         this.load();
      }
      
      private function load() : *
      {
         var _loc1_:URLRequest = new URLRequest(this.baseUrl + "/main_components/adsPlayer.swf?v=" + Math.random());
         this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadComplete,false,0,true);
         this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadError,false,0,true);
         this.loader.load(_loc1_);
      }
      
      private function onLoadComplete(param1:Event) : *
      {
         param1.target.removeEventListener(Event.COMPLETE,this.onLoadComplete);
         param1.target.removeEventListener(IOErrorEvent.IO_ERROR,this.onLoadError);
         this.player = this.loader.content;
         this.player.setCaller(this);
         addChild(this.player);
         this.player.startAd(this.adLink,this.allowComplete,this.allowSkipAfter,this.volume);
         stage.focus = this.player;
      }
      
      private function onLoadError(param1:*) : *
      {
         this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoadComplete);
         this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onLoadError);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function stopAndRemove() : *
      {
         this.player.stopAndRemove();
      }
      
      public function playerCompleted(param1:Event = null, param2:* = false) : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
         if(this.controller)
         {
            this.controller.adRemoved(param2);
         }
      }
   }
}
