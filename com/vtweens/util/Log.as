package com.vtweens.util
{
   public class Log
   {
      
      public static const NONE:int = 0;
      
      public static const FATAL:int = 1;
      
      public static const ERROR:int = 2;
      
      public static const WARN:int = 3;
      
      public static const INFO:int = 4;
      
      public static const DEBUG:int = 5;
      
      private static const FATAL_STR:String = "FATAL: ";
      
      private static const ERROR_STR:String = "ERROR: ";
      
      private static const WARN_STR:String = "WARN: ";
      
      private static const INFO_STR:String = "INFO: ";
      
      private static const DEBUG_STR:String = "DEBUG: ";
      
      private static var level:int = FATAL;
      
      public static const SFS_DEBUG = false;
       
      
      public function Log()
      {
         super();
      }
      
      public static function set loglevel(param1:int) : *
      {
         level = param1;
      }
      
      public static function get loglevel() : *
      {
         return level;
      }
      
      public static function fatal(param1:String) : *
      {
         if(level >= FATAL)
         {
            log(FATAL_STR + param1);
         }
      }
      
      public static function error(param1:String) : *
      {
         if(level >= ERROR)
         {
            log(ERROR_STR + param1);
         }
      }
      
      public static function warn(param1:String) : *
      {
         if(level >= WARN)
         {
            log(WARN_STR + param1);
         }
      }
      
      public static function info(param1:String) : *
      {
         if(level >= INFO)
         {
            log(INFO_STR + param1);
         }
      }
      
      public static function debug(param1:String) : *
      {
         if(level >= DEBUG)
         {
            log(DEBUG_STR + param1);
         }
      }
      
      private static function log(param1:String) : *
      {
      }
   }
}
