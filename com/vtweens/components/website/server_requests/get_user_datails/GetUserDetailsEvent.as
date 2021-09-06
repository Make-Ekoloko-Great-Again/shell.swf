package com.vtweens.components.website.server_requests.get_user_datails
{
   import flash.events.Event;
   
   public class GetUserDetailsEvent extends Event
   {
      
      public static var BAD_USER_PASSWORD:String = "bad_user_pass";
      
      public static var COMPELTED_OK:String = "completed_ok";
      
      public static var UNKNOWN_ERROR:String = "unknown_error";
       
      
      public function GetUserDetailsEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new GetUserDetailsEvent(type,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("GetUserDetailsEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
