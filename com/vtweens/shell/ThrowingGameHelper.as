package com.vtweens.shell
{
   import com.vtweens.consts.COMMANDS;
   import com.vtweens.consts.GENERAL_STR_KEYS;
   import com.vtweens.consts.ZONEEXTENSIONS;
   import com.vtweens.dataobjects.room.events.RoomEvent;
   import com.vtweens.dataobjects.throwing.Target;
   import com.vtweens.text.TextResourceManager;
   import com.vtweens.util.MainGetter;
   import com.vtweens.util.P2PData;
   
   public class ThrowingGameHelper
   {
      
      public static var loadme;
       
      
      public function ThrowingGameHelper()
      {
         super();
      }
      
      public static function get ThrowingGameTarget() : Target
      {
         return MainGetter.MainCaller.throwingTarget;
      }
      
      public static function set ThrowingGameTarget(param1:Target) : *
      {
         MainGetter.MainCaller.throwingTarget = param1;
      }
      
      public static function ThrowTragetGameEnd() : *
      {
         ThrowingGameTarget.enabled = false;
         ThrowingGameTarget = null;
      }
      
      public static function startTrowingGame() : *
      {
         ThrowingGameTarget.step();
      }
      
      public static function ThrowGameTimeout(param1:Target) : *
      {
         var _loc2_:* = new Object();
         _loc2_[COMMANDS.V_GAME_ID] = ThrowingGameTarget.getGameId();
         _loc2_[COMMANDS.V_GAME_TOKEN] = MainGetter.MainCaller.GameToken;
         MainGetter.MainCaller.SFS.sendXtMessage(ZONEEXTENSIONS.ThrowingGame,COMMANDS.C_THROW_GAME_TIMEOUT,_loc2_,"json",MainGetter.MainCaller.SfsRoomId);
      }
      
      public static function ThrowItemAtTraget(param1:*, param2:*, param3:Boolean, param4:*, param5:*, param6:*) : *
      {
         var _loc7_:*;
         (_loc7_ = createThrowRequestParam(param1,param2,param3,param4,param5,param6))[COMMANDS.V_GAME_TOKEN] = MainGetter.MainCaller.GameToken;
         MainGetter.MainCaller.SFS.sendXtMessage(ZONEEXTENSIONS.ThrowingGame,COMMANDS.C_THROW_ITEM,_loc7_,"json",MainGetter.MainCaller.SfsRoomId);
      }
      
      public static function RecycleGameTimeout(param1:Target) : *
      {
         var _loc2_:* = new Object();
         _loc2_[COMMANDS.V_GAME_ID] = ThrowingGameTarget.getGameId();
         _loc2_[COMMANDS.V_GAME_TOKEN] = MainGetter.MainCaller.GameToken;
         MainGetter.MainCaller.SFS.sendXtMessage(ZONEEXTENSIONS.RecyclingGame,COMMANDS.C_THROW_GAME_TIMEOUT,_loc2_,"json",MainGetter.MainCaller.SfsRoomId);
      }
      
      public static function ThrowRecycleItemAtTraget(param1:*, param2:*, param3:Boolean, param4:*, param5:*, param6:*) : *
      {
         var _loc7_:*;
         (_loc7_ = createThrowRequestParam(param1,param2,param3,param4,param5,param6))[COMMANDS.V_GAME_TOKEN] = MainGetter.MainCaller.GameToken;
         MainGetter.MainCaller.SFS.sendXtMessage(ZONEEXTENSIONS.RecyclingGame,COMMANDS.C_THROW_ITEM,_loc7_,"json",MainGetter.MainCaller.SfsRoomId);
      }
      
      private static function createThrowRequestParam(param1:*, param2:*, param3:Boolean, param4:*, param5:*, param6:*) : *
      {
         var _loc7_:*;
         (_loc7_ = new Object())[COMMANDS.V_PX] = int(param1.x);
         _loc7_[COMMANDS.V_PY] = int(param1.y);
         _loc7_[COMMANDS.V_TOP_X] = int(param2.x);
         _loc7_[COMMANDS.V_TOP_Y] = int(param2.y);
         _loc7_[COMMANDS.V_HIT] = param3;
         _loc7_[COMMANDS.V_COUNT] = param4;
         _loc7_[COMMANDS.V_GAME_ID] = param5;
         _loc7_[COMMANDS.V_TARGET_ID] = param6;
         return _loc7_;
      }
      
      public static function ShowThrowGameOverData(param1:*) : void
      {
         var _loc2_:* = [param1.level,param1.score];
         var _loc3_:* = TextResourceManager.getString(GENERAL_STR_KEYS.throwing_game_over,_loc2_);
         var _loc4_:* = TextResourceManager.getString(GENERAL_STR_KEYS.reward);
         var _loc5_:* = [param1.gold,param1.xp];
         var _loc6_:* = TextResourceManager.getString(GENERAL_STR_KEYS.reward_details,_loc5_);
         MainGetter.MainCaller.popupInWorldGameOverMessage(_loc3_ + "\n" + _loc4_ + "\n" + _loc6_,ThrowingGameTarget.popupClass);
      }
      
      public static function SetPlayerPosition() : *
      {
         MainGetter.MainCaller.SetMyFaceDirection(new P2PData(MainGetter.MainCaller.MyPlayer.x,MainGetter.MainCaller.MyPlayer.y,ThrowingGameTarget.x,ThrowingGameTarget.y).getDirection());
      }
      
      public static function PerformRoomEvent(param1:RoomEvent, param2:String, param3:int) : *
      {
         MainGetter.MainCaller.PerformRoomEvent(param1,param2,param3);
      }
   }
}
