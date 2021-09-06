package com.vtweens.text
{
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class TextFormats
   {
      
      private static var LEFT_IDENT_FONT_TYPE:String = "Arial";
      
      private static var RIGHT_IDENT_FONT_TYPE:String = "Arial";
      
      private static var CENTER_IDENT_FONT_TYPE:String = "Arial";
      
      private static const TAHOMA = "Tahoma";
      
      public static const BOLD:Boolean = true;
      
      public static const REGULAR:Boolean = false;
      
      public static var Regular10:TextFormat;
      
      public static var Bold10:TextFormat;
      
      public static var Regular11:TextFormat;
      
      public static var Bold11:TextFormat;
      
      public static var Bold11Rright:TextFormat;
      
      public static var Bold11Left:TextFormat;
      
      public static var Regular12:TextFormat;
      
      public static var Bold12:TextFormat;
      
      public static var Bold12Rright:TextFormat;
      
      public static var Bold12Left:TextFormat;
      
      public static var Regular13:TextFormat;
      
      public static var Bold13:TextFormat;
      
      public static var Bold13Right:TextFormat;
      
      public static var Regular14:TextFormat;
      
      public static var Bold14Rright:TextFormat;
      
      public static var Bold15Right:TextFormat;
      
      public static var Bold14Left:TextFormat;
      
      public static var Bold14:TextFormat;
      
      public static var Regular16:TextFormat;
      
      public static var Bold16:TextFormat;
      
      public static var Bold16Rright:TextFormat;
      
      public static var Bold16Left:TextFormat;
      
      public static var Regular18:TextFormat;
      
      public static var Bold18:TextFormat;
      
      public static var Regular20:TextFormat;
      
      public static var Bold20:TextFormat;
      
      public static var Bold28Right:TextFormat;
      
      public static var Bold30Left:TextFormat;
      
      public static var CenterRegular10:TextFormat;
      
      public static var CenterBold10:TextFormat;
      
      public static var CenterRegular11:TextFormat;
      
      public static var CenterBold11:TextFormat;
      
      public static var CenterRegular12:TextFormat;
      
      public static var CenterBold12:TextFormat;
      
      public static var CenterBold12Underline:TextFormat;
      
      public static var CenterRegular13:TextFormat;
      
      public static var CenterBold13:TextFormat;
      
      public static var CenterRegular14:TextFormat;
      
      public static var CenterBold14:TextFormat;
      
      public static var CenterBold15:TextFormat;
      
      public static var CenterRegular16:TextFormat;
      
      public static var CenterBold16:TextFormat;
      
      public static var CenterBold16Underlined:TextFormat;
      
      public static var CenterBold17:TextFormat;
      
      public static var CenterRegular18:TextFormat;
      
      public static var CenterBold18:TextFormat;
      
      public static var CenterBold18Underlined:TextFormat;
      
      public static var CenterRegular20:TextFormat;
      
      public static var CenterBold20:TextFormat;
      
      public static var CenterRegular22:TextFormat;
      
      public static var CenterBold22:TextFormat;
      
      public static var CenterRegular24:TextFormat;
      
      public static var CenterBold24:TextFormat;
      
      public static var CenterRegular26:TextFormat;
      
      public static var CenterBold25:TextFormat;
      
      public static var CenterBold26:TextFormat;
      
      public static var CenterBold28:TextFormat;
      
      public static var CenterBold30:TextFormat;
      
      public static var CenterBold32:TextFormat;
      
      public static var CenterBold33:TextFormat;
      
      public static var CenterBold36:TextFormat;
      
      public static var CenterBold38:TextFormat;
      
      public static var CenterBold40:TextFormat;
      
      public static var CenterBold44:TextFormat;
      
      public static var CenterBold48:TextFormat;
      
      public static var CenterBold60:TextFormat;
      
      public static var CenterRegular42:TextFormat;
      
      public static const CenterBoldTahoma22:TextFormat = new TextFormat("Tahoma",22,null,true);
      
      public static const CenterBoldTahoma24:TextFormat = new TextFormat("Tahoma",24,null,true);
      
      public static const CenterBoldTahoma28:TextFormat = new TextFormat("Tahoma",28,null,true);
      
      public static const CenterBoldTahoma26:TextFormat = new TextFormat("Tahoma",26,null,true);
      
      public static const CenterBoldTahoma32:TextFormat = new TextFormat("Tahoma",32,null,true);
       
      
      public function TextFormats()
      {
         super();
      }
      
      public static function format(param1:int, param2:Boolean, param3:String = null, param4:* = false) : TextFormat
      {
         var _loc5_:TextFormat;
         (_loc5_ = new TextFormat()).align = param3 == null ? LanugageControl.textAlign : param3;
         _loc5_.font = fontType(_loc5_.align);
         _loc5_.size = param1;
         _loc5_.bold = param2;
         _loc5_.underline = param4;
         return _loc5_;
      }
      
      public static function noAlignFormat(param1:int, param2:Boolean) : TextFormat
      {
         var _loc3_:TextFormat = new TextFormat();
         _loc3_.font = fontType(TextFormatAlign.CENTER);
         _loc3_.size = param1;
         _loc3_.bold = param2;
         return _loc3_;
      }
      
      public static function setTextFormat(param1:TextField, param2:int, param3:Boolean, param4:String = null) : *
      {
         param1.defaultTextFormat = format(param2,param3,param4);
         param1.embedFonts = true;
      }
      
      public static function init(param1:* = null) : *
      {
         if(param1 == null)
         {
            param1 = LanugageControl.isRightAligned;
         }
         if(param1)
         {
            LEFT_IDENT_FONT_TYPE = "Arial";
            RIGHT_IDENT_FONT_TYPE = LEFT_IDENT_FONT_TYPE;
            CENTER_IDENT_FONT_TYPE = LEFT_IDENT_FONT_TYPE;
         }
         else
         {
            LEFT_IDENT_FONT_TYPE = "Arial";
            RIGHT_IDENT_FONT_TYPE = RIGHT_IDENT_FONT_TYPE;
            CENTER_IDENT_FONT_TYPE = RIGHT_IDENT_FONT_TYPE;
         }
         initDefaultFormats();
         initNonAlignedFormats();
      }
      
      public static function fontType(param1:String) : String
      {
         switch(param1)
         {
            case TextFormatAlign.CENTER:
               return CENTER_IDENT_FONT_TYPE;
            case TextFormatAlign.LEFT:
               return LEFT_IDENT_FONT_TYPE;
            case TextFormatAlign.RIGHT:
               return RIGHT_IDENT_FONT_TYPE;
            case TextFormatAlign.JUSTIFY:
               return CENTER_IDENT_FONT_TYPE;
            default:
               return CENTER_IDENT_FONT_TYPE;
         }
      }
      
      private static function initDefaultFormats() : *
      {
         Regular10 = format(10,REGULAR);
         Bold10 = format(10,BOLD);
         Regular11 = format(11,REGULAR);
         Bold11 = format(11,BOLD);
         Regular12 = format(12,REGULAR);
         Bold12 = format(12,BOLD);
         Bold14 = format(14,BOLD);
         Regular16 = format(16,REGULAR);
         Bold16 = format(16,BOLD);
         Regular18 = format(18,REGULAR);
         Bold18 = format(18,BOLD);
         Regular20 = format(20,REGULAR);
         Bold20 = format(20,BOLD);
         Regular13 = format(13,REGULAR);
         Bold13 = format(13,BOLD);
         Regular14 = format(14,REGULAR);
      }
      
      private static function initNonAlignedFormats() : *
      {
         Bold11Rright = format(11,BOLD,TextFormatAlign.RIGHT);
         Bold11Left = format(11,BOLD,TextFormatAlign.LEFT);
         Bold12Rright = format(12,BOLD,TextFormatAlign.RIGHT);
         Bold12Left = format(12,BOLD,TextFormatAlign.LEFT);
         Bold14Rright = format(14,BOLD,TextFormatAlign.RIGHT);
         Bold15Right = format(15,BOLD,TextFormatAlign.RIGHT);
         Bold13Right = format(13,BOLD,TextFormatAlign.RIGHT);
         Bold14Left = format(14,BOLD,TextFormatAlign.LEFT);
         Bold16Rright = format(16,BOLD,TextFormatAlign.RIGHT);
         Bold16Left = format(16,BOLD,TextFormatAlign.LEFT);
         Bold28Right = format(28,BOLD,TextFormatAlign.RIGHT);
         Bold30Left = format(30,BOLD,TextFormatAlign.LEFT);
         CenterRegular10 = format(10,REGULAR,TextFormatAlign.CENTER);
         CenterBold10 = format(10,BOLD,TextFormatAlign.CENTER);
         CenterRegular11 = format(11,REGULAR,TextFormatAlign.CENTER);
         CenterBold11 = format(11,BOLD,TextFormatAlign.CENTER);
         CenterRegular12 = format(12,REGULAR,TextFormatAlign.CENTER);
         CenterBold12 = format(12,BOLD,TextFormatAlign.CENTER);
         CenterBold12Underline = format(12,BOLD,TextFormatAlign.CENTER,true);
         CenterRegular13 = format(13,REGULAR,TextFormatAlign.CENTER);
         CenterBold13 = format(13,BOLD,TextFormatAlign.CENTER);
         CenterRegular14 = format(14,REGULAR,TextFormatAlign.CENTER);
         CenterBold14 = format(14,BOLD,TextFormatAlign.CENTER);
         CenterRegular16 = format(16,REGULAR,TextFormatAlign.CENTER);
         CenterBold16 = format(16,BOLD,TextFormatAlign.CENTER);
         CenterBold16Underlined = format(16,BOLD,TextFormatAlign.CENTER,true);
         CenterBold17 = format(17,BOLD,TextFormatAlign.CENTER);
         CenterBold15 = format(15,BOLD,TextFormatAlign.CENTER);
         CenterRegular18 = format(18,REGULAR,TextFormatAlign.CENTER);
         CenterBold18 = format(18,BOLD,TextFormatAlign.CENTER);
         CenterBold18Underlined = format(18,BOLD,TextFormatAlign.CENTER,true);
         CenterRegular20 = format(20,REGULAR,TextFormatAlign.CENTER);
         CenterBold20 = format(20,BOLD,TextFormatAlign.CENTER);
         CenterRegular22 = format(22,REGULAR,TextFormatAlign.CENTER);
         CenterBold22 = format(22,BOLD,TextFormatAlign.CENTER);
         CenterRegular24 = format(24,REGULAR,TextFormatAlign.CENTER);
         CenterBold24 = format(24,BOLD,TextFormatAlign.CENTER);
         CenterRegular26 = format(26,REGULAR,TextFormatAlign.CENTER);
         CenterBold25 = format(25,BOLD,TextFormatAlign.CENTER);
         CenterBold26 = format(26,BOLD,TextFormatAlign.CENTER);
         CenterBold28 = format(28,BOLD,TextFormatAlign.CENTER);
         CenterBold30 = format(30,BOLD,TextFormatAlign.CENTER);
         CenterBold32 = format(32,BOLD,TextFormatAlign.CENTER);
         CenterBold33 = format(33,BOLD,TextFormatAlign.CENTER);
         CenterBold36 = format(36,BOLD,TextFormatAlign.CENTER);
         CenterBold38 = format(38,BOLD,TextFormatAlign.CENTER);
         CenterBold40 = format(40,BOLD,TextFormatAlign.CENTER);
         CenterBold44 = format(44,BOLD,TextFormatAlign.CENTER);
         CenterBold48 = format(48,BOLD,TextFormatAlign.CENTER);
         CenterBold60 = format(60,BOLD,TextFormatAlign.CENTER);
         CenterRegular42 = format(42,REGULAR,TextFormatAlign.CENTER);
      }
   }
}
