package com.vtweens.components.ads
{
   public class AdsSkippbleAdConfig
   {
       
      
      public var premium;
      
      public var maxCompleted;
      
      public var percentOnGames;
      
      public var volume;
      
      public var timeToShowSkip;
      
      public var links;
      
      public function AdsSkippbleAdConfig(param1:*)
      {
         var _loc2_:* = undefined;
         this.links = [];
         super();
         this.premium = int(param1.@premium);
         this.maxCompleted = int(param1.@maxComplete);
         this.percentOnGames = Number(param1.@percentOnGames);
         this.timeToShowSkip = int(param1.@timeToShowSkip);
         this.volume = Number(param1.@volume);
         for each(_loc2_ in param1.adlink)
         {
            this.links.push(String(_loc2_));
         }
      }
   }
}
