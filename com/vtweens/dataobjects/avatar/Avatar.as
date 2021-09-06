package com.vtweens.dataobjects.avatar
{
   import com.vtweens.dataobjects.item.AnimatedItem;
   import com.vtweens.dataobjects.item.EmptyAnimatedItem;
   import com.vtweens.util.P2PData;
   import flash.display.Sprite;
   import flash.errors.IllegalOperationError;
   
   public class Avatar extends Sprite
   {
       
      
      private var _faceEmotionLabel:String;
      
      private var _currentActionId:int = 0;
      
      private var _currentEmotionId:int = 0;
      
      public function Avatar()
      {
         this._faceEmotionLabel = AvatarLayersHelper.GetFaceEmotionLabel(AvatarLayersHelper.FACE_EMOTION_BASIC);
         super();
      }
      
      public function deactivate() : void
      {
         throw new IllegalOperationError("Abstract class function not supported");
      }
      
      public function setItem(param1:*, param2:int) : void
      {
         throw new IllegalOperationError("Abstract class function not supported");
      }
      
      public function setSkintone(param1:int) : void
      {
         throw new IllegalOperationError("Abstract class function not supported");
      }
      
      public function getAnimatedItemsCopy(param1:Boolean = false) : Array
      {
         throw new IllegalOperationError("Abstract class function not supported");
      }
      
      public function stopWalking() : void
      {
         throw new IllegalOperationError("Abstract class function not supported");
      }
      
      public function getFaceDirection() : int
      {
         throw new IllegalOperationError("Abstract class function not supported");
      }
      
      public function getImmutableCopy() : Avatar
      {
         throw new IllegalOperationError("Abstract class function not supported");
      }
      
      public function hideShadow() : void
      {
         this.removeItem(AvatarLayersHelper.SDW);
      }
      
      public function hideItemsForGame() : void
      {
         this.removeItem(AvatarLayersHelper.SDW);
         this.removeItem(AvatarLayersHelper.HOV);
         this.removeItem(AvatarLayersHelper.SKT);
         this.removeItem(AvatarLayersHelper.SKF);
      }
      
      public function hideHover() : void
      {
         this.removeItem(AvatarLayersHelper.HOV);
      }
      
      public function hideBoard() : void
      {
         this.removeItem(AvatarLayersHelper.SKT);
         this.removeItem(AvatarLayersHelper.SKF);
      }
      
      public function hideHair() : void
      {
         this.removeItem(AvatarLayersHelper.FHR);
         this.removeItem(AvatarLayersHelper.BHR);
         this.removeItem(AvatarLayersHelper.HBH);
         this.removeItem(AvatarLayersHelper.HFH);
      }
      
      public function hideHat() : void
      {
         this.removeItem(AvatarLayersHelper.HAT);
      }
      
      public function isHiddenGameItem(param1:int) : Boolean
      {
         return param1 == AvatarLayersHelper.SDW || param1 == AvatarLayersHelper.HOV || param1 == AvatarLayersHelper.SKT || param1 == AvatarLayersHelper.SKF;
      }
      
      public function performAction(param1:int, param2:Boolean = false) : void
      {
         AvatarLayersHelper.ReorderLayers(this,param1,param2);
         if(this.currentActionId != param1)
         {
            this.gotoAndPlayAction(param1);
         }
      }
      
      public function animateTurnAndWalkDirection(param1:int) : void
      {
         var _loc2_:* = ActionsMapping.GetWalkActionId(param1);
         if(this.currentActionId != _loc2_)
         {
            AvatarLayersHelper.ReorderLayers(this,_loc2_);
            this.gotoAndPlayAction(_loc2_);
         }
      }
      
      public function animateTurnAndWalk(param1:P2PData) : void
      {
         this.animateTurnAndWalkDirection(param1.getDirection());
      }
      
      protected function performItemAction(param1:AnimatedItem) : *
      {
         var _loc2_:* = this.currentActionId;
         if(param1.getLayerId() != AvatarLayersHelper.SKT && this.getItemsArray()[AvatarLayersHelper.SKT].getOrdinal() > 0 && this.getItemsArray()[AvatarLayersHelper.SKT].getOrdinal() < 80000)
         {
            _loc2_ = ActionsMapping.GetFaceDirection(_loc2_);
         }
         if(param1.getLayerId() == AvatarLayersHelper.MKP)
         {
            if(_loc2_ == ActionsMapping.FACE_SE)
            {
               switch(this._currentEmotionId)
               {
                  case 1:
                     param1.gotoAndPlayAction(ActionsMapping.FACE_SE_1);
                     break;
                  case 2:
                     param1.gotoAndPlayAction(ActionsMapping.FACE_SE_2);
                     break;
                  case 3:
                     param1.gotoAndPlayAction(ActionsMapping.FACE_SE_3);
                     break;
                  case 4:
                     param1.gotoAndPlayAction(ActionsMapping.FACE_SE_4);
                     break;
                  default:
                     param1.gotoAndPlayAction(_loc2_);
               }
            }
            else if(_loc2_ == ActionsMapping.FACE_S)
            {
               switch(this._currentEmotionId)
               {
                  case 1:
                     param1.gotoAndPlayAction(ActionsMapping.FACE_S_1);
                     break;
                  case 2:
                     param1.gotoAndPlayAction(ActionsMapping.FACE_S_2);
                     break;
                  case 3:
                     param1.gotoAndPlayAction(ActionsMapping.FACE_S_3);
                     break;
                  case 4:
                     param1.gotoAndPlayAction(ActionsMapping.FACE_S_4);
                     break;
                  default:
                     param1.gotoAndPlayAction(_loc2_);
               }
            }
            else if(_loc2_ == ActionsMapping.FACE_SW)
            {
               switch(this._currentEmotionId)
               {
                  case 1:
                     param1.gotoAndPlayAction(ActionsMapping.FACE_SW_1);
                     break;
                  case 2:
                     param1.gotoAndPlayAction(ActionsMapping.FACE_SW_2);
                     break;
                  case 3:
                     param1.gotoAndPlayAction(ActionsMapping.FACE_SW_3);
                     break;
                  case 4:
                     param1.gotoAndPlayAction(ActionsMapping.FACE_SW_4);
                     break;
                  default:
                     param1.gotoAndPlayAction(_loc2_);
               }
            }
            else if(_loc2_ == ActionsMapping.FACE_W)
            {
               switch(this._currentEmotionId)
               {
                  case 1:
                     param1.gotoAndPlayAction(ActionsMapping.FACE_W_1);
                     break;
                  case 2:
                     param1.gotoAndPlayAction(ActionsMapping.FACE_W_2);
                     break;
                  case 3:
                     param1.gotoAndPlayAction(ActionsMapping.FACE_W_3);
                     break;
                  case 4:
                     param1.gotoAndPlayAction(ActionsMapping.FACE_W_4);
                     break;
                  default:
                     param1.gotoAndPlayAction(_loc2_);
               }
            }
            else if(_loc2_ == ActionsMapping.FACE_E)
            {
               switch(this._currentEmotionId)
               {
                  case 1:
                     param1.gotoAndPlayAction(ActionsMapping.FACE_E_1);
                     break;
                  case 2:
                     param1.gotoAndPlayAction(ActionsMapping.FACE_E_2);
                     break;
                  case 3:
                     param1.gotoAndPlayAction(ActionsMapping.FACE_E_3);
                     break;
                  case 4:
                     param1.gotoAndPlayAction(ActionsMapping.FACE_E_4);
                     break;
                  default:
                     param1.gotoAndPlayAction(_loc2_);
               }
            }
            else
            {
               param1.gotoAndPlayAction(_loc2_);
            }
         }
         else
         {
            param1.gotoAndPlayAction(_loc2_);
         }
      }
      
      protected function gotoAndPlayAction(param1:int) : *
      {
         var _loc2_:* = undefined;
         this.currentActionId = param1;
         for each(_loc2_ in this.getItemsArray())
         {
            if(_loc2_ != null)
            {
               this.performItemAction(_loc2_);
            }
         }
      }
      
      protected function getItemsArray() : Array
      {
         throw new IllegalOperationError("Abstract class function not supported");
      }
      
      public function get gender() : int
      {
         return this.getItemsArray()[AvatarLayersHelper.EYE].getOrdinal() == 1 ? 1 : 2;
      }
      
      protected function removeItem(param1:*) : void
      {
         var _loc2_:* = getChildByName(param1);
         if(_loc2_ != null)
         {
            removeChild(getChildByName(param1));
         }
         var _loc3_:* = new EmptyAnimatedItem(param1);
         this.getItemsArray()[param1] = _loc3_;
         addChild(_loc3_);
         this.performAction(this.getFaceActionId());
      }
      
      protected function getFaceActionId() : int
      {
         return ActionsMapping.GetFaceDirection(this.currentActionId);
      }
      
      protected function get faceEmotionLabel() : String
      {
         return this._faceEmotionLabel;
      }
      
      protected function set faceEmotionLabel(param1:String) : void
      {
         this._faceEmotionLabel = param1;
      }
      
      protected function get currentActionId() : int
      {
         return this._currentActionId;
      }
      
      protected function set currentActionId(param1:int) : void
      {
         this._currentActionId = param1;
      }
      
      public function getAction() : int
      {
         return this.currentActionId;
      }
      
      public function setFaceEmotion(param1:int) : void
      {
         this._currentEmotionId = param1;
         this.faceEmotionLabel = AvatarLayersHelper.GetFaceEmotionLabel(param1);
         this.getItemsArray()[AvatarLayersHelper.EYE].setFaceEmotion(this.faceEmotionLabel);
         this.getItemsArray()[AvatarLayersHelper.HED].setFaceEmotion(this.faceEmotionLabel);
         this.performItemAction(this.getItemsArray()[AvatarLayersHelper.MKP]);
      }
   }
}
