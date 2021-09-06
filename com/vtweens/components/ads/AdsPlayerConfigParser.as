package com.vtweens.components.ads
{
   import com.vtweens.util.Map;
   import com.vtweens.util.XmlParser;
   
   public class AdsPlayerConfigParser extends XmlParser
   {
       
      
      public var idletime_premium;
      
      public var idletime_backstage;
      
      public var idletime_percentComplete;
      
      public var idletime_maxCompleted;
      
      public var idletime_showSkip;
      
      public var idletime_startsAfter;
      
      public var idletime_minInterval;
      
      public var idletime_maxInterval;
      
      public var idletime_volume;
      
      public var idletime_links;
      
      public var backstage_premium;
      
      public var backstage_percentComplete;
      
      public var backstage_maxCompleted;
      
      public var backstage_minInterval;
      
      public var backstage_maxInterval;
      
      public var backstage_volume;
      
      public var backstage_links;
      
      public var skippble;
      
      private var adsDataByRoomId;
      
      private var adsIdleTimeInstances:Array;
      
      public var minDaysPlayed = 9999;
      
      public function AdsPlayerConfigParser()
      {
         this.idletime_links = [];
         this.backstage_links = [];
         this.adsDataByRoomId = new Map();
         this.adsIdleTimeInstances = [];
         super();
         loadData();
      }
      
      public function dataByRoomId(param1:int) : *
      {
         return this.adsDataByRoomId.get(param1);
      }
      
      override protected function get xmlUrl() : String
      {
         return "./conf/ads_player_definitions.xml?v=" + Math.random();
      }
      
      override protected function parse(param1:XML) : *
      {
         var _loc2_:* = undefined;
         this.idletime_premium = int(param1.idletime.@premium);
         this.idletime_percentComplete = Number(param1.idletime.@percentComplete);
         this.idletime_maxCompleted = int(param1.idletime.@maxComplete);
         this.idletime_showSkip = int(param1.idletime.@showSkip);
         this.idletime_startsAfter = int(param1.idletime.@startsAfter);
         this.idletime_minInterval = int(param1.idletime.@minInterval);
         this.idletime_maxInterval = int(param1.idletime.@maxInterval);
         this.idletime_backstage = int(param1.idletime.@backstage);
         for each(_loc2_ in param1.idletime.adlink)
         {
            this.idletime_links.push(String(_loc2_));
         }
         this.backstage_premium = int(param1.backstage.@premium);
         this.backstage_percentComplete = Number(param1.backstage.@percentComplete);
         this.backstage_maxCompleted = int(param1.backstage.@maxComplete);
         this.backstage_minInterval = int(param1.backstage.@minInterval);
         this.backstage_maxInterval = int(param1.backstage.@maxInterval);
         for each(_loc2_ in param1.backstage.adlink)
         {
            this.backstage_links.push(String(_loc2_));
         }
         this.skippble = new AdsSkippbleAdConfig(param1.skippble);
         for each(_loc2_ in param1.rooms.skippble)
         {
            this.adsDataByRoomId.put(int(_loc2_.@roomId),new AdsSkippbleAdConfig(_loc2_));
         }
         this.minDaysPlayed = int(param1.minDaysPlayed.@days);
         isLoaded = true;
      }
   }
}
