package com.vtweens.util
{
   import flash.text.TextFormatAlign;
   
   public class LanguageDef
   {
      
      public static const HEBREW = "iw";
      
      public static const ENGLISH = "en";
      
      public static const USA = "us";
      
      public static const BRITISH = "uk";
      
      public static const FRENCH = "fr";
      
      public static const DEFAULT = ENGLISH;
       
      
      public function LanguageDef()
      {
         super();
      }
      
      public static function isSupported(param1:String) : Boolean
      {
         switch(param1)
         {
            case HEBREW:
            case ENGLISH:
            case USA:
            case FRENCH:
               return true;
            default:
               return false;
         }
      }
      
      public static function alignment(param1:String) : String
      {
         if(param1 == HEBREW)
         {
            return TextFormatAlign.RIGHT;
         }
         return TextFormatAlign.LEFT;
      }
   }
}
