package com.vtweens.components.website.activation.login
{
   import flash.events.Event;
   
   public class LoginEvent extends Event
   {
      
      public static var BAD_USER_PASSWORD:String = "bad_user_pass";
      
      public static var USER_BANNED1:String = "user_banned1";
      
      public static var USER_BANNED7:String = "user_banned7";
      
      public static var USER_BANNED_FOREVER:String = "user_banned_forever";
      
      public static var NOT_ACTIVATED:String = "not_activated";
      
      public static var LOGIN_OK:String = "login_ok";
      
      public static var LOGIN_OK_MOD:String = "login_ok_mod";
      
      public static var LOGIN_OK_NEWBIE:String = "login_ok_newbie";
      
      public static var LOGIN_OK_RANGER:String = "login_ok_ranger";
      
      public static var UNKNOWN_ERROR:String = "uknown_error";
       
      
      public function LoginEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new LoginEvent(type,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("LoginEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
