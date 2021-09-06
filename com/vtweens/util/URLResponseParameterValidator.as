package com.vtweens.util
{
   public class URLResponseParameterValidator
   {
       
      
      public function URLResponseParameterValidator()
      {
         super();
      }
      
      public static function isValid(param1:*) : Boolean
      {
         return param1 && param1 != null && param1 != undefined && param1 != "undefined" && param1 != "null";
      }
   }
}
