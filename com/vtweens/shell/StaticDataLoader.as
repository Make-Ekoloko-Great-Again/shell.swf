package com.vtweens.shell
{
   import com.adobe.serialization.json.JSONDecoder;
   import com.vtweens.consts.VERSION;
   import com.vtweens.util.Log;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class StaticDataLoader extends EventDispatcher
   {
      
      public static var ANIMALS_DATA = 0;
      
      public static var CARDS_DATA = 1;
      
      public static var CREDITS_STORE_STATIC_DATA_1 = 2;
      
      public static var CREDITS_STORE_STATIC_DATA_2 = 3;
      
      public static var EMOTICONS_DATA = 4;
      
      public static var GAMES_DATA = 5;
      
      public static var HOUSE_DATA = 6;
      
      public static var HOUSE_GARDEN_DATA = 7;
      
      public static var ITEMS_DATA = 8;
      
      public static var NPCS_DATA = 9;
      
      public static var QUEST_GROUPS_DATA = 10;
      
      public static var RECYCLE_ITEMS_DATA = 11;
      
      public static var ROOMS_DATA = 12;
      
      public static var SENIORITY_LEVELS_DATA = 13;
      
      public static var STORES_DATA_1 = 14;
      
      public static var STORES_DATA_2 = 15;
      
      public static var RECYCLE_BIN_DATA = 16;
      
      private static var resourceUrls:Array = ["ANIMALS_DATA","CARDS_DATA","CREDITS_STORE_STATIC_DATA_1","CREDITS_STORE_STATIC_DATA_2","EMOTICONS_DATA","GAMES_DATA","HOUSE_DATA","HOUSE_GARDEN_DATA","ITEMS_DATA","NPCS_DATA","QUEST_GROUPS_DATA","RECYCLE_ITEMS_DATA","ROOMS_DATA","SENIORITY_LEVELS_DATA","STORES_DATA_1","STORES_DATA_2","RECYCLE_BIN_DATA"];
      
      private static var dataArray:Array = new Array();
      
      private static var loaders:Array = new Array();
      
      private static var loadedStuff:int = 0;
      
      private static var singleton:StaticDataLoader = new StaticDataLoader();
       
      
      private var config:ServerConfig;
      
      public function StaticDataLoader()
      {
         super();
      }
      
      public static function AddEventListener(param1:String, param2:Function) : *
      {
         singleton.addEventListener(param1,param2,false,0,true);
         if(param1 == Event.COMPLETE && loadedStuff == resourceUrls.length)
         {
            singleton.dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      public static function RemoveEventListener(param1:String, param2:Function) : *
      {
         singleton.removeEventListener(param1,param2);
      }
      
      public static function Load(param1:*) : *
      {
         singleton.init(param1);
      }
      
      private static function getUrl(param1:ServerConfig, param2:int) : String
      {
         singleton.config = param1;
         return param1.getStaticDataUrl() + "/S_" + resourceUrls[param2] + ".json?version=" + VERSION.getStaticDataVersion(param2);
      }
      
      public static function getStaticData(param1:int) : *
      {
         return dataArray[param1];
      }
      
      private function init(param1:*) : *
      {
         var _loc2_:* = undefined;
         for(_loc2_ in resourceUrls)
         {
            loaders.push(new URLLoader());
            dataArray.push(null);
         }
         this.loadResources(param1);
      }
      
      private function loadResources(param1:*) : *
      {
         var _loc2_:* = undefined;
         for(_loc2_ in resourceUrls)
         {
            loaders[_loc2_].addEventListener(IOErrorEvent.IO_ERROR,this.onLoadError);
            loaders[_loc2_].addEventListener(Event.COMPLETE,this.onLoad);
            loaders[_loc2_].load(new URLRequest(getUrl(param1,_loc2_)));
         }
      }
      
      private function onLoadError(param1:IOErrorEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:URLLoader = null;
         for(_loc2_ in loaders)
         {
            _loc3_ = loaders[_loc2_];
            if(param1.target == _loc3_)
            {
               Log.error("StaticDataLoader bad JSON recieved loaderIndx[" + resourceUrls[_loc2_] + "] :" + param1);
            }
         }
         this.loaderFinished();
      }
      
      private function onLoad(param1:Event) : *
      {
         var loaderIndx:* = undefined;
         var loader:URLLoader = null;
         var data:* = undefined;
         var e:Event = param1;
         for(loaderIndx in loaders)
         {
            loader = loaders[loaderIndx];
            if(e.target == loader)
            {
               try
               {
                  data = new JSONDecoder(e.target.data).getValue();
                  dataArray[loaderIndx] = data;
               }
               catch(e:Error)
               {
                  Log.error("StaticDataLoader bad JSON recieved loaderIndx[" + resourceUrls[loaderIndx] + "] :" + e);
               }
            }
         }
         this.loaderFinished();
      }
      
      private function loaderFinished() : *
      {
         ++loadedStuff;
         if(loadedStuff == resourceUrls.length)
         {
            singleton.dispatchEvent(new Event(Event.COMPLETE));
         }
      }
   }
}
