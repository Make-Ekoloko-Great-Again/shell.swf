package com.vtweens.components.facebook
{
   import com.vtweens.shell.ServerConfig;
   import com.vtweens.text.LanugageControl;
   import com.vtweens.text.StringUtils;
   import flash.events.Event;
   
   public class FacebookEvent extends Event
   {
      
      private static const FB_URL:String = "http://www.facebook.com/sharer.php?u=";
      
      private static const JSP:String = "facebook_2.jsp?data=";
      
      private static const FB_DELIM:String = "~";
      
      private static const DATA_DELIM:String = ";";
      
      private static const DATA_TYPE_CLIP:String = "clip";
      
      private static const DATA_TYPE_IMAGE:String = "image";
      
      public static const LOGIN:int = 1;
      
      public static const SENIORITY:int = 2;
      
      public static const HAIRCUT:int = 3;
      
      public static const SKINTONE:int = 4;
      
      public static const ITEM_BUY:int = 5;
      
      public static const ANINAL_BUY:int = 6;
      
      public static const GAME_SCORE:int = 7;
      
      public static const INWORLD_GAME_SCORE:int = 8;
      
      public static const NEW_PIONEER:int = 9;
       
      
      private var _timeToPop:int = 2500;
      
      private var _eventType:int = 2500;
      
      private var _url:String;
      
      public function FacebookEvent(param1:int, param2:int, param3:ServerConfig, param4:String, param5:String, param6:String, param7:String, param8:Boolean = false, param9:String = null, param10:Array = null)
      {
         var _loc12_:* = undefined;
         super(Event.OPEN,false,false);
         this._eventType = param1;
         this._timeToPop = param2;
         this._url = FB_URL + param3.buildUrl(ServerConfig.HTTP_PROTOCOL,ServerConfig.APP_FACEBOOK,JSP);
         var _loc11_:* = (_loc11_ = (_loc11_ = (_loc11_ = "") + (param4 + FB_DELIM + param5 + FB_DELIM + param3.getStaticIp() + FB_DELIM)) + ((!!param8 ? DATA_TYPE_CLIP : DATA_TYPE_IMAGE) + FB_DELIM)) + (param3.getApp(ServerConfig.APP_EKOLOKO) + "/" + param6);
         if(param8)
         {
            _loc11_ = (_loc11_ = (_loc11_ = (_loc11_ += FB_DELIM + param3.getApp(ServerConfig.APP_EKOLOKO) + "/" + param9 + ".swf?data=") + (param7 + DATA_DELIM)) + (param3.getStaticIp() + "/" + param3.getApp(ServerConfig.APP_EKOLOKO) + "/" + DATA_DELIM)) + LanugageControl.language;
            if(param10)
            {
               for each(_loc12_ in param10)
               {
                  _loc11_ += DATA_DELIM + _loc12_;
               }
            }
         }
         this._url += StringUtils.hebrewURLEscaping(this.scrumble(_loc11_));
      }
      
      override public function clone() : Event
      {
         return new Event(Event.OPEN);
      }
      
      override public function toString() : String
      {
         return formatToString("FacebookEvent","type","bubbles","cancelable","eventPhase");
      }
      
      public function get url() : String
      {
         return this._url;
      }
      
      public function get timeToPop() : int
      {
         return this._timeToPop;
      }
      
      public function set timeToPop(param1:int) : void
      {
         this._timeToPop = param1;
      }
      
      public function get eventType() : int
      {
         return this._eventType;
      }
      
      private function scrumble(param1:String) : *
      {
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc2_:* = param1.length;
         var _loc3_:* = Math.PI;
         var _loc4_:* = [];
         var _loc5_:* = [];
         while(_loc4_.length < _loc2_)
         {
            _loc4_[_loc4_.length] = param1.charAt(_loc4_.length);
            _loc8_ = Math.floor(_loc3_);
            _loc3_ = (_loc3_ - _loc8_) * 10;
            if(_loc3_ == 0)
            {
               _loc3_ = Math.PI;
            }
            _loc5_[_loc5_.length] = _loc8_;
         }
         var _loc6_:* = 0;
         while(_loc6_ < _loc2_)
         {
            _loc9_ = _loc4_[_loc6_];
            _loc4_[_loc6_] = _loc4_[_loc5_[_loc6_]];
            _loc4_[_loc5_[_loc6_]] = _loc9_;
            _loc6_++;
         }
         var _loc7_:* = "";
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc7_ += _loc4_[_loc6_];
            _loc6_++;
         }
         return _loc7_;
      }
   }
}
