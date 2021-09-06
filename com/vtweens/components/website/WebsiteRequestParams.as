package com.vtweens.components.website
{
   import com.vtweens.util.URLResponseParameterValidator;
   import flash.display.LoaderInfo;
   
   public class WebsiteRequestParams
   {
       
      
      private var _language:String = null;
      
      private var _friend:String = null;
      
      private var _refCode:String = null;
      
      private var _username:String = null;
      
      private var _directLogin:String = null;
      
      private var _reg:String = null;
      
      private var _advisor:String = null;
      
      public function WebsiteRequestParams(param1:LoaderInfo)
      {
         super();
         if(URLResponseParameterValidator.isValid(param1.parameters.language))
         {
            this.language = param1.parameters.language;
         }
         if(URLResponseParameterValidator.isValid(param1.parameters.username))
         {
            this.username = param1.parameters.username;
         }
         if(URLResponseParameterValidator.isValid(param1.parameters.friend))
         {
            this.friend = param1.parameters.friend;
         }
         if(URLResponseParameterValidator.isValid(param1.parameters.refCode))
         {
            this.refCode = param1.parameters.refCode;
         }
         if(URLResponseParameterValidator.isValid(param1.parameters.directLogin))
         {
            this.directLogin = param1.parameters.directLogin;
         }
         if(URLResponseParameterValidator.isValid(param1.parameters.register))
         {
            this.reg = param1.parameters.register;
         }
         if(URLResponseParameterValidator.isValid(param1.parameters.advisor))
         {
            this.advisor = param1.parameters.advisor;
         }
      }
      
      public function get language() : String
      {
         return this._language;
      }
      
      public function set language(param1:String) : void
      {
         this._language = param1;
      }
      
      public function get friend() : String
      {
         return this._friend;
      }
      
      public function set friend(param1:String) : void
      {
         this._friend = param1;
      }
      
      public function get refCode() : String
      {
         return this._refCode;
      }
      
      public function set refCode(param1:String) : void
      {
         this._refCode = param1;
      }
      
      public function get username() : String
      {
         return this._username;
      }
      
      public function set username(param1:String) : void
      {
         this._username = param1;
      }
      
      public function get isDirectLogin() : Boolean
      {
         return this._directLogin && this._directLogin == "1";
      }
      
      public function set directLogin(param1:String) : void
      {
         this._directLogin = param1;
      }
      
      public function get isReg() : Boolean
      {
         return this._reg && this._reg == "1";
      }
      
      public function set reg(param1:String) : void
      {
         this._reg = param1;
      }
      
      public function get advisor() : String
      {
         return this._advisor;
      }
      
      public function set advisor(param1:String) : void
      {
         this._advisor = param1;
      }
   }
}
