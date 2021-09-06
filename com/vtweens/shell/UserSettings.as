package com.vtweens.shell
{
   import com.vtweens.components.website.server_requests.get_user_datails.GetUserDetailsEvent;
   import com.vtweens.components.website.server_requests.get_user_datails.GetUserDetailsRequest;
   import com.vtweens.util.Log;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   
   public class UserSettings extends EventDispatcher
   {
       
      
      private var _email:String = "";
      
      private var _parentEmail:String = "";
      
      private var _confirmationEmail:String = "";
      
      private var _username:String = "";
      
      private var _survey:Boolean = false;
      
      private var _newsletter:Boolean = false;
      
      private var _isPaying:Boolean = false;
      
      private var _isPremium:Boolean = false;
      
      private var _password:String = "";
      
      private var isLoaded = false;
      
      private var detailsRequest:GetUserDetailsRequest;
      
      public function UserSettings(param1:ServerConfig, param2:String, param3:String)
      {
         super();
         this._username = param2;
         this._password = param3;
         this.detailsRequest = new GetUserDetailsRequest(param1,false);
         this.detailsRequest.addEventListener(GetUserDetailsEvent.COMPELTED_OK,this.onDataLoaded);
         this.detailsRequest.sendRequest(param2,param3);
      }
      
      private function onDataLoadError(param1:IOErrorEvent) : void
      {
         Log.error("UserSettings: could not load data. " + param1.text);
      }
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         super.addEventListener(param1,param2,param3,param4,param5);
         if(param1 == Event.COMPLETE && this.isLoaded)
         {
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      private function onDataLoaded(param1:Event) : void
      {
         this._username = this.detailsRequest.username;
         this._password = this.detailsRequest.password;
         this._parentEmail = this.detailsRequest.parentEmail;
         this._confirmationEmail = this.detailsRequest.confirmedEmail;
         this._email = this.detailsRequest.email;
         this._isPaying = this.detailsRequest.isPaying;
         this._isPremium = this.detailsRequest.isPremium;
         this.isLoaded = true;
         this.detailsRequest.removeEventListener(GetUserDetailsEvent.COMPELTED_OK,this.onDataLoaded);
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      public function get email() : String
      {
         return this._email;
      }
      
      public function set email(param1:String) : void
      {
         this._email = param1;
      }
      
      public function get parentEmail() : String
      {
         return this._parentEmail;
      }
      
      public function set parentEmail(param1:String) : void
      {
         this._parentEmail = param1;
      }
      
      public function get confirmationEmail() : String
      {
         return this._confirmationEmail;
      }
      
      public function set confirmationEmail(param1:String) : void
      {
         this._confirmationEmail = param1;
      }
      
      public function get username() : String
      {
         return this._username;
      }
      
      public function set username(param1:String) : void
      {
         this._username = param1;
      }
      
      public function get survey() : Boolean
      {
         return this._survey;
      }
      
      public function set survey(param1:Boolean) : void
      {
         this._survey = param1;
      }
      
      public function get newsletter() : Boolean
      {
         return this._newsletter;
      }
      
      public function set newsletter(param1:Boolean) : void
      {
         this._newsletter = param1;
      }
      
      public function get isPaying() : Boolean
      {
         return this._isPaying;
      }
      
      public function set isPaying(param1:Boolean) : void
      {
         this._isPaying = param1;
      }
      
      public function get isPremium() : Boolean
      {
         return this._isPremium;
      }
      
      public function set isPremium(param1:Boolean) : void
      {
         this._isPremium = param1;
      }
      
      public function get password() : String
      {
         return this._password;
      }
      
      public function set password(param1:String) : void
      {
         this._password = param1;
      }
   }
}
