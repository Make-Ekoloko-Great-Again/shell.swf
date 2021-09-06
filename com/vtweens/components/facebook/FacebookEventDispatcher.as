package com.vtweens.components.facebook
{
   import com.vtweens.consts.ITEM_TYPES;
   import com.vtweens.shell.ServerConfig;
   import com.vtweens.text.StringUtils;
   import com.vtweens.text.TextResourceManager;
   import com.vtweens.util.HtmlNavigation;
   import com.vtweens.util.MainGetter;
   import com.vtweens.util.Map;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class FacebookEventDispatcher extends EventDispatcher
   {
      
      private static var serverConfig:ServerConfig;
      
      private static var username:String;
      
      public static var shouldShare:Boolean = false;
      
      private static var eventProperties:Map = new Map();
      
      private static var event:FacebookEvent = null;
      
      private static var timer:Timer = new Timer(2500,1);
      
      private static var instance:FacebookEventDispatcher;
       
      
      public function FacebookEventDispatcher()
      {
         super();
      }
      
      public static function setConfig(param1:ServerConfig, param2:String) : *
      {
         serverConfig = param1;
         username = param2;
         instance = new FacebookEventDispatcher();
         FacebookEventDataLoader.load();
         timer.addEventListener(TimerEvent.TIMER,onTimerEvent);
      }
      
      public static function addEventProperties(param1:FacebookEventProperties) : *
      {
         eventProperties.put(param1.id,param1);
      }
      
      private static function onTimerEvent(param1:TimerEvent) : void
      {
         if(event)
         {
            openSharePopup(event);
            event = null;
            timer.reset();
         }
      }
      
      private static function openSharePopup(param1:FacebookEvent) : *
      {
         MainGetter.MainCaller.facebookConfirmPopup(param1);
      }
      
      public static function openFBFrame(param1:FacebookEvent) : void
      {
         HtmlNavigation.openNewWindow(param1.url);
      }
      
      private static function dispatch(param1:FacebookEvent) : void
      {
         if(shouldShare)
         {
            timer.reset();
            event = param1;
            timer.delay = param1.timeToPop;
            timer.start();
         }
      }
      
      public static function login(param1:*) : *
      {
         var _loc2_:String = FacebookEventsTextData.instance.getTitle(FacebookEvent.LOGIN);
         var _loc3_:String = FacebookEventsTextData.instance.getDescription(FacebookEvent.LOGIN);
         _loc2_ = StringUtils.replaceAll(_loc2_,"{0}","" + param1);
         _loc3_ = StringUtils.replaceAll(_loc3_,"{0}","" + param1);
         var _loc4_:FacebookEventProperties;
         var _loc5_:String = (_loc4_ = FacebookEventProperties(eventProperties.get(FacebookEvent.LOGIN))).randomImage;
         var _loc6_:Boolean = _loc4_.hasClips;
         var _loc7_:String = "";
         if(_loc6_)
         {
            _loc7_ = _loc4_.randomClip;
         }
         if(_loc4_.active)
         {
            dispatch(new FacebookEvent(FacebookEvent.LOGIN,500,serverConfig,_loc2_,_loc3_,_loc5_,username,_loc6_,_loc7_,[param1]));
         }
      }
      
      public static function seniorityLevelUp(param1:int) : *
      {
         var _loc2_:String = FacebookEventsTextData.instance.getTitle(FacebookEvent.SENIORITY);
         var _loc3_:String = FacebookEventsTextData.instance.getDescription(FacebookEvent.SENIORITY);
         var _loc4_:* = TextResourceManager.getSeniorityLevelName(param1,true);
         _loc2_ = StringUtils.replaceAll(_loc2_,"{0}","" + param1);
         _loc3_ = StringUtils.replaceAll(_loc3_,"{0}","" + param1);
         _loc2_ = StringUtils.replaceAll(_loc2_,"{1}","" + _loc4_);
         _loc3_ = StringUtils.replaceAll(_loc3_,"{1}","" + _loc4_);
         var _loc5_:FacebookEventProperties;
         var _loc6_:String = (_loc5_ = FacebookEventProperties(eventProperties.get(FacebookEvent.SENIORITY))).randomImage;
         var _loc7_:Boolean = _loc5_.hasClips;
         var _loc8_:String = "";
         if(_loc7_)
         {
            _loc8_ = _loc5_.randomClip;
         }
         if(_loc5_.active)
         {
            dispatch(new FacebookEvent(FacebookEvent.SENIORITY,3000,serverConfig,_loc2_,_loc3_,_loc6_,username,_loc7_,_loc8_,[param1]));
         }
      }
      
      public static function haircut(param1:int, param2:int) : *
      {
         var _loc3_:String = FacebookEventsTextData.instance.getTitle(FacebookEvent.HAIRCUT);
         var _loc4_:String = FacebookEventsTextData.instance.getDescription(FacebookEvent.HAIRCUT);
         var _loc5_:* = TextResourceManager.getItemData(param1,true)["1"];
         _loc3_ = StringUtils.replaceAll(_loc3_,"{0}","" + _loc5_);
         _loc4_ = StringUtils.replaceAll(_loc4_,"{0}","" + _loc5_);
         var _loc6_:* = TextResourceManager.getItemData(param1,true)["2"];
         _loc3_ = StringUtils.replaceAll(_loc3_,"{1}","" + _loc6_);
         _loc4_ = StringUtils.replaceAll(_loc4_,"{1}","" + _loc6_);
         var _loc7_:* = TextResourceManager.getStoreData(param1,true)["1"];
         _loc3_ = StringUtils.replaceAll(_loc3_,"{2}","" + _loc7_);
         _loc4_ = StringUtils.replaceAll(_loc4_,"{2}","" + _loc7_);
         var _loc8_:FacebookEventProperties;
         var _loc9_:String = (_loc8_ = FacebookEventProperties(eventProperties.get(FacebookEvent.HAIRCUT))).randomImage;
         var _loc10_:Boolean = _loc8_.hasClips;
         var _loc11_:String = "";
         if(_loc10_)
         {
            _loc11_ = _loc8_.randomClip;
         }
         if(_loc8_.active)
         {
            dispatch(new FacebookEvent(FacebookEvent.HAIRCUT,100,serverConfig,_loc3_,_loc4_,_loc9_,username,_loc10_,_loc11_,[param1,ITEM_TYPES.HAIR,param2]));
         }
      }
      
      public static function skintone(param1:int, param2:int) : *
      {
         var _loc3_:String = FacebookEventsTextData.instance.getTitle(FacebookEvent.SKINTONE);
         var _loc4_:String = FacebookEventsTextData.instance.getDescription(FacebookEvent.SKINTONE);
         var _loc5_:* = TextResourceManager.getItemData(param1,true)["1"];
         _loc3_ = StringUtils.replaceAll(_loc3_,"{0}","" + _loc5_);
         _loc4_ = StringUtils.replaceAll(_loc4_,"{0}","" + _loc5_);
         var _loc6_:* = TextResourceManager.getItemData(param1,true)["2"];
         _loc3_ = StringUtils.replaceAll(_loc3_,"{1}","" + _loc6_);
         _loc4_ = StringUtils.replaceAll(_loc4_,"{1}","" + _loc6_);
         var _loc7_:* = TextResourceManager.getStoreData(param1,true)["1"];
         _loc3_ = StringUtils.replaceAll(_loc3_,"{2}","" + _loc7_);
         _loc4_ = StringUtils.replaceAll(_loc4_,"{2}","" + _loc7_);
         var _loc8_:FacebookEventProperties;
         var _loc9_:String = (_loc8_ = FacebookEventProperties(eventProperties.get(FacebookEvent.SKINTONE))).randomImage;
         var _loc10_:Boolean = _loc8_.hasClips;
         var _loc11_:String = "";
         if(_loc10_)
         {
            _loc11_ = _loc8_.randomClip;
         }
         if(_loc8_.active)
         {
            dispatch(new FacebookEvent(FacebookEvent.SKINTONE,100,serverConfig,_loc3_,_loc4_,_loc9_,username,_loc10_,_loc11_,[param1,ITEM_TYPES.SKINTONE,param2]));
         }
      }
      
      public static function buyItem(param1:int, param2:int, param3:int, param4:int) : *
      {
         var _loc5_:String = FacebookEventsTextData.instance.getTitle(FacebookEvent.ITEM_BUY);
         var _loc6_:String = FacebookEventsTextData.instance.getDescription(FacebookEvent.ITEM_BUY);
         var _loc7_:* = TextResourceManager.getItemData(param1,true)["1"];
         _loc5_ = StringUtils.replaceAll(_loc5_,"{0}","" + _loc7_);
         _loc6_ = StringUtils.replaceAll(_loc6_,"{0}","" + _loc7_);
         var _loc8_:* = TextResourceManager.getItemData(param1,true)["2"];
         _loc5_ = StringUtils.replaceAll(_loc5_,"{1}","" + _loc8_);
         _loc6_ = StringUtils.replaceAll(_loc6_,"{1}","" + _loc8_);
         var _loc9_:* = TextResourceManager.getStoreData(param2,true)["1"];
         _loc5_ = StringUtils.replaceAll(_loc5_,"{2}","" + _loc9_);
         _loc6_ = StringUtils.replaceAll(_loc6_,"{2}","" + _loc9_);
         var _loc10_:FacebookEventProperties;
         var _loc11_:String = (_loc10_ = FacebookEventProperties(eventProperties.get(FacebookEvent.ITEM_BUY))).randomImage;
         var _loc12_:Boolean = _loc10_.hasClips;
         var _loc13_:String = "";
         if(_loc12_)
         {
            _loc13_ = _loc10_.randomClip;
         }
         if(_loc10_.active)
         {
            dispatch(new FacebookEvent(FacebookEvent.ITEM_BUY,100,serverConfig,_loc5_,_loc6_,_loc11_,username,_loc12_,_loc13_,[param1,param3,param4]));
         }
      }
      
      public static function newPioneer() : *
      {
         var _loc1_:String = FacebookEventsTextData.instance.getTitle(FacebookEvent.NEW_PIONEER);
         var _loc2_:String = FacebookEventsTextData.instance.getDescription(FacebookEvent.NEW_PIONEER);
         var _loc3_:FacebookEventProperties = FacebookEventProperties(eventProperties.get(FacebookEvent.NEW_PIONEER));
         var _loc4_:String = _loc3_.randomImage;
         var _loc5_:Boolean = _loc3_.hasClips;
         var _loc6_:String = "";
         if(_loc5_)
         {
            _loc6_ = _loc3_.randomClip;
         }
         if(_loc3_.active)
         {
            dispatch(new FacebookEvent(FacebookEvent.NEW_PIONEER,3000,serverConfig,_loc1_,_loc2_,_loc4_,username,_loc5_,_loc6_));
         }
      }
      
      public static function adoptAnimal(param1:int) : *
      {
         var _loc2_:String = FacebookEventsTextData.instance.getTitle(FacebookEvent.ANINAL_BUY);
         var _loc3_:String = FacebookEventsTextData.instance.getDescription(FacebookEvent.ANINAL_BUY);
         var _loc4_:* = TextResourceManager.getAnimalData(param1,true)["1"];
         _loc2_ = StringUtils.replaceAll(_loc2_,"{0}","" + _loc4_);
         _loc3_ = StringUtils.replaceAll(_loc3_,"{0}","" + _loc4_);
         _loc4_ = TextResourceManager.getAnimalStoreData(param1,true)["1"];
         _loc2_ = StringUtils.replaceAll(_loc2_,"{1}","" + _loc4_);
         _loc3_ = StringUtils.replaceAll(_loc3_,"{1}","" + _loc4_);
         var _loc5_:FacebookEventProperties;
         var _loc6_:String = (_loc5_ = FacebookEventProperties(eventProperties.get(FacebookEvent.ANINAL_BUY))).randomImage;
         var _loc7_:Boolean = _loc5_.hasClips;
         var _loc8_:String = "";
         if(_loc7_)
         {
            _loc8_ = _loc5_.randomClip;
         }
         if(_loc5_.active)
         {
            dispatch(new FacebookEvent(FacebookEvent.ANINAL_BUY,500,serverConfig,_loc2_,_loc3_,_loc6_,username,_loc7_,_loc8_,[param1]));
         }
      }
      
      public static function gameScore(param1:int, param2:int) : *
      {
         var _loc3_:String = FacebookEventsTextData.instance.getTitle(FacebookEvent.GAME_SCORE);
         var _loc4_:String = FacebookEventsTextData.instance.getDescription(FacebookEvent.GAME_SCORE);
         var _loc5_:* = TextResourceManager.getGameData(param1,true)["1"];
         _loc3_ = StringUtils.replaceAll(_loc3_,"{0}","" + _loc5_);
         _loc4_ = StringUtils.replaceAll(_loc4_,"{0}","" + _loc5_);
         _loc3_ = StringUtils.replaceAll(_loc3_,"{1}","" + param2);
         _loc4_ = StringUtils.replaceAll(_loc4_,"{1}","" + param2);
         var _loc6_:FacebookEventProperties;
         var _loc7_:String = (_loc6_ = FacebookEventProperties(eventProperties.get(FacebookEvent.GAME_SCORE))).randomImage;
         var _loc8_:Boolean = _loc6_.hasClips;
         var _loc9_:String = "";
         if(_loc8_)
         {
            _loc9_ = _loc6_.randomClip;
         }
         if(_loc6_.active)
         {
            dispatch(new FacebookEvent(FacebookEvent.GAME_SCORE,1000,serverConfig,_loc3_,_loc4_,_loc7_,username,_loc8_,_loc9_,[param1,param2]));
         }
      }
      
      public static function inWorldGameScore(param1:int, param2:int) : *
      {
         var _loc3_:String = FacebookEventsTextData.instance.getTitle(FacebookEvent.INWORLD_GAME_SCORE);
         var _loc4_:String = FacebookEventsTextData.instance.getDescription(FacebookEvent.INWORLD_GAME_SCORE);
         var _loc5_:* = TextResourceManager.getGameData(param1,true)["1"];
         _loc3_ = StringUtils.replaceAll(_loc3_,"{0}","" + _loc5_);
         _loc4_ = StringUtils.replaceAll(_loc4_,"{0}","" + _loc5_);
         _loc3_ = StringUtils.replaceAll(_loc3_,"{1}","" + param2);
         _loc4_ = StringUtils.replaceAll(_loc4_,"{1}","" + param2);
         var _loc6_:FacebookEventProperties;
         var _loc7_:String = (_loc6_ = FacebookEventProperties(eventProperties.get(FacebookEvent.INWORLD_GAME_SCORE))).randomImage;
         var _loc8_:Boolean = _loc6_.hasClips;
         var _loc9_:String = "";
         if(_loc8_)
         {
            _loc9_ = _loc6_.randomClip;
         }
         if(_loc6_.active)
         {
            dispatch(new FacebookEvent(FacebookEvent.INWORLD_GAME_SCORE,1000,serverConfig,_loc3_,_loc4_,_loc7_,username,_loc8_,_loc9_,[param1,param2]));
         }
      }
   }
}
