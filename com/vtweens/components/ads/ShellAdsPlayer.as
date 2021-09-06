package com.vtweens.components.ads
{
   import com.vtweens.util.LayerOrganizer;
   import fl.video.VideoEvent;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import gs.TweenLite;
   
   public class ShellAdsPlayer
   {
      
      private static const adLink1 = "http://googleads.g.doubleclick.net/pagead/ads?ad_type=image_text_video_flash&client=ca-games-pub-4968145218643279&videoad_start_delay=0&description_url=http%3A%2F%2Fwww.ekoloko.com&hl=en&max_ad_duration=40000&adtest=on";
      
      private static const adLink2 = "http://googleads.g.doubleclick.net/pagead/ads?ad_type=image_text_flash&client=ca-games-pub-4968145218643279&videoad_start_delay=0&description_url=http%3A%2F%2Fwww.ekoloko.com&hl=en&max_ad_duration=40000&adtest=on";
      
      private static var _instance:ShellAdsPlayer;
       
      
      private var loader:Loader;
      
      private var baseUrl:String = ".";
      
      private var volume;
      
      private var videoPlayer;
      
      private var playerContainer;
      
      private var adsPlayerBG;
      
      public function ShellAdsPlayer()
      {
         this.loader = new Loader();
         super();
      }
      
      public static function get instance() : ShellAdsPlayer
      {
         if(!_instance)
         {
            _instance = new ShellAdsPlayer();
         }
         return _instance;
      }
      
      public function init(param1:*, param2:*, param3:* = null) : *
      {
         if(param3)
         {
            this.baseUrl = param3;
         }
         this.playerContainer = param1;
         this.adsPlayerBG = param2;
         param1.visible = false;
         param2.visible = false;
         param2.addEventListener(MouseEvent.CLICK,this.blockClick);
      }
      
      private function blockClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
      }
      
      public function loadAd(param1:*) : void
      {
         var _loc2_:URLRequest = new URLRequest(this.baseUrl + "/ima_preloader.swf");
         var _loc3_:URLVariables = new URLVariables();
         _loc3_.adTagUrl = param1;
         _loc2_.data = _loc3_;
         this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.playerLoaded,false,0,true);
         this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.loadError,false,0,true);
         this.loader.load(_loc2_);
         this.playerContainer.addChild(this.loader);
         this.playerContainer.visible = true;
         this.adsPlayerBG.visible = true;
      }
      
      private function playerLoaded(param1:Event) : void
      {
         this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.playerLoaded);
         this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.loadError);
         this.videoPlayer = param1.target.content;
         this.videoPlayer.addEventListener(VideoEvent.COMPLETE,this.contentCompleteHandler,false,0,true);
         this.videoPlayer.addEventListener(VideoEvent.CLOSE,this.contentCompleteHandler,false,0,true);
         this.videoPlayer.scaleX = this.videoPlayer.scaleY = 0.4;
         this.videoPlayer.x = 960 * 0.6 / 2;
         this.videoPlayer.y = 600 * 0.6 / 2;
         TweenLite.to(this.videoPlayer,1.5,{
            "delay":0.5,
            "scaleX":0.98,
            "scaleY":0.98,
            "x":(960 - 960 * 0.98) / 2,
            "y":(600 - 600 * 0.98) / 2
         });
         this.playerContainer.addChild(this.videoPlayer);
         LayerOrganizer.MoveToTop(this.adsPlayerBG);
         LayerOrganizer.MoveToTop(this.playerContainer);
      }
      
      private function loadError(param1:IOErrorEvent) : void
      {
         this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.playerLoaded);
         this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.loadError);
         this.removeAd();
      }
      
      public function contentCompleteHandler(param1:Event) : void
      {
         this.removeAd();
      }
      
      public function removeAd() : *
      {
         try
         {
            if(this.videoPlayer && this.playerContainer.contains(this.videoPlayer))
            {
               this.playerContainer.removeChild(this.videoPlayer);
            }
            this.videoPlayer.stop();
            this.videoPlayer.removeEventListener(VideoEvent.COMPLETE,this.contentCompleteHandler);
            this.videoPlayer.removeEventListener(VideoEvent.CLOSE,this.contentCompleteHandler);
         }
         catch(e:*)
         {
         }
         AdsPlayerController.instance.adRemoved(true);
         this.playerContainer.visible = false;
         this.adsPlayerBG.visible = false;
         this.videoPlayer = null;
         LayerOrganizer.MoveToBack(this.adsPlayerBG);
         LayerOrganizer.MoveToBack(this.playerContainer);
         this.loader = new Loader();
      }
   }
}
