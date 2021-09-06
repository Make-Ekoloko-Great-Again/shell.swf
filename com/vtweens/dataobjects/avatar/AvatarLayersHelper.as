package com.vtweens.dataobjects.avatar
{
   public class AvatarLayersHelper
   {
      
      public static const FHR = 0;
      
      public static const BHR = 1;
      
      public static const HED = 2;
      
      public static const MTH = 3;
      
      public static const EYE = 4;
      
      public static const TOR = 5;
      
      public static const RAR = 6;
      
      public static const LAR = 7;
      
      public static const LEG = 8;
      
      public static const FET = 9;
      
      public static const SHT = 10;
      
      public static const LSV = 11;
      
      public static const RSV = 12;
      
      public static const PTS = 13;
      
      public static const SHZ = 14;
      
      public static const NEK = 15;
      
      public static const EAR = 16;
      
      public static const RNG = 17;
      
      public static const HOV = 18;
      
      public static const SDW = 19;
      
      public static const GLS = 20;
      
      public static const HAT = 21;
      
      public static const HBH = 22;
      
      public static const HFH = 23;
      
      public static const SKT = 24;
      
      public static const MKP = 25;
      
      public static const SKF = 26;
      
      public static const NUM_OF_LAYERS = 27;
      
      public static const strs = ["HFR","HBK","HED","MTH","EYE","TOR","RAR","LAR","LEG","FET","SHT","LSV","RSV","PTS","SHZ","NEK","EAR","RNG","HOV","SDW","GLS","HAT","HBH","HFH","SKT","MKP","SKF"];
      
      public static const FACE_EMOTION_BASIC = 0;
      
      public static const FACE_EMOTION_LAUGH = 1;
      
      public static const FACE_EMOTION_PUZZLED = 2;
      
      public static const FACE_EMOTION_ANGRY = 3;
      
      public static const FACE_EMOTION_SHOCK = 4;
      
      public static const faceEmotionsLables:Array = ["basic","laugh","puzzled","angry","shock"];
      
      private static var layersOrders:Array = new Array(8);
      
      private static var allDirOrder = [SKF,HOV,HAT,FHR,GLS,EYE,MTH,MKP,EAR,HED,RSV,RAR,NEK,SHT,PTS,SHZ,LEG,TOR,LSV,LAR,RNG,BHR,FET,SDW,SKT];
      
      private static var southOrder = [SKF,HOV,HAT,FHR,GLS,EYE,MTH,MKP,EAR,HED,NEK,SHT,PTS,SHZ,LEG,TOR,RSV,RAR,LSV,LAR,RNG,BHR,FET,SDW,SKT];
      
      private static var northOrder = [SKF,HOV,HAT,FHR,GLS,EYE,MTH,MKP,EAR,HED,NEK,SHT,RSV,LSV,PTS,SHZ,LEG,TOR,RAR,LAR,RNG,BHR,FET,SDW,SKT];
      
      private static const REGULAR = 0;
      
      private static const FLOWER = 1;
      
      private static const HELMET = 2;
      
      {
         layersOrders[ActionsMapping.FACE_S] = northOrder;
         layersOrders[ActionsMapping.FACE_W] = allDirOrder;
         layersOrders[ActionsMapping.FACE_E] = allDirOrder;
         layersOrders[ActionsMapping.FACE_N] = northOrder;
         layersOrders[ActionsMapping.FACE_SE] = allDirOrder;
         layersOrders[ActionsMapping.FACE_SW] = allDirOrder;
         layersOrders[ActionsMapping.FACE_NE] = allDirOrder;
         layersOrders[ActionsMapping.FACE_NW] = allDirOrder;
      }
      
      public function AvatarLayersHelper()
      {
         super();
      }
      
      public static function GetFaceEmotionLabel(param1:int) : String
      {
         if(param1 < faceEmotionsLables.length && param1 > 0)
         {
            return faceEmotionsLables[param1];
         }
         return faceEmotionsLables[0];
      }
      
      public static function getLayerFileID(param1:int) : *
      {
         return strs[param1];
      }
      
      public static function ReorderLayers(param1:Avatar, param2:int, param3:* = false) : *
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         if(param3 || param1.getFaceDirection() == ActionsMapping.FACE_S && ActionsMapping.GetFaceDirection(param2) != ActionsMapping.FACE_S || param1.getFaceDirection() != ActionsMapping.FACE_S && ActionsMapping.GetFaceDirection(param2) == ActionsMapping.FACE_S)
         {
            _loc4_ = layersOrders[ActionsMapping.GetFaceDirection(param2)];
            for(_loc5_ in _loc4_)
            {
               if((_loc6_ = param1.getChildByName(_loc4_[_loc5_])) != null)
               {
                  param1.setChildIndex(_loc6_,_loc4_.length - 1 - _loc5_);
               }
            }
         }
      }
      
      public static function customItemForHat(param1:*, param2:*) : void
      {
         var _loc4_:* = undefined;
         var _loc3_:* = param2[AvatarLayersHelper.HAT];
         if(param1.getLayerId() == AvatarLayersHelper.HAT)
         {
            _loc4_ = param1;
            setItemForHat(_loc4_,param2[AvatarLayersHelper.FHR]);
            setItemForHat(_loc4_,param2[AvatarLayersHelper.BHR]);
            setItemForHat(_loc4_,param2[AvatarLayersHelper.EAR]);
         }
         else if(param1.getLayerId() == AvatarLayersHelper.FHR || param1.getLayerId() == AvatarLayersHelper.BHR || param1.getLayerId() == AvatarLayersHelper.EAR)
         {
            setItemForHat(param2[AvatarLayersHelper.HAT],param1);
         }
      }
      
      private static function setItemForHat(param1:*, param2:*) : *
      {
         if(param2.getOrdinal() > 0)
         {
            if(param1.getOrdinal() > 0)
            {
               switch(getHatType(param1.getOrdinal()))
               {
                  case REGULAR:
                     param2.setSecondary();
                     break;
                  case FLOWER:
                     param2.setPrimer();
                     break;
                  case HELMET:
                     param2.setInvisible();
               }
            }
            else
            {
               param2.setPrimer();
            }
         }
      }
      
      public static function setShadowForSkate(param1:Array) : *
      {
         var _loc2_:* = param1[SKT];
         var _loc3_:* = param1[SDW];
         if(_loc2_.getOrdinal() > 0)
         {
            _loc3_.visible = false;
         }
         else
         {
            _loc3_.visible = true;
         }
      }
      
      private static function getHatType(param1:*) : *
      {
         if(param1 < 80000)
         {
            return REGULAR;
         }
         if(param1 < 90000)
         {
            return HELMET;
         }
         return FLOWER;
      }
   }
}
