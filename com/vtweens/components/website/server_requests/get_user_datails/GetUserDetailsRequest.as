package com.vtweens.components.website.server_requests.get_user_datails
{
   import com.adobe.serialization.json.JSONDecoder;
   import com.vtweens.consts.ACCOUNT;
   import com.vtweens.shell.ServerConfig;
   import com.vtweens.util.Log;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   
   public class GetUserDetailsRequest extends EventDispatcher
   {
       
      
      private var url:String;
      
      private var dataObj:Object;
      
      private var _username:String;
      
      private var _password:String;
      
      public function GetUserDetailsRequest(param1:ServerConfig, param2:Boolean)
      {
         this.dataObj = {};
         super();
         this.url = param1.getAccountDetailsUrl(param2);
      }
      
      public function sendRequest(param1:String, param2:String) : void
      {
         this._username = param1;
         this._password = param2;
         var _loc3_:URLVariables = new URLVariables();
         _loc3_.userName = param1;
         _loc3_.password = param2;
         _loc3_.random = Math.random();
         if(_loc3_.userName == null || _loc3_.password == null || _loc3_.password.length < 6 || _loc3_.userName.length < 6)
         {
            dispatchEvent(new GetUserDetailsEvent(GetUserDetailsEvent.BAD_USER_PASSWORD));
            return;
         }
         this.sendInqueryRequest(_loc3_,this.url,this.onRequestResponse,this.onRequestError);
      }
      
      public function get email() : String
      {
         return this.dataObj[ACCOUNT.EMAIL];
      }
      
      public function get parentEmail() : String
      {
         return this.dataObj[ACCOUNT.PARENT_EMAIL];
      }
      
      public function get confirmedEmail() : String
      {
         return this.dataObj[ACCOUNT.CONFIRMED_EMAIL];
      }
      
      public function get isPaying() : Boolean
      {
         return this.dataObj[ACCOUNT.ISPAYING] == "true";
      }
      
      public function get isPremium() : Boolean
      {
         return this.dataObj[ACCOUNT.IS_PIONEER] == "true";
      }
      
      public function get payerEmail() : String
      {
         return this.dataObj[ACCOUNT.PAYER_EMAIL];
      }
      
      public function get rangerLevel() : int
      {
         return this.dataObj[ACCOUNT.RANGER_LEVEL];
      }
      
      public function get activated() : Boolean
      {
         return this.dataObj[ACCOUNT.ACTIVATIVATED] == "true";
      }
      
      public function get username() : String
      {
         return this._username;
      }
      
      public function get password() : String
      {
         return this._password;
      }
      
      private function onRequestError(param1:IOErrorEvent) : void
      {
         param1.target.removeEventListener(Event.COMPLETE,this.onRequestResponse);
         param1.target.removeEventListener(IOErrorEvent.IO_ERROR,this.onRequestError);
         Log.error("GetUserDetailsRequest: onRequestError error:" + param1.text);
         dispatchEvent(new GetUserDetailsEvent(GetUserDetailsEvent.UNKNOWN_ERROR));
      }
      
      private function onRequestResponse(param1:Event) : void
      {
         param1.target.removeEventListener(Event.COMPLETE,this.onRequestResponse);
         param1.target.removeEventListener(IOErrorEvent.IO_ERROR,this.onRequestError);
         var _loc2_:* = param1.target.data;
         var _loc3_:Array = new JSONDecoder(_loc2_).getValue();
         if(_loc3_.length > 0)
         {
            switch(_loc3_[0])
            {
               case "bad_user_password":
                  dispatchEvent(new GetUserDetailsEvent(GetUserDetailsEvent.BAD_USER_PASSWORD));
                  return;
               default:
                  this.dataObj = new JSONDecoder(_loc3_[0]).getValue();
                  dispatchEvent(new GetUserDetailsEvent(GetUserDetailsEvent.COMPELTED_OK));
                  return;
            }
         }
         else
         {
            dispatchEvent(new GetUserDetailsEvent(GetUserDetailsEvent.UNKNOWN_ERROR));
            return;
         }
      }
      
      private function sendInqueryRequest(param1:URLVariables, param2:*, param3:*, param4:*) : *
      {
         var _loc5_:URLRequest;
         (_loc5_ = new URLRequest(param2)).contentType = "text/html; charset=utf-8";
         _loc5_.method = URLRequestMethod.GET;
         _loc5_.data = param1;
         var _loc6_:URLLoader;
         (_loc6_ = new URLLoader()).addEventListener(Event.COMPLETE,param3);
         _loc6_.addEventListener(IOErrorEvent.IO_ERROR,param4);
         _loc6_.load(_loc5_);
      }
   }
}
