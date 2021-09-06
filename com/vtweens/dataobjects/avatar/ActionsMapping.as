package com.vtweens.dataobjects.avatar
{
   import com.vtweens.util.P2PData;
   
   public class ActionsMapping
   {
      
      private static const NUM_OF_ITEM_TYPES = 13;
      
      private static var itemTypeActualActions = new Array(NUM_OF_ITEM_TYPES);
      
      private static var ACTION_FACING_ARR = new Array();
      
      private static var P2P_DIR_TO_WALK_ACTION_ID:Array = new Array(8);
      
      public static const FACE_S:int = 0;
      
      public static const FACE_W:int = 1;
      
      public static const FACE_N:int = 2;
      
      public static const FACE_E:int = 3;
      
      public static const FACE_SE:int = 4;
      
      public static const FACE_SW:int = 5;
      
      public static const FACE_NW:int = 6;
      
      public static const FACE_NE:int = 7;
      
      public static const WALK_S:int = 8;
      
      public static const WALK_W:int = 9;
      
      public static const WALK_N:int = 10;
      
      public static const WALK_E:int = 11;
      
      public static const WALK_SE:int = 12;
      
      public static const WALK_SW:int = 13;
      
      public static const WALK_NW:int = 14;
      
      public static const WALK_NE:int = 15;
      
      public static const FACE_SW_0:int = 16;
      
      public static const FACE_SW_1:int = 17;
      
      public static const FACE_SW_2:int = 18;
      
      public static const FACE_SW_3:int = 19;
      
      public static const FACE_SW_4:int = 20;
      
      public static const FACE_S_0:int = 21;
      
      public static const FACE_S_1:int = 22;
      
      public static const FACE_S_2:int = 23;
      
      public static const FACE_S_3:int = 24;
      
      public static const FACE_S_4:int = 25;
      
      public static const FACE_SE_0:int = 26;
      
      public static const FACE_SE_1:int = 27;
      
      public static const FACE_SE_2:int = 28;
      
      public static const FACE_SE_3:int = 29;
      
      public static const FACE_SE_4:int = 30;
      
      public static const FACE_W_0:int = 31;
      
      public static const FACE_W_1:int = 32;
      
      public static const FACE_W_2:int = 33;
      
      public static const FACE_W_3:int = 34;
      
      public static const FACE_W_4:int = 35;
      
      public static const FACE_E_0:int = 36;
      
      public static const FACE_E_1:int = 37;
      
      public static const FACE_E_2:int = 38;
      
      public static const FACE_E_3:int = 39;
      
      public static const FACE_E_4:int = 40;
      
      public static const WALK_S_FILE:int = 0;
      
      public static const WALK_W_FILE:int = 1;
      
      public static const WALK_N_FILE:int = 2;
      
      public static const WALK_E_FILE:int = 3;
      
      public static const WALK_SE_FILE:int = 4;
      
      public static const WALK_SW_FILE:int = 5;
      
      public static const WALK_NW_FILE:int = 6;
      
      public static const WALK_NE_FILE:int = 7;
      
      public static const NUM_OF_FILES:int = 8;
      
      public static const FILE_SUFIX:Array = ["s_stand","w_stand","n_stand","e_stand","se_stand","sw_stand","ne_stand","nw_stand","s_walk","w_walk","n_walk","e_walk","se_walk","sw_walk","ne_walk","nw_walk"];
      
      public static const ACTION_FRAME_NAMES:Array = ["s_stand","w_stand","n_stand","e_stand","se_stand","sw_stand","ne_stand","nw_stand","s_walk","w_walk","n_walk","e_walk","se_walk","sw_walk","ne_walk","nw_walk","sw_0","sw_1","sw_2","sw_3","sw_4","s_0","s_1","s_2","s_3","s_4","se_0","se_1","se_2","se_3","se_4","w_0","w_1","w_2","w_3","w_4","e_0","e_1","e_2","e_3","e_4"];
      
      public static const AMINALS_ACTION_FRAME_NAMES:Array = ["s","s","s","s","s","s","s","s","w","w","w","w","w","w","w","w"];
      
      public static const AMINALS_ANIMATION_FRAME_NAMES:Array = ["ani1","ani2"];
      
      {
         ACTION_FACING_ARR[FACE_S] = FACE_S;
         ACTION_FACING_ARR[FACE_W] = FACE_W;
         ACTION_FACING_ARR[FACE_N] = FACE_N;
         ACTION_FACING_ARR[FACE_E] = FACE_E;
         ACTION_FACING_ARR[FACE_SE] = FACE_SE;
         ACTION_FACING_ARR[FACE_SW] = FACE_SW;
         ACTION_FACING_ARR[FACE_NE] = FACE_NE;
         ACTION_FACING_ARR[FACE_NW] = FACE_NW;
         ACTION_FACING_ARR[WALK_S] = FACE_S;
         ACTION_FACING_ARR[WALK_W] = FACE_W;
         ACTION_FACING_ARR[WALK_N] = FACE_N;
         ACTION_FACING_ARR[WALK_E] = FACE_E;
         ACTION_FACING_ARR[WALK_SE] = FACE_SE;
         ACTION_FACING_ARR[WALK_SW] = FACE_SW;
         ACTION_FACING_ARR[WALK_NE] = FACE_NE;
         ACTION_FACING_ARR[WALK_NW] = FACE_NW;
         P2P_DIR_TO_WALK_ACTION_ID[P2PData.S] = WALK_S;
         P2P_DIR_TO_WALK_ACTION_ID[P2PData.SW] = WALK_SW;
         P2P_DIR_TO_WALK_ACTION_ID[P2PData.W] = WALK_W;
         P2P_DIR_TO_WALK_ACTION_ID[P2PData.NW] = WALK_NW;
         P2P_DIR_TO_WALK_ACTION_ID[P2PData.N] = WALK_N;
         P2P_DIR_TO_WALK_ACTION_ID[P2PData.NE] = WALK_NE;
         P2P_DIR_TO_WALK_ACTION_ID[P2PData.E] = WALK_E;
         P2P_DIR_TO_WALK_ACTION_ID[P2PData.SE] = WALK_SE;
      }
      
      public function ActionsMapping()
      {
         super();
      }
      
      public static function NumberOfActions() : int
      {
         return 16;
      }
      
      public static function GetFaceDirection(param1:int) : int
      {
         return ACTION_FACING_ARR[param1];
      }
      
      public static function GetWalkActionId(param1:int) : int
      {
         return P2P_DIR_TO_WALK_ACTION_ID[param1];
      }
      
      public static function isEastFacing(param1:int, param2:int = -1) : Boolean
      {
         if(param1 == FACE_E || param1 == WALK_E || param1 == FACE_SE || param1 == WALK_SE || param1 == FACE_NW || param1 == WALK_NW)
         {
            return true;
         }
         if(param1 == FACE_W || param1 == WALK_W || param1 == FACE_SW || param1 == WALK_SW || param1 == FACE_NE || param1 == WALK_NE)
         {
            return false;
         }
         if(param2 < 0)
         {
            return true;
         }
         if(param2 == FACE_W || param2 == WALK_W || param2 == FACE_SW || param2 == WALK_SW || param2 == FACE_NW || param2 == WALK_NW)
         {
            return false;
         }
         return true;
      }
      
      public static function isFaceAction(param1:int) : Boolean
      {
         return param1 == FACE_E || param1 == FACE_W || param1 == FACE_N || param1 == FACE_S || param1 == FACE_NW || param1 == FACE_SW || param1 == FACE_SE || param1 == FACE_NE;
      }
      
      public static function isSouthFacing(param1:int) : *
      {
         return ActionsMapping.GetFaceDirection(param1) == ActionsMapping.FACE_S || ActionsMapping.GetFaceDirection(param1) == ActionsMapping.WALK_S || ActionsMapping.GetFaceDirection(param1) == ActionsMapping.FACE_SW || ActionsMapping.GetFaceDirection(param1) == ActionsMapping.WALK_SW || ActionsMapping.GetFaceDirection(param1) == ActionsMapping.FACE_SE || ActionsMapping.GetFaceDirection(param1) == ActionsMapping.WALK_SE;
      }
   }
}
