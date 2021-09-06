package com.vtweens.text
{
   import com.vtweens.util.LanguageDef;
   import com.vtweens.util.Log;
   import flash.text.TextField;
   
   public class StringUtils
   {
      
      private static var chars = [":",",",".","!","?","\""];
      
      private static const latinLetters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
      
      private static const numbers:String = "1234567890";
      
      private static var alefbiet:Array = ["א","ב","ג","ד","ה","ו","ז","ח","ט","י","ך","כ","ל","ם","מ","ן","נ","ס","ע","ף","פ","ץ","צ","ק","ר","ש","ת"];
      
      private static var alefbietEscaped:Array = ["90","91","92","93","94","95","96","97","98","99","9a","9b","9c","9d","9e","9f","a0","a1","a2","a3","a4","a5","a6","a7","a8","a9","aa"];
       
      
      public function StringUtils()
      {
         super();
      }
      
      public static function SetPisukHebrew(param1:TextField) : *
      {
         if(LanugageControl.language != LanguageDef.HEBREW)
         {
            return;
         }
         var _loc2_:* = "";
         var _loc3_:* = 0;
         while(_loc3_ < param1.numLines)
         {
            _loc2_ += SetPisukHebrewLine(param1.getLineText(_loc3_));
            if(_loc3_ < param1.numLines - 1)
            {
               _loc2_ += "\n";
            }
            _loc3_++;
         }
         param1.text = _loc2_;
      }
      
      public static function SetPisukHebrewLine(param1:String) : String
      {
         if(LanugageControl.language != LanguageDef.HEBREW)
         {
            return param1;
         }
         if(param1 == null || param1 == "")
         {
            return param1;
         }
         var _loc2_:* = Trim(param1);
         var _loc3_:* = endsWithSpecialChar(_loc2_);
         var _loc4_:* = param1.length;
         while(_loc3_ && _loc4_ >= 0)
         {
            _loc4_--;
            _loc2_ = _loc3_ + _loc2_.substr(0,_loc2_.length - 1);
            _loc3_ = endsWithSpecialChar(_loc2_);
         }
         if(_loc3_ < 0)
         {
            Log.error("Could not parse [" + param1 + "] correctly");
         }
         return _loc2_;
      }
      
      private static function endsWithSpecialChar(param1:String) : String
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in chars)
         {
            if(param1.charAt(param1.length - 1) == _loc2_)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function Trim(param1:String) : String
      {
         var _loc3_:String = null;
         var _loc2_:* = param1;
         if(param1 && param1.length > 0)
         {
            _loc3_ = _loc2_.charAt(_loc2_.length - 1);
            while(_loc3_ == " " || _loc3_ == "\t" || _loc3_ == "\n" || _loc3_.charCodeAt(0) == 13)
            {
               _loc2_ = _loc2_.substr(0,_loc2_.length - 1);
               _loc3_ = _loc2_.charAt(_loc2_.length - 1);
            }
         }
         return _loc2_;
      }
      
      public static function reverseLine(param1:String) : String
      {
         var _loc2_:* = "";
         var _loc3_:* = param1.length;
         var _loc4_:Array = new Array(_loc3_);
         var _loc5_:* = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_[_loc3_ - _loc5_ - 1] = param1.charAt(_loc5_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc2_ += _loc4_[_loc5_];
            _loc5_++;
         }
         return _loc2_;
      }
      
      public static function stringContainsAChar(param1:String, param2:String) : Boolean
      {
         var _loc3_:* = 0;
         while(_loc3_ < param2.length)
         {
            if(param1.indexOf(param2.charAt(_loc3_)) > -1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public static function isInt(param1:String) : Boolean
      {
         var _loc2_:* = 0;
         while(_loc2_ < param1.length)
         {
            if(numbers.indexOf(param1.charAt(_loc2_)) < 0)
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      public static function digitInstanceCount(param1:String) : int
      {
         return charInstanceCount(param1,numbers);
      }
      
      public static function charInstanceCount(param1:String, param2:String) : int
      {
         var _loc5_:String = null;
         var _loc6_:* = undefined;
         var _loc3_:int = 0;
         var _loc4_:* = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = param1.charAt(_loc4_);
            _loc6_ = 0;
            while(_loc6_ < param2.length)
            {
               if(_loc5_ == param2.charAt(_loc6_))
               {
                  _loc3_++;
               }
               _loc6_++;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public static function stringContainsALatinChar(param1:String) : Boolean
      {
         return stringContainsAChar(param1,latinLetters);
      }
      
      public static function stringContainsANumericChar(param1:String) : Boolean
      {
         return stringContainsAChar(param1,numbers);
      }
      
      public static function isNumber(param1:String) : Boolean
      {
         return stringContainsAChar(param1,numbers);
      }
      
      public static function replaceAll(param1:String, param2:String, param3:String) : String
      {
         if(!param1 || !param2 || param2 == "" || !param3 || param2 == param3)
         {
            return param1;
         }
         var _loc4_:String;
         var _loc5_:String = (_loc4_ = param1).replace(param2,param3);
         while(_loc5_ != _loc4_)
         {
            _loc4_ = _loc5_;
            _loc5_ = _loc5_.replace(param2,param3);
         }
         return _loc4_;
      }
      
      public static function hebrewURLEscaping(param1:String) : String
      {
         var _loc2_:* = 0;
         while(_loc2_ < alefbiet.length)
         {
            param1 = replaceAll(param1,alefbiet[_loc2_],"%d7%" + alefbietEscaped[_loc2_]);
            _loc2_++;
         }
         return param1;
      }
      
      public static function startsWith(param1:String, param2:String) : Boolean
      {
         return !param1.indexOf(param2);
      }
      
      public static function endsWith(param1:String, param2:String) : Boolean
      {
         var _loc3_:* = param1.lastIndexOf(param2);
         if(_loc3_ == -1)
         {
            return false;
         }
         return _loc3_ == param1.length - param2.length;
      }
   }
}
