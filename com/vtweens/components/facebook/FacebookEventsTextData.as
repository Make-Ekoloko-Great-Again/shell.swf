package com.vtweens.components.facebook
{
   import com.vtweens.text.TextResourceManager;
   import com.vtweens.util.Map;
   
   public class FacebookEventsTextData
   {
      
      private static var textualData:Map;
      
      private static var inst:FacebookEventsTextData = null;
       
      
      public function FacebookEventsTextData()
      {
         super();
         textualData = TextResourceManager.getFacebookEventsDataMap();
      }
      
      public static function get instance() : FacebookEventsTextData
      {
         if(inst == null)
         {
            inst = new FacebookEventsTextData();
         }
         return inst;
      }
      
      public function getTitle(param1:int) : *
      {
         var _loc2_:Array = textualData.get(param1)["3"];
         return _loc2_[int(Math.random() * _loc2_.length)];
      }
      
      public function getDescription(param1:int) : *
      {
         var _loc2_:Array = textualData.get(param1)["4"];
         return _loc2_[int(Math.random() * _loc2_.length)];
      }
   }
}
