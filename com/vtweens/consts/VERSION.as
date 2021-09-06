package com.vtweens.consts
{
   import com.vtweens.util.Map;
   
   public class VERSION
   {
      
      public static const SERVER_VERSION:String = "9.1";
      
      public static const CLIENT_VERSION = "0";
      
      public static var MAIN_VERSION = "0";
      
      public static var ROOMS_VERSION = "0";
      
      public static var ZONES_VERSION = "0";
      
      public static var ITEMS_IMAGE_VERSION = "0";
      
      public static var SINGLE_PLAYER_GAMES_VERSION = "0";
      
      public static var ONE_ON_ONE_GAMES_VERSION = "0";
      
      public static var ANIMAL_GAMES_VERSION = "0";
      
      public static var IN_WORLD_GAMES_VERSION = "0";
      
      public static var HOUSE_VERSION = "0";
      
      public static var POPUPS_VERSION = "0";
      
      public static var RANDOM_EVENTS_VERSION = "0";
      
      public static var QUEST_IMAGES_VERSION = "0";
      
      public static var MAP_VERSION = "0";
      
      public static var ANIMALS_VERSION = "0";
      
      public static var NPCS_VERSION = "0";
      
      public static var SOUNDS_VERSION = "0";
      
      public static var PRELOADERS_VERSION = "0";
      
      public static var TEXT_VERSION = "0";
      
      public static var HELP_POPUPS_VERSION = "0";
      
      public static var PREMIUM_CLIP_VERSION = "0";
      
      public static var LOGIN_VERSION = "0";
      
      public static var COMMUNITY_EVENT_VERSION = "0";
      
      public static var EMOTICONS_VERSION = "0";
      
      public static var RECYCLE_BINS_VERSION = "0";
      
      public static var RECYCLE_ITEMS_VERSION = "0";
      
      public static var SECURITY_FORM_VERSION = "0";
      
      public static var CREDITS_STORE_VERSION = "0";
      
      public static var LOGIN_BANNERS_VERSION = "0";
      
      public static var HELPER_VERSION = "0";
      
      public static var CARDS_VERSION = "0";
      
      public static var POTIONS_VERSION = "0";
      
      public static var COMMUNITY_GENDER_CHALLENGE = "0";
      
      public static var DAYS_PLAYED_REWARD = "0";
      
      public static var BANNER_LOGICS = "0";
      
      public static var ICONS = "0";
      
      public static var MOODS = "0";
      
      public static var COLORS = "0";
      
      public static var MULTI_PLAYER_TASKS = "0";
      
      private static var staticDataMap:Map = new Map();
      
      private static var roomsMap:Map = new Map();
      
      private static var zonesMap:Map = new Map();
      
      private static var itemsMap:Map = new Map();
      
      private static var singlePlayerGamesMap:Map = new Map();
      
      private static var animalGamesMap:Map = new Map();
      
      private static var oneOnOneGamesMap:Map = new Map();
       
      
      public function VERSION()
      {
         super();
      }
      
      public static function get version() : String
      {
         return SERVER_VERSION + "." + CLIENT_VERSION + "." + MAIN_VERSION;
      }
      
      public static function setVersion(param1:XML) : *
      {
         MAIN_VERSION = int(param1.main_version);
         PRELOADERS_VERSION = int(param1.preloaders);
         HOUSE_VERSION = int(param1.house);
         POPUPS_VERSION = int(param1.popups);
         RANDOM_EVENTS_VERSION = int(param1.random_events);
         QUEST_IMAGES_VERSION = int(param1.quest_images);
         MAP_VERSION = int(param1.map);
         ANIMALS_VERSION = int(param1.animals);
         NPCS_VERSION = int(param1.npcs);
         SOUNDS_VERSION = int(param1.sound);
         TEXT_VERSION = int(param1.text);
         HELP_POPUPS_VERSION = int(param1.help_popups);
         IN_WORLD_GAMES_VERSION = int(param1.in_world_games);
         PREMIUM_CLIP_VERSION = int(param1.premium_clip_version);
         LOGIN_VERSION = int(param1.login_version);
         COMMUNITY_EVENT_VERSION = int(param1.community_event);
         EMOTICONS_VERSION = int(param1.emoticons);
         RECYCLE_BINS_VERSION = int(param1.recycle_bins);
         RECYCLE_ITEMS_VERSION = int(param1.recycle_items);
         SECURITY_FORM_VERSION = int(param1.security_form);
         LOGIN_BANNERS_VERSION = int(param1.login_banner_version);
         CARDS_VERSION = int(param1.cards);
         POTIONS_VERSION = int(param1.potions);
         COMMUNITY_GENDER_CHALLENGE = int(param1.community_gender_challenge);
         CREDITS_STORE_VERSION = int(param1.credits_store);
         HELPER_VERSION = int(param1.helper);
         DAYS_PLAYED_REWARD = int(param1.days_played_reward);
         BANNER_LOGICS = int(param1.banner_logics);
         COLORS = int(param1.colors);
         MOODS = int(param1.player_mood);
         ICONS = int(param1.icons);
         MULTI_PLAYER_TASKS = int(param1.multiplayer_tasks);
         ROOMS_VERSION = int(param1.rooms.attribute("version"));
         ZONES_VERSION = int(param1.zones.attribute("version"));
         ITEMS_IMAGE_VERSION = int(param1.items_images.attribute("version"));
         SINGLE_PLAYER_GAMES_VERSION = int(param1.single_player_games.attribute("version"));
         ONE_ON_ONE_GAMES_VERSION = int(param1.one_on_one_games.attribute("version"));
         ANIMAL_GAMES_VERSION = int(param1.animal_games.attribute("version"));
         updateMap(roomsMap,param1.rooms);
         updateMap(zonesMap,param1.zones);
         updateMap(itemsMap,param1.items);
         updateMap(singlePlayerGamesMap,param1.single_player_games);
         updateMap(oneOnOneGamesMap,param1.one_on_one_games);
         updateMap(animalGamesMap,param1.animal_games);
         updateStaticData(param1.STATIC_DATA);
      }
      
      private static function updateStaticData(param1:XMLList) : void
      {
         var _loc4_:* = undefined;
         var _loc2_:* = param1.children().length();
         var _loc3_:* = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.child(_loc3_);
            staticDataMap.put(int(_loc4_.attribute("id")),int(_loc4_.attribute("version")));
            _loc3_++;
         }
      }
      
      private static function updateMap(param1:Map, param2:*) : *
      {
         var _loc5_:* = undefined;
         var _loc3_:* = param2.children().length();
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param2.child(_loc4_);
            param1.put(int(_loc5_.attribute("id")),int(_loc5_.attribute("version")));
            _loc4_++;
         }
      }
      
      public static function getStaticDataVersion(param1:int) : *
      {
         return staticDataMap.get(param1);
      }
      
      public static function roomVersion(param1:int, param2:int) : String
      {
         return ZONES_VERSION + "." + ROOMS_VERSION + "." + roomsMap.get(param1);
      }
      
      public static function itemVersion(param1:int) : String
      {
         return ITEMS_IMAGE_VERSION + "." + itemsMap.get(param1);
      }
      
      public static function singlePlayerGameVersion(param1:int) : String
      {
         return SINGLE_PLAYER_GAMES_VERSION + "." + singlePlayerGamesMap.get(param1);
      }
      
      public static function oneOnOneGameVersion(param1:int) : String
      {
         return ONE_ON_ONE_GAMES_VERSION + "." + oneOnOneGamesMap.get(param1);
      }
      
      public static function animalGameVersion(param1:int) : String
      {
         return ANIMAL_GAMES_VERSION + "." + animalGamesMap.get(param1);
      }
   }
}
