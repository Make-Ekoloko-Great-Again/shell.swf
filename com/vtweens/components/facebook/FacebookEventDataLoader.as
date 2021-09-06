package com.vtweens.components.facebook
{
   import com.vtweens.consts.VERSION;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class FacebookEventDataLoader
   {
       
      
      public function FacebookEventDataLoader()
      {
         super();
      }
      
      public static function load() : *
      {
         var _loc1_:URLLoader = new URLLoader();
         _loc1_.load(new URLRequest("./facebook/facebook_events.xml?version=" + VERSION.version));
         _loc1_.addEventListener(Event.COMPLETE,xmlLoaded);
         _loc1_.addEventListener(IOErrorEvent.IO_ERROR,xmlLoadingError);
      }
      
      private static function xmlLoaded(param1:Event) : void
      {
         param1.target.removeEventListener(Event.COMPLETE,xmlLoaded);
         param1.target.removeEventListener(Event.COMPLETE,xmlLoadingError);
         setEvents(XML(param1.target.data));
      }
      
      private static function xmlLoadingError(param1:IOErrorEvent) : void
      {
         param1.target.removeEventListener(Event.COMPLETE,xmlLoaded);
         param1.target.removeEventListener(Event.COMPLETE,xmlLoadingError);
      }
      
      private static function setEvents(param1:XML) : void
      {
         var _loc2_:* = param1.children().length();
         var _loc3_:* = 0;
         while(_loc3_ < _loc2_)
         {
            FacebookEventDispatcher.addEventProperties(new FacebookEventProperties(param1.child(_loc3_)));
            _loc3_++;
         }
      }
   }
}
