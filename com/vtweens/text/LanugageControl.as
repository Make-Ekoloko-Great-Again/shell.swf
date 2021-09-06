package com.vtweens.text
{
   import com.vtweens.util.LanguageDef;
   import flash.text.TextFormatAlign;
   
   public class LanugageControl
   {
      
      private static var lang:String = LanguageDef.DEFAULT;
       
      
      public function LanugageControl()
      {
         super();
      }
      
      public static function set language(param1:String) : *
      {
         if(LanguageDef.isSupported(param1))
         {
            lang = param1;
         }
         else
         {
            lang = LanguageDef.DEFAULT;
         }
      }
      
      public static function get language() : String
      {
         return lang;
      }
      
      public static function get gameLanguage() : String
      {
         return lang == LanguageDef.USA || lang == LanguageDef.BRITISH ? LanguageDef.ENGLISH : lang;
      }
      
      public static function get quizLanguage() : String
      {
         return gameLanguage;
      }
      
      public static function get textLanguage() : String
      {
         return gameLanguage;
      }
      
      public static function get cardAlbumsLanguage() : String
      {
         return gameLanguage;
      }
      
      public static function get helpPopupLanguage() : String
      {
         return gameLanguage;
      }
      
      public static function get creditsStoreTagsLanguage() : String
      {
         return gameLanguage;
      }
      
      public static function get securityQuesiotnsLanguage() : String
      {
         return gameLanguage;
      }
      
      public static function get isLeftAligned() : Boolean
      {
         return LanguageDef.alignment(lang) == TextFormatAlign.LEFT;
      }
      
      public static function get isRightAligned() : Boolean
      {
         return !isLeftAligned;
      }
      
      public static function get textAlign() : String
      {
         return LanguageDef.alignment(lang);
      }
   }
}
