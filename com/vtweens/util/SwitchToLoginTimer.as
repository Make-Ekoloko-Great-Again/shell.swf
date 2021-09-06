package com.vtweens.util
{
   import com.vtweens.shell.ServerConfig;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class SwitchToLoginTimer
   {
      
      private static var timer:Timer;
      
      private static var url:String;
      
      public static const LOADME = 0;
       
      
      public function SwitchToLoginTimer()
      {
         super();
      }
      
      public static function GotoLogin(param1:int, param2:ServerConfig, param3:* = null, param4:* = null) : *
      {
         if(timer)
         {
            timer.reset();
            timer.delay = 1000 * (param1 == 0 ? 0.5 : param1);
         }
         else
         {
            timer = new Timer(1000 * (param1 == 0 ? 0.5 : param1));
         }
         url = param2.getReloginUrl() + (!!param3 ? "?language=" + param3 : "") + (!!param4 ? (!!param3 ? "&" : "?") + "username=" + param4 : "");
         timer.addEventListener(TimerEvent.TIMER,gotoLogin,false,0,true);
         timer.start();
      }
      
      private static function gotoLogin(param1:TimerEvent) : void
      {
         HtmlNavigation.replaceURL(url);
      }
   }
}
