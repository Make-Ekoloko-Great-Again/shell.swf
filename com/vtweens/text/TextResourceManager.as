package com.vtweens.text
{
   import com.adobe.serialization.json.JSONDecoder;
   import com.vtweens.consts.VERSION;
   import com.vtweens.shell.ServerConfig;
   import com.vtweens.util.LanguageDef;
   import com.vtweens.util.Log;
   import com.vtweens.util.Map;
   import fl.data.DataProvider;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class TextResourceManager extends EventDispatcher
   {
      
      private static const QUEST = 0;
      
      private static const ITEM = 1;
      
      private static const NPC = 2;
      
      private static const GAME = 3;
      
      private static const ROOM = 4;
      
      private static const RECYCLE_ITEM = 5;
      
      private static const GENERAL = 6;
      
      private static const STAGES = 7;
      
      private static const POKES = 8;
      
      private static const STORES = 9;
      
      private static const SNITCHES = 10;
      
      private static const SUPPORTS = 11;
      
      private static const COMMUNITY_EVENT = 12;
      
      private static const CE_TARGET = 13;
      
      private static const ZONE = 14;
      
      private static const RANGER_WARN = 15;
      
      private static const RANGER_GAME = 16;
      
      private static const ANIMALS = 17;
      
      private static const ANIMAL_FOOD = 18;
      
      private static const ANIMAL_TYPES = 19;
      
      private static const ANIMAL_LEVELS = 20;
      
      private static const ANIMAL_FIRST_NAMES = 21;
      
      private static const ANIMAL_LAST_NAMES = 22;
      
      private static const ANIMAL_STORES = 23;
      
      private static const ANIMAL_AGES = 24;
      
      private static const ANIMAL_GAMES = 25;
      
      private static const CHAT_BLOCK_REASONS = 26;
      
      private static const NPC_QUEST_REMINDERS = 27;
      
      private static const DONATION_CAMPAPIGNS = 28;
      
      private static const DONATION_CAMPAPIGN_TARGETS = 29;
      
      private static const SENIORITY_LEVELS = 30;
      
      private static const FACEBOOK_EVENTS = 31;
      
      private static const ZONE_EXTRA_TEXT = 32;
      
      private static const FACEBOOK_CONFIRM_TEXT = 33;
      
      private static const AFFILIATES = 34;
      
      private static const RANDOM_EVENTS_TYPE = 35;
      
      private static const TELEPORT_EVENTS_START = 36;
      
      private static const TELEPORT_EVENTS_END = 37;
      
      private static const HOUSE_TYPES = 38;
      
      private static const HOUSE_ITEMS = 39;
      
      private static const HOUSE_GENERAL = 40;
      
      private static const HOUSE_PLANET_NAMES_1 = 41;
      
      private static const HOUSE_PLANET_NAMES_2 = 42;
      
      private static const HOUSE_PLANET_NAMES_3 = 43;
      
      private static const PLANTS = 44;
      
      private static const QUEST_GROUPS = 45;
      
      private static const QUEST_SUB_GROUPS = 46;
      
      private static const CARDS = 47;
      
      private static const CARD_ALBUMS = 48;
      
      private static const CARD_SETS = 49;
      
      private static const CARD_SERIES = 50;
      
      private static const CREDITS_STORE_INSTANCES = 51;
      
      private static const CREDITS_STORE_DISCOUNTS = 52;
      
      private static const CREDITS_STORE_CATEGORIES = 53;
      
      private static const POTIONS = 54;
      
      private static const POTIONS_STORES = 55;
      
      private static const MULTIPLAYER_TASK = 56;
      
      private static const MOBILE_GAMES = 57;
      
      private static const RANGER_ZONE = 58;
      
      private static var resourceUrls:Array = ["listQuests","listItems","listNpcs","listGames","listRooms","listRecycleItems","listGeneral","listQuestStages","listPokes","listStores","listSnitches","listSupportSubjects","listCommunityEvents","listCETargets","listZones","listRangerWarningMessages","listRangerGameMessages","listAnimals","listAnimalFood","listAnimalTypes","listAnimalLevels","listAnimalFirstNames","listAnimalLastNames","listAnimalStores","listAnimalAges","listAnimalGames","listBlockChatReasons","listNpcQuestReminders","listDonationCampaigns","listDonationCampaignTargets","listSeniorityLevels","listFacebookEvents","listZonesMapText","listFacebookConfirmTexts","listAffiliates","listRandomEvents","listTeleportEventsStart","listTeleportEventsEnd","listHouseTypes","listHouseItems","listHouseGeneral","listHousePlanetNames1","listHousePlanetNames2","listHousePlanetNames3","listPlants","listQuestGroups","listQuestSubGroups","listCards","listCardAlbums","listCardSets","listCardSeries","listCreditsStoreProductInstance","listCreditsStoreDiscouts","listCreditsStoreCategories","listPotions","listPotionsStores","listMultiplayerTasks","listMobileGames","listRangerZoneMessages"];
      
      private static var resourceDataMaps:Array = new Array();
      
      private static var loaders:Array = new Array();
      
      private static var en_resourceDataMaps:Array = new Array();
      
      private static var en_loaders:Array = new Array();
      
      private static var en_resourceUrls:Array = [0,1,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
      
      private static var en_resource_count = 0;
      
      private static var loadedStuff = 0;
      
      private static var language:String;
      
      private static var singleton:TextResourceManager = new TextResourceManager();
      
      public static const DATA_LOADED = "data_loaded";
      
      public static const CE_ID = "0";
      
      public static const CE_NAME = "1";
      
      public static const CE_CLOSURE = "2";
      
      public static const CE_TEXTS = "3";
      
      public static const TARGET_NAME = "1";
      
      public static const ROOM_ID = "0";
      
      public static const ROOM_NAME = "1";
      
      public static const ZONE_NAME = "1";
      
      public static const ZONE_ID = "0";
      
      public static const GENERAL_STRING = "1";
      
      public static const POKES_SEND = "1";
      
      public static const POKES_RECIEVE = "2";
      
      public static const ID = "0";
      
      private static var dp:DataProvider = null;
      
      public static const SEND = "1";
      
      public static const RECIEVE = "2";
      
      private static var rangerWarnDP:DataProvider = null;
      
      private static var rangerGameDP:DataProvider = null;
      
      private static var rangerZoneDP:DataProvider = null;
      
      private static var snitchesdp:DataProvider = null;
      
      private static var chatBlockReasonsDP:DataProvider = null;
      
      private static var supportdp:DataProvider = null;
       
      
      private var items:Map;
      
      public function TextResourceManager()
      {
         this.items = new Map();
         super();
      }
      
      public static function AddEventListener(param1:String, param2:Function) : *
      {
         singleton.addEventListener(param1,param2,false,0,true);
         if(param1 == DATA_LOADED && loadedStuff == resourceUrls.length)
         {
            singleton.dispatchEvent(new Event(DATA_LOADED));
         }
      }
      
      public static function RemoveEventListener(param1:String, param2:Function) : *
      {
         singleton.removeEventListener(param1,param2);
      }
      
      public static function Load(param1:*) : *
      {
         singleton.init(param1);
      }
      
      private static function getUrl(param1:ServerConfig, param2:int, param3:String) : String
      {
         var _loc4_:* = param1.getTextsUrl();
         return param1.getTextsUrl() + resourceUrls[param2] + "_" + param3 + ".action?version=" + VERSION.TEXT_VERSION;
      }
      
      public static function getNPCDataMap(param1:Boolean = false) : Map
      {
         if(param1 && language != LanguageDef.ENGLISH)
         {
            return en_resourceDataMaps[NPC];
         }
         return resourceDataMaps[NPC];
      }
      
      public static function getFacebookEventsDataMap(param1:Boolean = false) : Map
      {
         if(param1 && language != LanguageDef.ENGLISH)
         {
            return en_resourceDataMaps[FACEBOOK_EVENTS];
         }
         return resourceDataMaps[FACEBOOK_EVENTS];
      }
      
      public static function getFacebookConfirmationText(param1:int) : String
      {
         var _loc2_:* = resourceDataMaps[FACEBOOK_CONFIRM_TEXT].get(param1);
         if(_loc2_)
         {
            return _loc2_[2];
         }
         return "-----";
      }
      
      public static function pickRandomEventsTypeData(param1:int) : Object
      {
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:* = undefined;
         var _loc2_:* = resourceDataMaps[RANDOM_EVENTS_TYPE].get(param1);
         if(_loc2_)
         {
            _loc3_ = _loc2_[4];
            _loc4_ = _loc2_[3];
            _loc5_ = int(Math.random() * _loc3_.length);
            return {
               "0":param1,
               "1":_loc3_[_loc5_],
               "2":_loc4_[_loc5_]
            };
         }
         return {
            "0":param1,
            "1":"-------",
            "2":"-------"
         };
      }
      
      public static function getTeleportRandomEventStartData(param1:int) : Object
      {
         var _loc2_:* = resourceDataMaps[TELEPORT_EVENTS_START].get(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         return {
            "0":param1,
            "1":"-------",
            "2":"-------"
         };
      }
      
      public static function getMultiplayerTaskData(param1:int) : Object
      {
         var _loc2_:* = resourceDataMaps[MULTIPLAYER_TASK].get(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         return {
            "0":param1,
            "1":"-------",
            "2":"-------"
         };
      }
      
      public static function getMobileGameData(param1:int) : Object
      {
         var _loc2_:* = resourceDataMaps[MOBILE_GAMES].get(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         return {
            "0":param1,
            "1":"-------"
         };
      }
      
      public static function getTeleportRandomEventEndData(param1:int) : Object
      {
         var _loc2_:* = resourceDataMaps[TELEPORT_EVENTS_END].get(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         return {
            "0":param1,
            "1":"-------",
            "2":"-------"
         };
      }
      
      public static function getPotionData(param1:int) : Object
      {
         var _loc2_:* = resourceDataMaps[POTIONS].get(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         return {
            "0":param1,
            "1":"-------",
            "2":"-------"
         };
      }
      
      public static function getPotionStoreData(param1:int) : Object
      {
         var _loc2_:* = resourceDataMaps[POTIONS_STORES].get(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         return {
            "0":param1,
            "1":"-------",
            "2":"-------"
         };
      }
      
      public static function getCardData(param1:*) : *
      {
         var _loc2_:* = resourceDataMaps[CARDS].get(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         return {
            "0":param1,
            "1":"-----",
            "isEmpty":true
         };
      }
      
      public static function getCardAlbumData(param1:int) : *
      {
         var _loc2_:* = resourceDataMaps[CARD_ALBUMS].get(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         return {
            "0":param1,
            "1":"-----",
            "2":"-----"
         };
      }
      
      public static function getCardSetsData(param1:int) : *
      {
         var _loc2_:* = resourceDataMaps[CARD_SETS].get(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         return {
            "0":param1,
            "1":"-----"
         };
      }
      
      public static function getCardSeriesData(param1:int) : *
      {
         var _loc2_:* = resourceDataMaps[CARD_SERIES].get(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         return {
            "0":param1,
            "1":"-----",
            "2":"-----"
         };
      }
      
      public static function getCreditsStoreInstanceData(param1:int) : *
      {
         var _loc2_:* = resourceDataMaps[CREDITS_STORE_INSTANCES].get(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         return {
            "0":param1,
            "1":"--" + param1 + "--",
            "2":"--" + param1 + "--"
         };
      }
      
      public static function getCreditsStoreCategoryData(param1:int) : *
      {
         var _loc2_:* = resourceDataMaps[CREDITS_STORE_CATEGORIES].get(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         return {
            "0":param1,
            "1":"--" + param1 + "--"
         };
      }
      
      public static function getCreditsStoreDiscountData(param1:int) : *
      {
         var _loc2_:* = resourceDataMaps[CREDITS_STORE_DISCOUNTS].get(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         return {
            "0":param1,
            "1":"--" + param1 + "--",
            "2":"--" + param1 + "--"
         };
      }
      
      public static function getQuestDataMap() : Map
      {
         return resourceDataMaps[QUEST];
      }
      
      public static function getStageDataMap() : Map
      {
         return resourceDataMaps[STAGES];
      }
      
      public static function getQuestData(param1:int) : *
      {
         var _loc2_:* = resourceDataMaps[QUEST].get(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         return {
            "0":param1,
            "1":"-----"
         };
      }
      
      public static function getQuestGroupData(param1:int) : *
      {
         var _loc2_:* = resourceDataMaps[QUEST_GROUPS].get(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         return {
            "0":param1,
            "1":"-----",
            "2":"-----"
         };
      }
      
      public static function getQuestSubGroupData(param1:String) : *
      {
         var _loc2_:* = resourceDataMaps[QUEST_SUB_GROUPS].get(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         return {
            "0":param1,
            "1":"-----",
            "2":"-----"
         };
      }
      
      public static function getAffiliateName(param1:int) : String
      {
         var _loc2_:* = resourceDataMaps[AFFILIATES].get(param1);
         if(_loc2_)
         {
            return _loc2_[1];
         }
         return "-----";
      }
      
      public static function getZoneExtraText(param1:*) : String
      {
         var _loc2_:* = resourceDataMaps[ZONE_EXTRA_TEXT].get(param1);
         if(_loc2_)
         {
            return _loc2_["1"];
         }
         return null;
      }
      
      public static function getStageData(param1:String) : *
      {
         var _loc2_:* = resourceDataMaps[STAGES].get(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         return {
            "0":param1,
            "1":"-----",
            "2":"-----"
         };
      }
      
      public static function getPlantData(param1:int) : Object
      {
         var _loc2_:* = resourceDataMaps[PLANTS].get(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         return {
            "0":param1,
            "1":"-------",
            "2":""
         };
      }
      
      public static function getItemData(param1:int, param2:Boolean = false) : Object
      {
         var _loc3_:* = resourceDataMaps[ITEM].get(param1);
         if(param2 && language != LanguageDef.ENGLISH)
         {
            _loc3_ = en_resourceDataMaps[ITEM].get(param1);
         }
         if(_loc3_)
         {
            return _loc3_;
         }
         return {
            "0":param1,
            "1":"-------",
            "2":""
         };
      }
      
      public static function getHouseItemData(param1:int) : Object
      {
         var _loc2_:* = resourceDataMaps[HOUSE_ITEMS].get(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         return {
            "0":param1,
            "1":"-------",
            "2":""
         };
      }
      
      public static function getHouseTypeData(param1:int) : Object
      {
         var _loc2_:* = resourceDataMaps[HOUSE_TYPES].get(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         return {
            "0":param1,
            "1":"-------",
            "2":"",
            "5":{}
         };
      }
      
      public static function getSeniorityLevelName(param1:int, param2:Boolean = false) : String
      {
         var _loc3_:* = resourceDataMaps[SENIORITY_LEVELS].get(param1);
         if(param2 && language != LanguageDef.ENGLISH)
         {
            _loc3_ = en_resourceDataMaps[SENIORITY_LEVELS].get(param1);
         }
         if(_loc3_)
         {
            return _loc3_["1"];
         }
         return "-------";
      }
      
      public static function getStoreData(param1:int, param2:Boolean = false) : *
      {
         var _loc3_:* = resourceDataMaps[STORES].get(param1);
         if(param2 && language != LanguageDef.ENGLISH)
         {
            _loc3_ = en_resourceDataMaps[STORES].get(param1);
         }
         if(_loc3_)
         {
            return _loc3_;
         }
         return {
            "0":param1,
            "1":"-------",
            "2":""
         };
      }
      
      public static function getRecycleItemData(param1:int) : *
      {
         var _loc2_:* = resourceDataMaps[RECYCLE_ITEM].get(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         return {
            "0":param1,
            "1":"-------",
            "2":""
         };
      }
      
      public static function getNpcData(param1:int) : *
      {
         var _loc2_:* = resourceDataMaps[NPC].get(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         return {
            "0":param1,
            "1":"-------",
            "2":"--------",
            "3":[]
         };
      }
      
      public static function getCommunityEventData(param1:int) : *
      {
         var _loc2_:* = resourceDataMaps[COMMUNITY_EVENT].get(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         return {
            "0":param1,
            "1":"-------",
            "2":"-------",
            "3":[]
         };
      }
      
      public static function getCETargetName(param1:int) : *
      {
         var _loc2_:* = resourceDataMaps[CE_TARGET].get(param1);
         if(_loc2_)
         {
            return _loc2_[TARGET_NAME];
         }
         return "------";
      }
      
      public static function getGameData(param1:int, param2:Boolean = false) : *
      {
         var _loc3_:* = resourceDataMaps[GAME].get(param1);
         if(param2 && language != LanguageDef.ENGLISH)
         {
            _loc3_ = en_resourceDataMaps[GAME].get(param1);
         }
         if(_loc3_)
         {
            return _loc3_;
         }
         return {
            "0":param1,
            "1":"------",
            "2":"------"
         };
      }
      
      public static function getRoomName(param1:int) : String
      {
         var _loc2_:* = resourceDataMaps[ROOM].get(param1);
         if(_loc2_)
         {
            return _loc2_[ROOM_NAME];
         }
         return "";
      }
      
      public static function getRoomsData() : Map
      {
         return resourceDataMaps[ROOM];
      }
      
      public static function getZoneName(param1:int, param2:Boolean = false) : String
      {
         var _loc3_:* = resourceDataMaps[ZONE].get(param1);
         if(param2 && language != LanguageDef.ENGLISH)
         {
            _loc3_ = en_resourceDataMaps[ZONE].get(param1);
         }
         if(_loc3_)
         {
            return _loc3_[ZONE_NAME];
         }
         return "";
      }
      
      public static function getZonesData() : Map
      {
         return resourceDataMaps[ZONE];
      }
      
      public static function getString(param1:String, param2:Array = null) : String
      {
         var _loc3_:String = resourceDataMaps[GENERAL].get(param1);
         if(_loc3_)
         {
            if(param2)
            {
               return replaceValues(_loc3_,param2);
            }
            return _loc3_;
         }
         return param1;
      }
      
      public static function getHouseString(param1:String, param2:Array = null) : String
      {
         var _loc3_:String = resourceDataMaps[HOUSE_GENERAL].get(param1);
         if(_loc3_)
         {
            if(param2)
            {
               return replaceValues(_loc3_,param2);
            }
            return _loc3_;
         }
         return param1;
      }
      
      public static function getHouseName(param1:int) : String
      {
         var _loc2_:* = resourceDataMaps[HOUSE_PLANET_NAMES_1].get(int(param1 / 10000) % resourceDataMaps[HOUSE_PLANET_NAMES_1].size() + 1)[1];
         var _loc3_:* = resourceDataMaps[HOUSE_PLANET_NAMES_2].get(int(int(param1 / 100) % 100) % resourceDataMaps[HOUSE_PLANET_NAMES_2].size() + 1)[1];
         var _loc4_:* = resourceDataMaps[HOUSE_PLANET_NAMES_3].get(int(param1 % 100) % resourceDataMaps[HOUSE_PLANET_NAMES_3].size() + 1)[1];
         return _loc2_ + " " + _loc3_ + " " + _loc4_;
      }
      
      public static function replaceValues(param1:String, param2:Array = null) : String
      {
         var _loc4_:* = undefined;
         if(!param2)
         {
            param2 = [];
         }
         var _loc3_:String = param1;
         if(_loc3_)
         {
            for(_loc4_ in param2)
            {
               _loc3_ = StringUtils.replaceAll(_loc3_,"{" + _loc4_ + "}",param2[_loc4_]);
            }
         }
         return _loc3_;
      }
      
      public static function getNpcPopupMsg(param1:int, param2:Array = null) : String
      {
         var _loc4_:* = undefined;
         if(!param2)
         {
            param2 = [];
         }
         var _loc3_:String = resourceDataMaps[NPC_QUEST_REMINDERS].get(param1)[1];
         if(_loc3_)
         {
            for(_loc4_ in param2)
            {
               _loc3_ = StringUtils.replaceAll(_loc3_,"{" + _loc4_ + "}",param2[_loc4_]);
            }
            return _loc3_;
         }
         return null;
      }
      
      public static function getNpcPopupMsgData() : Map
      {
         return resourceDataMaps[NPC_QUEST_REMINDERS] as Map;
      }
      
      public static function getPokeMap() : Map
      {
         return resourceDataMaps[POKES];
      }
      
      public static function getPokeDP() : DataProvider
      {
         var _loc1_:Map = null;
         var _loc2_:* = undefined;
         if(!dp)
         {
            _loc1_ = TextResourceManager.getPokeMap();
            dp = new DataProvider();
            for each(_loc2_ in _loc1_.getValues())
            {
               dp.addItem({
                  "label":StringUtils.SetPisukHebrewLine(_loc2_[TextResourceManager.POKES_SEND]),
                  "id":_loc2_[TextResourceManager.ID]
               });
            }
         }
         return dp;
      }
      
      public static function getRecievedPoke(param1:int, param2:Array = null) : String
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         if(!param2)
         {
            param2 = [];
         }
         var _loc3_:* = resourceDataMaps[POKES].get(param1);
         if(_loc3_)
         {
            _loc4_ = _loc3_[POKES_RECIEVE];
            for(_loc5_ in param2)
            {
               _loc4_ = _loc4_.replace("{" + _loc5_ + "}",param2[_loc5_]);
            }
            return _loc4_;
         }
         return null;
      }
      
      public static function getRangerWarnMap() : Map
      {
         return resourceDataMaps[RANGER_WARN];
      }
      
      public static function getRangerWarnDP() : DataProvider
      {
         var _loc1_:Map = null;
         var _loc2_:* = undefined;
         if(!rangerWarnDP)
         {
            _loc1_ = getRangerWarnMap();
            rangerWarnDP = new DataProvider();
            for each(_loc2_ in _loc1_.getValues())
            {
               rangerWarnDP.addItem({
                  "label":StringUtils.SetPisukHebrewLine(_loc2_[TextResourceManager.SEND]),
                  "id":_loc2_[TextResourceManager.ID]
               });
            }
         }
         return rangerWarnDP;
      }
      
      public static function getRecievedRangerWarn(param1:int, param2:Array = null) : String
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         if(!param2)
         {
            param2 = [];
         }
         var _loc3_:* = resourceDataMaps[RANGER_WARN].get(param1);
         if(_loc3_)
         {
            _loc4_ = _loc3_[RECIEVE];
            for(_loc5_ in param2)
            {
               _loc4_ = _loc4_.replace("{" + _loc5_ + "}",param2[_loc5_]);
            }
            return _loc4_;
         }
         return null;
      }
      
      public static function getRangerGameMap() : Map
      {
         return resourceDataMaps[RANGER_GAME];
      }
      
      public static function getRangerGameDP() : DataProvider
      {
         var _loc1_:Map = null;
         var _loc2_:* = undefined;
         if(!rangerGameDP)
         {
            _loc1_ = getRangerGameMap();
            rangerGameDP = new DataProvider();
            for each(_loc2_ in _loc1_.getValues())
            {
               rangerGameDP.addItem({
                  "label":StringUtils.SetPisukHebrewLine(_loc2_[TextResourceManager.SEND]),
                  "id":_loc2_[TextResourceManager.ID]
               });
            }
         }
         return rangerGameDP;
      }
      
      public static function getRecievedRangerGame(param1:int, param2:Array = null) : String
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         if(!param2)
         {
            param2 = [];
         }
         var _loc3_:* = resourceDataMaps[RANGER_GAME].get(param1);
         if(_loc3_)
         {
            _loc4_ = _loc3_[RECIEVE];
            for(_loc5_ in param2)
            {
               _loc4_ = _loc4_.replace("{" + _loc5_ + "}",param2[_loc5_]);
            }
            return _loc4_;
         }
         return null;
      }
      
      public static function getRangerZoneMap() : Map
      {
         return resourceDataMaps[RANGER_ZONE];
      }
      
      public static function getRangerZoneDP() : DataProvider
      {
         var _loc1_:Map = null;
         var _loc2_:* = undefined;
         if(!rangerZoneDP)
         {
            _loc1_ = getRangerZoneMap();
            rangerZoneDP = new DataProvider();
            for each(_loc2_ in _loc1_.getValues())
            {
               rangerZoneDP.addItem({
                  "label":StringUtils.SetPisukHebrewLine(_loc2_[TextResourceManager.SEND]),
                  "id":_loc2_[TextResourceManager.ID]
               });
            }
         }
         return rangerZoneDP;
      }
      
      public static function getRecievedRangerZone(param1:int, param2:Array = null) : String
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         if(!param2)
         {
            param2 = [];
         }
         var _loc3_:* = resourceDataMaps[RANGER_ZONE].get(param1);
         if(_loc3_)
         {
            _loc4_ = _loc3_[RECIEVE];
            for(_loc5_ in param2)
            {
               _loc4_ = _loc4_.replace("{" + _loc5_ + "}",param2[_loc5_]);
            }
            return _loc4_;
         }
         return null;
      }
      
      public static function getAnimalData(param1:int, param2:Boolean = false) : Object
      {
         var _loc3_:* = resourceDataMaps[ANIMALS].get(param1);
         if(param2 && language != LanguageDef.ENGLISH)
         {
            _loc3_ = en_resourceDataMaps[ANIMALS].get(param1);
         }
         if(_loc3_)
         {
            return _loc3_;
         }
         return {
            "0":param1,
            "1":"-------",
            "2":""
         };
      }
      
      public static function getAnimalFirstName(param1:int) : *
      {
         if(param1 > resourceDataMaps[ANIMAL_FIRST_NAMES].size())
         {
            param1 = 1 + param1 % resourceDataMaps[ANIMAL_FIRST_NAMES].size();
         }
         var _loc2_:* = resourceDataMaps[ANIMAL_FIRST_NAMES].get(param1);
         if(_loc2_)
         {
            return _loc2_[1];
         }
         return "---";
      }
      
      public static function getAnimalLastName(param1:int) : *
      {
         if(param1 > resourceDataMaps[ANIMAL_LAST_NAMES].size())
         {
            param1 = 1 + param1 % resourceDataMaps[ANIMAL_LAST_NAMES].size();
         }
         var _loc2_:* = resourceDataMaps[ANIMAL_LAST_NAMES].get(param1);
         if(_loc2_)
         {
            return _loc2_[1];
         }
         return "---";
      }
      
      public static function getRandomAnimalName() : *
      {
         var _loc1_:int = resourceDataMaps[ANIMAL_FIRST_NAMES].getKeys()[int(Math.random() * resourceDataMaps[ANIMAL_FIRST_NAMES].size())];
         var _loc2_:int = resourceDataMaps[ANIMAL_LAST_NAMES].getKeys()[int(Math.random() * resourceDataMaps[ANIMAL_LAST_NAMES].size())];
         var _loc3_:* = getAnimalFirstName(_loc1_) + " " + getAnimalLastName(_loc2_);
         return {
            "0":_loc1_,
            "1":_loc2_,
            "2":_loc3_
         };
      }
      
      public static function getAnimalFoodData(param1:int) : *
      {
         var _loc2_:* = resourceDataMaps[ANIMAL_FOOD].get(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         return {
            "0":param1,
            "1":"-------",
            "2":""
         };
      }
      
      public static function getAnimalType(param1:int) : *
      {
         var _loc2_:* = resourceDataMaps[ANIMAL_TYPES].get(param1);
         if(_loc2_)
         {
            return _loc2_[1];
         }
         return "---";
      }
      
      public static function getAnimalGameName(param1:int) : String
      {
         var _loc2_:* = resourceDataMaps[ANIMAL_GAMES].get(param1);
         if(_loc2_)
         {
            return _loc2_[1];
         }
         return "---";
      }
      
      public static function getAnimalLevel(param1:int) : *
      {
         var _loc2_:* = resourceDataMaps[ANIMAL_LEVELS].get(param1);
         if(_loc2_)
         {
            return _loc2_[1];
         }
         return "---";
      }
      
      public static function getAnimalAge(param1:int) : *
      {
         var _loc2_:* = resourceDataMaps[ANIMAL_AGES].get(param1);
         if(_loc2_)
         {
            return _loc2_[1];
         }
         return "---";
      }
      
      public static function getAnimalStoreData(param1:int, param2:Boolean = false) : Object
      {
         var _loc3_:* = resourceDataMaps[ANIMAL_STORES].get(param1);
         if(param2 && language != LanguageDef.ENGLISH)
         {
            _loc3_ = en_resourceDataMaps[ANIMAL_STORES].get(param1);
         }
         if(_loc3_)
         {
            return _loc3_;
         }
         return {
            "0":param1,
            "1":"-------",
            "2":""
         };
      }
      
      public static function getDonationCampaignTarget(param1:int) : *
      {
         var _loc2_:* = resourceDataMaps[DONATION_CAMPAPIGN_TARGETS].get(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         return {
            "0":param1,
            "1":"-------",
            "2":"--------"
         };
      }
      
      public static function getDonationCampaign(param1:int) : *
      {
         var _loc2_:* = resourceDataMaps[DONATION_CAMPAPIGNS].get(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         return {
            "0":param1,
            "1":"-------",
            "2":"--------"
         };
      }
      
      public static function getSnitchMap() : Map
      {
         return resourceDataMaps[SNITCHES];
      }
      
      public static function getSnitchDP() : DataProvider
      {
         var _loc1_:Map = null;
         var _loc2_:* = undefined;
         if(!snitchesdp)
         {
            _loc1_ = TextResourceManager.getSnitchMap();
            snitchesdp = new DataProvider();
            for each(_loc2_ in _loc1_.getValues())
            {
               snitchesdp.addItem({
                  "label":StringUtils.SetPisukHebrewLine(_loc2_[1]),
                  "id":_loc2_[0]
               });
            }
         }
         return snitchesdp;
      }
      
      public static function getChatBlockReasonsMap() : Map
      {
         return resourceDataMaps[CHAT_BLOCK_REASONS];
      }
      
      public static function getChatBlockReasonsDP() : DataProvider
      {
         var _loc1_:Map = null;
         var _loc2_:* = undefined;
         if(!chatBlockReasonsDP)
         {
            _loc1_ = TextResourceManager.getChatBlockReasonsMap();
            chatBlockReasonsDP = new DataProvider();
            for each(_loc2_ in _loc1_.getValues())
            {
               chatBlockReasonsDP.addItem({
                  "label":StringUtils.SetPisukHebrewLine(_loc2_[1]),
                  "id":_loc2_[0]
               });
            }
         }
         return chatBlockReasonsDP;
      }
      
      public static function getSupportSubjectMap() : Map
      {
         return resourceDataMaps[SUPPORTS];
      }
      
      public static function getSupportDP() : DataProvider
      {
         var _loc1_:Map = null;
         var _loc2_:* = undefined;
         if(!supportdp)
         {
            _loc1_ = TextResourceManager.getSupportSubjectMap();
            supportdp = new DataProvider();
            for each(_loc2_ in _loc1_.getValues())
            {
               supportdp.addItem({
                  "label":StringUtils.SetPisukHebrewLine(_loc2_[1]),
                  "id":_loc2_[0]
               });
            }
         }
         return supportdp;
      }
      
      public static function FlipText(param1:String) : String
      {
         var _loc2_:String = null;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:String = null;
         var _loc6_:* = undefined;
         var _loc7_:int = 0;
         if(language == LanguageDef.HEBREW)
         {
            _loc2_ = "";
            _loc3_ = param1.split("#");
            for each(_loc4_ in _loc3_)
            {
               _loc5_ = "";
               _loc7_ = (_loc6_ = _loc4_.length) - 1;
               while(_loc7_ >= 0)
               {
                  _loc5_ += _loc4_.substr(_loc7_,1);
                  _loc7_--;
               }
               _loc2_ += _loc5_ + "\n";
            }
            return _loc2_;
         }
         return param1;
      }
      
      private function init(param1:*) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         language = LanugageControl.language;
         for(_loc2_ in resourceUrls)
         {
            loaders.push(new URLLoader());
            resourceDataMaps.push(new Map());
         }
         for(_loc2_ in resourceUrls)
         {
            _loc3_ = en_resourceUrls[_loc2_] > 0 && language != LanguageDef.ENGLISH ? new URLLoader() : null;
            en_loaders.push(_loc3_);
            en_resourceDataMaps.push(new Map());
         }
         this.loadResources(param1);
      }
      
      private function loadResources(param1:*) : *
      {
         var _loc2_:* = undefined;
         for(_loc2_ in resourceUrls)
         {
            loaders[_loc2_].addEventListener(IOErrorEvent.IO_ERROR,this.onLoadError,false,0,true);
            loaders[_loc2_].addEventListener(Event.COMPLETE,this.onLoad,false,0,true);
            loaders[_loc2_].load(new URLRequest(getUrl(param1,_loc2_,language)));
         }
         for(_loc2_ in resourceUrls)
         {
            if(en_loaders[_loc2_] != null)
            {
               ++en_resource_count;
               en_loaders[_loc2_].addEventListener(IOErrorEvent.IO_ERROR,this.onLoadError,false,0,true);
               en_loaders[_loc2_].addEventListener(Event.COMPLETE,this.onLoad,false,0,true);
               en_loaders[_loc2_].load(new URLRequest(getUrl(param1,_loc2_,LanguageDef.ENGLISH)));
            }
         }
      }
      
      private function onLoad(param1:Event) : *
      {
         var loaderIndx:* = undefined;
         var loader:URLLoader = null;
         var data:* = undefined;
         var e:Event = param1;
         for(loaderIndx in loaders)
         {
            loader = loaders[loaderIndx];
            if(e.target == loader)
            {
               try
               {
                  data = new JSONDecoder(e.target.data).getValue();
                  if(loaderIndx == GENERAL)
                  {
                     this.initGeneral(data);
                  }
                  else if(loaderIndx == HOUSE_GENERAL)
                  {
                     this.initHouseGeneral(data);
                  }
                  else
                  {
                     this.initData(loaders,loaderIndx,data);
                  }
               }
               catch(e:Error)
               {
                  continue;
               }
            }
         }
         for(loaderIndx in en_loaders)
         {
            loader = en_loaders[loaderIndx];
            if(e.target == loader)
            {
               try
               {
                  data = new JSONDecoder(e.target.data).getValue();
                  if(loaderIndx == GENERAL)
                  {
                     this.initGeneral(data);
                  }
                  else
                  {
                     this.initData(en_loaders,loaderIndx,data);
                  }
               }
               catch(e:Error)
               {
                  continue;
               }
            }
         }
         this.loaderFinished();
      }
      
      private function initGeneral(param1:Object) : *
      {
         var _loc3_:* = undefined;
         var _loc2_:Map = Map(resourceDataMaps[GENERAL]);
         for(_loc3_ in param1)
         {
            _loc2_.put(_loc3_.toString(),param1[_loc3_].toString());
         }
      }
      
      private function initHouseGeneral(param1:Object) : *
      {
         var _loc3_:* = undefined;
         var _loc2_:Map = Map(resourceDataMaps[HOUSE_GENERAL]);
         for(_loc3_ in param1)
         {
            _loc2_.put(_loc3_.toString(),param1[_loc3_].toString());
         }
      }
      
      private function initData(param1:Array, param2:int, param3:Array) : *
      {
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc4_:Map = Map(resourceDataMaps[param2]);
         if(param1 == en_loaders)
         {
            _loc4_ = Map(en_resourceDataMaps[param2]);
         }
         for each(_loc5_ in param3)
         {
            _loc6_ = resourceUrls[param2] + ": ";
            for(_loc7_ in _loc5_)
            {
               _loc6_ += _loc7_ + ":" + _loc5_[_loc7_] + " ";
            }
            _loc4_.put(_loc5_[0],_loc5_);
         }
      }
      
      private function onLoadError(param1:IOErrorEvent) : *
      {
         this.loaderFinished();
         Log.error("TextResourcesManager error loading url: " + param1.text);
      }
      
      private function loaderFinished() : *
      {
         ++loadedStuff;
         if(loadedStuff == resourceUrls.length + en_resource_count)
         {
            singleton.dispatchEvent(new Event(DATA_LOADED));
         }
      }
   }
}
