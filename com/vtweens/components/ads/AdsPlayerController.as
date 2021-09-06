package com.vtweens.components.ads
{
   import com.vtweens.util.MainGetter;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class AdsPlayerController
   {
      
      private static const SKIPPBLE = 0;
      
      private static const IDLE = 1;
      
      private static const BACKSTAGE = 2;
      
      private static const ROOM = 3;
      
      private static var activeAdType;
      
      private static var lastRoomId;
      
      private static var premium;
      
      private static var config:AdsPlayerConfigParser;
      
      private static var _instance:AdsPlayerController;
       
      
      private var adsPlayer:AdsPlayerLoader;
      
      private var activeAdAllowComplete;
      
      private var backstageAdsTimer:Timer;
      
      private var idletimeAdsTimer:Timer;
      
      private var idleTimeAdAutoRemovalTimer:Timer;
      
      public function AdsPlayerController()
      {
         super();
         if(!config)
         {
            config = new AdsPlayerConfigParser();
         }
      }
      
      public static function get instance() : AdsPlayerController
      {
         if(!_instance)
         {
            _instance = new AdsPlayerController();
         }
         return _instance;
      }
      
      public function setPremium(param1:Boolean) : *
      {
         premium = param1;
      }
      
      public function startBackstageAds() : void
      {
         if(this.backstageAdsTimer)
         {
            this.backstageAdsTimer.reset();
            this.backstageAdsTimer.removeEventListener(TimerEvent.TIMER,this.onBackstageTimerAdCompleted);
         }
         this.backstageAdsTimer = new Timer(int((config.backstage_minInterval + Math.random() * (config.backstage_maxInterval - config.backstage_minInterval)) * 1000),1);
         this.backstageAdsTimer.addEventListener(TimerEvent.TIMER,this.onBackstageTimerAdCompleted,false,0,true);
         this.backstageAdsTimer.start();
      }
      
      public function startIdleTimeAds() : *
      {
         if(!this.idletimeAdsTimer)
         {
            this.idletimeAdsTimer = new Timer(config.idletime_startsAfter * 1000,1);
            this.idletimeAdsTimer.addEventListener(TimerEvent.TIMER,this.onIdletimeTimerAdCompleted,false,0,true);
            this.idletimeAdsTimer.start();
            this.idleTimeAdAutoRemovalTimer = new Timer(15000);
            this.idleTimeAdAutoRemovalTimer.addEventListener(TimerEvent.TIMER,this.onIdletimeAutoRemoveAdTimer,false,0,true);
         }
      }
      
      public function nextIdleTimeAd() : *
      {
         var _loc1_:* = int((config.idletime_minInterval + Math.random() * (config.idletime_maxInterval - config.idletime_minInterval)) * 1000);
         if(this.idletimeAdsTimer)
         {
            this.idletimeAdsTimer.reset();
            this.idletimeAdsTimer.removeEventListener(TimerEvent.TIMER,this.onIdletimeTimerAdCompleted);
         }
         this.idletimeAdsTimer = new Timer(_loc1_,1);
         this.idletimeAdsTimer.addEventListener(TimerEvent.TIMER,this.onIdletimeTimerAdCompleted,false,0,true);
         this.idletimeAdsTimer.start();
      }
      
      public function stopIdleTimeAds() : *
      {
         if(this.idletimeAdsTimer)
         {
            this.idletimeAdsTimer.reset();
         }
         this.idletimeAdsTimer = null;
         if(activeAdType == IDLE && !config.idletime_showSkip)
         {
            this.stopAndRemoveAd();
         }
      }
      
      public function playRoomPreloaderAd(param1:int) : *
      {
         var _loc3_:* = undefined;
         var _loc2_:* = config.dataByRoomId(param1);
         if(_loc2_)
         {
            _loc3_ = _loc2_.links[Math.floor(Math.random() * _loc2_.links.length)];
            if((!premium || _loc2_.premium > 0) && !this.adsPlayer && _loc2_.maxCompleted > 0)
            {
               activeAdType = ROOM;
               lastRoomId = param1;
               this.playAd(_loc3_,_loc2_.timeToShowSkip,1,false,_loc2_.volume);
            }
         }
      }
      
      public function playSkippbleAd(param1:Boolean = true) : *
      {
         if(param1 && Math.random() > config.skippble.percentOnGames)
         {
            return;
         }
         var _loc2_:* = config.skippble.links[Math.floor(Math.random() * config.skippble.links.length)];
         if((!premium || config.skippble.premium > 0) && !this.adsPlayer && config.skippble.maxCompleted > 0)
         {
            activeAdType = SKIPPBLE;
            this.playAd(_loc2_,config.skippble.timeToShowSkip,1,false,config.skippble.volume);
         }
      }
      
      public function stopAndRemoveAd(param1:* = null) : *
      {
         ShellAdsPlayer.instance.removeAd();
      }
      
      private function playIdleTimeAd() : *
      {
         var _loc1_:* = config.idletime_links[Math.floor(Math.random() * config.idletime_links.length)];
         if((!premium || config.idletime_premium > 0) && !this.adsPlayer && config.idletime_maxCompleted > 0)
         {
            activeAdType = IDLE;
            this.playAd(_loc1_,config.idletime_showSkip > 0 ? 0 : -1,config.idletime_percentComplete,config.idletime_backstage > 0,config.idletime_volume);
            this.idleTimeAdAutoRemovalTimer.start();
         }
      }
      
      private function playBackstageAd() : *
      {
         var _loc1_:* = config.backstage_links[Math.floor(Math.random() * config.backstage_links.length)];
         if((!premium || config.backstage_premium > 0) && !this.adsPlayer && config.backstage_maxCompleted > 0)
         {
            activeAdType = BACKSTAGE;
            this.playAd(_loc1_,-1,config.backstage_percentComplete,true,config.backstage_volume);
         }
      }
      
      private function playAd(param1:*, param2:* = 0, param3:* = 1, param4:* = false, param5:* = 0.2) : *
      {
         this.idleTimeAdAutoRemovalTimer.reset();
         if(MainGetter.MainCaller.DaysPlayed >= config.minDaysPlayed)
         {
            ShellAdsPlayer.instance.loadAd(param1);
         }
      }
      
      private function onBackstageTimerAdCompleted(param1:TimerEvent) : void
      {
         this.playBackstageAd();
      }
      
      private function onIdletimeTimerAdCompleted(param1:TimerEvent) : void
      {
         this.playIdleTimeAd();
      }
      
      private function onIdletimeAutoRemoveAdTimer(param1:*) : *
      {
         this.idleTimeAdAutoRemovalTimer.reset();
         if(activeAdType == IDLE)
         {
            this.stopAndRemoveAd();
         }
      }
      
      public function adRemoved(param1:Boolean) : *
      {
         var _loc2_:* = undefined;
         this.adsPlayer = null;
         switch(activeAdType)
         {
            case IDLE:
               if(param1)
               {
                  --config.idletime_maxCompleted;
               }
               if(config.idletime_maxCompleted > 0)
               {
                  this.nextIdleTimeAd();
               }
               break;
            case SKIPPBLE:
               if(param1)
               {
                  --config.skippble.maxCompleted;
               }
               break;
            case BACKSTAGE:
               if(param1)
               {
                  --config.backstage_maxCompleted;
               }
               if(config.backstage_maxCompleted > 0)
               {
                  this.startBackstageAds();
               }
               break;
            case ROOM:
               if(param1)
               {
                  _loc2_ = config.dataByRoomId(lastRoomId);
                  if(_loc2_)
                  {
                     --_loc2_.maxCompleted;
                  }
                  lastRoomId = null;
               }
               if(config.backstage_maxCompleted > 0)
               {
                  this.startBackstageAds();
               }
         }
      }
   }
}
