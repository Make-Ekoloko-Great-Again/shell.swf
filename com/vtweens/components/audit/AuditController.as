package com.vtweens.components.audit
{
   import com.vtweens.text.LanugageControl;
   import com.vtweens.util.HtmlNavigation;
   import com.vtweens.util.Map;
   import com.vtweens.util.XmlParser;
   
   public class AuditController extends XmlParser
   {
      
      private static var _instance:AuditController;
      
      private static const category_conversion = "conversion";
      
      private static const category_activity = "activity";
       
      
      private var _username;
      
      private var _playerId;
      
      private var _daysPlayed;
      
      private var serverTarget = "";
      
      private var active = false;
      
      private var config:XmlParser;
      
      public function AuditController()
      {
         super();
         loadData();
      }
      
      public static function get instance() : AuditController
      {
         if(!_instance)
         {
            _instance = new AuditController();
         }
         return _instance;
      }
      
      override protected function get xmlUrl() : String
      {
         return "./conf/audit_control.xml";
      }
      
      override protected function parse(param1:XML) : *
      {
         this.serverTarget = param1.target_server;
         this.active = int(param1.active) == 0 ? false : true;
      }
      
      public function sendActionRequest(param1:*, param2:*, param3:* = null) : *
      {
         this.sendGoogleActionRequest(this.getDaysPlayedCategory(param1),param2,param3);
      }
      
      public function sendGoogleActionRequest(param1:*, param2:*, param3:*) : *
      {
         if(param3)
         {
            HtmlNavigation.execJavascript("sendGoogleActionRequest(\'" + param1 + "\', \'" + param2 + "\', \'" + param3 + "\');");
         }
         else
         {
            HtmlNavigation.execJavascript("sendGoogleActionRequest(\'" + param1 + "\', \'" + param2 + "\');");
         }
      }
      
      public function ping() : *
      {
         this.sendActionRequest("global","ping");
      }
      
      public function sendPremuimPopupEvent(param1:String) : *
      {
         this.sendActionRequest(category_conversion,param1);
      }
      
      public function sendPremuimPopupOpenedStore(param1:String) : *
      {
         this.sendActionRequest(category_conversion,param1 + "__goto_store");
      }
      
      private function getDaysPlayedCategory(param1:String) : *
      {
         var _loc2_:String = null;
         if(this._daysPlayed < 10)
         {
            _loc2_ = "" + this._daysPlayed;
         }
         else
         {
            _loc2_ = "10&Up";
         }
         return LanugageControl.language + "_" + param1 + "_day_" + _loc2_;
      }
      
      public function set username(param1:*) : *
      {
         this._username = param1;
      }
      
      public function set targetServer(param1:*) : *
      {
         this.serverTarget = param1;
      }
      
      public function login(param1:*, param2:*, param3:*, param4:*, param5:*, param6:*, param7:*, param8:*, param9:*, param10:*, param11:*, param12:* = false, param13:* = null, param14:* = null) : *
      {
         var _loc15_:Map = new Map();
         this._username = param1;
         this._playerId = param2;
         this._daysPlayed = param5;
         this.sendActionRequest(category_activity,"login");
      }
      
      public function levelUp(param1:*) : *
      {
         this.sendActionRequest(category_activity,"level_up",param1);
      }
      
      public function chat() : *
      {
         this.sendActionRequest(category_activity,"chat");
      }
      
      public function potionUsedOnSelf(param1:*) : *
      {
         this.sendActionRequest(category_activity,"potion_used",param1);
      }
      
      public function potionUsedOnOther(param1:*) : *
      {
         this.sendActionRequest(category_activity,"potion_used",param1);
      }
      
      public function emoticon(param1:*) : *
      {
         this.sendActionRequest(category_activity,"emoticon",param1);
      }
      
      public function helperMenuClick(param1:*) : *
      {
         this.sendActionRequest(category_activity,"helper_menu_click",param1);
      }
      
      public function clickedMM(param1:*) : *
      {
         this.sendActionRequest(category_activity,"main_menu_click",param1);
      }
      
      public function specialOffer() : *
      {
         this.sendActionRequest(category_conversion,"popup_special_offer",this._daysPlayed);
      }
      
      public function renewalReward() : *
      {
         this.sendActionRequest(category_conversion,"popup_renewal_reward",this._daysPlayed);
      }
      
      public function dailyReward() : *
      {
         this.sendActionRequest(category_activity,"daily_reward");
      }
      
      public function enterRoom(param1:*) : *
      {
         this.sendActionRequest(category_activity,"enter_room",param1);
      }
      
      public function cannotEnterRoom(param1:*) : *
      {
         this.sendActionRequest(category_activity,"enter_room_restricted",param1);
      }
      
      public function cannotInitMultiplayerTask(param1:*) : *
      {
         this.sendActionRequest(category_activity,"multiplayer_task_restricted_init",param1);
      }
      
      public function cannotJoinMultiplayerTask(param1:*) : *
      {
         this.sendActionRequest(category_activity,"multiplayer_task_restricted_join",param1);
      }
      
      public function infoRoomItem(param1:*) : *
      {
         this.sendActionRequest(category_activity,"room_click_info_item",param1);
      }
      
      public function infoTaskItemClicked(param1:*) : *
      {
         this.sendActionRequest(category_activity,"room_click_multiplayer_task_item",param1);
      }
      
      public function NPCCLick(param1:*) : *
      {
         this.sendActionRequest(category_activity,"room_click_npc",param1);
      }
      
      public function OtherUserClick() : *
      {
         this.sendActionRequest(category_activity,"room_click_other_user");
      }
      
      public function StoreClick(param1:*) : *
      {
         this.sendActionRequest(category_activity,"room_click_store",param1);
      }
      
      public function AnimalStoreClick(param1:*) : *
      {
         this.sendActionRequest(category_activity,"room_click_animal_store",param1);
      }
      
      public function potionStoreClick(param1:*) : *
      {
         this.sendActionRequest(category_activity,"room_click_potion_store",param1);
      }
      
      public function creditsStoreOpen() : *
      {
         this.sendActionRequest(category_activity,"credits_store_open");
         this.sendActionRequest(category_conversion,"credits_store_open");
      }
      
      public function GamePlayed(param1:*) : *
      {
         this.sendActionRequest(category_activity,"game_played_single_player",param1);
      }
      
      public function InWorldGamePlayed(param1:*) : *
      {
         this.sendActionRequest(category_activity,"game_played_in_world",param1);
      }
      
      public function OuizPlayed(param1:*) : *
      {
         this.sendActionRequest(category_activity,"game_played_quiz",param1);
      }
      
      public function GameInstructions(param1:*) : *
      {
         this.sendActionRequest(category_activity,"game_instructions_single_player",param1);
      }
      
      public function GamePlayed1on1(param1:*) : *
      {
         this.sendActionRequest(category_activity,"game_played_1-1",param1);
      }
      
      public function GamePlayed1on1Spectator(param1:*) : *
      {
         this.sendActionRequest(category_activity,"game_played_1-1_spectator",param1);
      }
   }
}
