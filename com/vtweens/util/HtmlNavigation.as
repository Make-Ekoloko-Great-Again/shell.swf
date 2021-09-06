package com.vtweens.util
{
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class HtmlNavigation
   {
      
      public static const LOADME = 0;
       
      
      public function HtmlNavigation()
      {
         super();
      }
      
      public static function OpenPopup(param1:String, param2:int, param3:int) : *
      {
         Log.info("OpenPopupWindow OpenPopup(" + param1 + ", " + param2 + ", " + param3 + ")");
         var _loc4_:* = "window.open(\'" + param1 + "\',\'win" + int(Math.random() * 10000) + "\',\'top=20,left=20,height=" + param3 + ",width=" + param2 + ",toolbar=no,location=no,resizable=yes,scrollbars=yes,directories=no,status=no,menubar=no,copyhistory=no\');";
         Log.info("OpenPopupWindow OpenPopup jscommand: javascript:" + _loc4_ + " void(0);");
         var _loc5_:URLRequest = new URLRequest("javascript:" + _loc4_ + " void(0);");
         navigateToURL(_loc5_,"_top");
      }
      
      public static function execJavascript(param1:String) : *
      {
         navigateToURL(new URLRequest("javascript:" + param1 + "; void(0);"),"_self");
      }
      
      public static function openNewWindow(param1:String) : *
      {
         navigateToURL(new URLRequest(param1),"_blank");
      }
      
      public static function closeWindow() : *
      {
         execJavascript("window.opener=top; window.close()");
      }
      
      public static function openFBFrame(param1:String) : *
      {
         execJavascript("shareFacebook(\'" + param1 + "\')");
      }
      
      public static function openUrl(param1:String) : *
      {
         navigateToURL(new URLRequest(param1),"_top");
      }
      
      public static function replaceURL(param1:String) : *
      {
         navigateToURL(new URLRequest(param1),"_self");
      }
      
      public static function windowGoBack() : *
      {
         execJavascript("history.back()");
      }
      
      public static function addUrlParam(param1:*, param2:*, param3:*) : *
      {
         if(!(param2 == undefined || param2 == "undefined" || param2 == null || param2 == "null"))
         {
            param3 += (param3.indexOf("?") < 0 ? "?" : "&") + param1 + "=" + param2;
         }
         return param3;
      }
   }
}
