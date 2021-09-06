package com.vtweens.util
{
   public class MainGetter
   {
      
      private static var main;
      
      private static var helper;
       
      
      public function MainGetter()
      {
         super();
      }
      
      public static function set MainCaller(param1:*) : *
      {
         main = param1;
      }
      
      public static function get MainCaller() : *
      {
         return main;
      }
      
      public static function get SFS() : *
      {
         return main.SFS;
      }
      
      public static function set Helper(param1:*) : *
      {
         helper = param1;
      }
      
      public static function get Helper() : *
      {
         return helper;
      }
      
      public static function HelperCloseHitTest(param1:int, param2:int) : Boolean
      {
         if(helper)
         {
            return helper.hitTestHideButton(param1,param2);
         }
         return false;
      }
   }
}
