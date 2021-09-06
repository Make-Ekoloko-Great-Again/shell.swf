package com.vtweens.dataobjects.player
{
   import com.vtweens.consts.ITEM_TYPES;
   import com.vtweens.dataobjects.avatar.Avatar;
   import com.vtweens.dataobjects.avatar.AvatarLayersHelper;
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class Player extends MovieClip
   {
       
      
      private var avatarObj:Avatar = null;
      
      var faceEmotionTimer:Timer;
      
      private var boardOrdinal = 0;
      
      private var cloneAvatar:Avatar = null;
      
      public var playerName = "";
      
      public var playerId = -1;
      
      public function Player(param1:Avatar)
      {
         this.faceEmotionTimer = new Timer(15000,1);
         super();
         this.avatarObj = param1;
         param1.x = -30;
         addChild(param1);
         this.faceEmotionTimer.addEventListener(TimerEvent.TIMER,this.resetFaceEmotion);
      }
      
      public function setCloneAvatar(param1:Avatar) : *
      {
         this.cloneAvatar = param1;
      }
      
      public function get clonedAvatar() : *
      {
         return this.cloneAvatar;
      }
      
      public function clearCloneAvatar() : *
      {
         this.cloneAvatar = null;
      }
      
      protected function get avatar() : Avatar
      {
         return this.avatarObj;
      }
      
      public function getFaceDirection() : int
      {
         if(this.cloneAvatar)
         {
            this.cloneAvatar.getFaceDirection();
         }
         return this.avatar.getFaceDirection();
      }
      
      public function deactivate() : *
      {
         this.faceEmotionTimer.reset();
         this.faceEmotionTimer.removeEventListener(TimerEvent.TIMER,this.resetFaceEmotion);
         if(this.cloneAvatar)
         {
            this.cloneAvatar.deactivate();
         }
         this.avatar.deactivate();
         removeChild(this.avatar);
         this.avatarObj = null;
      }
      
      public function getImmutableAvatar() : Avatar
      {
         return this.avatar.getImmutableCopy();
      }
      
      public function performAction(param1:int) : *
      {
         if(this.cloneAvatar)
         {
            this.cloneAvatar.performAction(param1);
         }
         this.avatar.performAction(param1);
      }
      
      public function freeze() : *
      {
         if(this.cloneAvatar)
         {
            this.cloneAvatar.stopWalking();
         }
         this.avatar.stopWalking();
      }
      
      public function setFaceDirection(param1:int) : *
      {
         if(this.cloneAvatar)
         {
            this.cloneAvatar.performAction(param1);
         }
         this.avatar.performAction(param1);
      }
      
      public function setFaceEmotion(param1:int) : *
      {
         this.faceEmotionTimer.reset();
         this.avatar.setFaceEmotion(param1);
         if(this.cloneAvatar)
         {
            this.cloneAvatar.setFaceEmotion(param1);
         }
         this.faceEmotionTimer.start();
      }
      
      private function resetFaceEmotion(param1:TimerEvent) : void
      {
         this.faceEmotionTimer.reset();
         if(this.cloneAvatar)
         {
            this.cloneAvatar.setFaceEmotion(AvatarLayersHelper.FACE_EMOTION_BASIC);
         }
         this.avatar.setFaceEmotion(AvatarLayersHelper.FACE_EMOTION_BASIC);
      }
      
      public function loadItem(param1:int) : *
      {
      }
      
      public function setItem(param1:int, param2:int) : *
      {
         this.stopWalking();
         if(param2 <= 0 && (param1 == ITEM_TYPES.SHIRT || param1 == ITEM_TYPES.PANTS))
         {
            param2 = 999999;
         }
         if(this.avatar)
         {
            this.avatar.setItem(param1,param2);
         }
         if(param1 == ITEM_TYPES.SKATES)
         {
            this.boardOrdinal = param2;
            if(param2 > 0)
            {
               this.onBoard = true;
            }
            else
            {
               this.onBoard = false;
            }
         }
      }
      
      protected function get isWalkRequired() : *
      {
         if(!this.onBoard || this.boardOrdinal >= 80000 && this.boardOrdinal < 90000)
         {
            return true;
         }
         return false;
      }
      
      protected function get onBoard() : Boolean
      {
         return false;
      }
      
      protected function set onBoard(param1:Boolean) : *
      {
      }
      
      public function loadSkintone(param1:int) : *
      {
      }
      
      public function setSkintone(param1:int) : *
      {
         this.stopWalking();
         this.avatar.setSkintone(param1);
         if(this.cloneAvatar)
         {
            this.cloneAvatar.setSkintone(param1);
         }
      }
      
      public function stopWalking() : *
      {
         if(this.avatar != null)
         {
            this.avatar.stopWalking();
         }
         if(this.cloneAvatar)
         {
            this.cloneAvatar.stopWalking();
         }
      }
   }
}
