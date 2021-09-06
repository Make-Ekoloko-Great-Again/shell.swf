package com.vtweens.shell
{
   import com.adobe.crypto.MD5;
   import com.vtweens.components.ads.AdsPlayerController;
   import com.vtweens.components.ads.ShellAdsPlayer;
   import com.vtweens.components.audit.AuditController;
   import com.vtweens.components.facebook.FacebookEventDispatcher;
   import com.vtweens.components.loading_page.LoadingPage;
   import com.vtweens.components.multiplayer_task.MultiplayerTaskLoader;
   import com.vtweens.components.multiplayer_task.game.MPTaskGameAPI;
   import com.vtweens.components.multiplayer_task.game.MPTaskPlayer;
   import com.vtweens.components.website.WebsiteRequestParams;
   import com.vtweens.components.website.activation.login.LoginEvent;
   import com.vtweens.consts.COMMANDS;
   import com.vtweens.consts.GENERAL_STR_KEYS;
   import com.vtweens.consts.HOUSE_GENERAL_STR_KEYS;
   import com.vtweens.consts.VERSION;
   import com.vtweens.dataobjects.player.BasePlayer;
   import com.vtweens.dataobjects.throwing.ThrowingGameAPI;
   import com.vtweens.util.ClipLoader;
   import com.vtweens.util.DisplayObjectContainerUtils;
   import com.vtweens.util.HtmlNavigation;
   import com.vtweens.util.Log;
   import com.vtweens.util.Map;
   import com.vtweens.util.SwitchToLoginTimer;
   import fl.video.FLVPlayback;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.external.ExternalInterface;
   import flash.net.SharedObject;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import it.gotoandplay.smartfoxserver.SFSEvent;
   import it.gotoandplay.smartfoxserver.SmartFoxClient;
   
   public class Shell extends MovieClip
   {
       
      
      public var adsPlayerBG:MovieClip;
      
      public var videoAdsPlayer:FLVPlayback;
      
      private var selectedChannelData;
      
      private var smartFox:SmartFoxClient;
      
      private var main = null;
      
      private var loginSwf = null;
      
      private var serverSelector = null;
      
      private var mainLoader:Loader;
      
      private var loginSwfLoader:Loader;
      
      private var serverSelectorLoader:Loader;
      
      private var filesVersionLoader:URLLoader;
      
      private var friendRequestParam = null;
      
      private var refCodeRequestParam = null;
      
      private var requestParams:WebsiteRequestParams;
      
      private var username;
      
      private var password;
      
      private var language:String;
      
      private var isMod:Boolean;
      
      private var isRanger:Boolean;
      
      private var isNewbie:Boolean;
      
      private var serverConfig:ServerConfig;
      
      private var userSettings:UserSettings;
      
      private var loadingPage:LoadingPage;
      
      private var adsController:AdsPlayerController;
      
      var localData:SharedObject;
      
      private var registration;
      
      private var registrationLoader:Loader;
      
      private var loginObject = null;
      
      private var reloginUrl = null;
      
      public function Shell()
      {
         super();
         this.loadingPage = new LoadingPage();
         this.requestParams = new WebsiteRequestParams(LoaderInfo(this.root.loaderInfo));
         this.loadClasses();
         this.loadServerConfig();
         addChild(this.loadingPage);
         stage.showDefaultContextMenu = true;
         this.adsController = AdsPlayerController.instance;
         ShellAdsPlayer.instance.init(this.videoAdsPlayer,this.adsPlayerBG,".");
         ExternalInterface.addCallback("removeAd",ShellAdsPlayer.instance.removeAd);
         this.__setProp_videoAdsPlayer_Scene1_Layer2_0();
      }
      
      private function loadClasses() : void
      {
         GENERAL_STR_KEYS.ekoloko;
         HOUSE_GENERAL_STR_KEYS.ekoloko;
         BasePlayer.DESTINATION_REACHED;
         new ClipLoader();
         ThrowingGameAPI.loadme;
         SwitchToLoginTimer.LOADME;
         AuditController.instance;
         MPTaskGameAPI.LOAEDME;
         MPTaskPlayer.LOADME;
         MultiplayerTaskLoader.LOADME;
      }
      
      private function loadServerConfig() : void
      {
         this.serverConfig = new ServerConfig();
         this.serverConfig.addEventListener(ServerConfig.DATA_LOADED,this.onServerConfigLoaded);
      }
      
      private function onServerConfigLoaded(param1:Event) : void
      {
         var _loc2_:* = undefined;
         this.language = this.serverConfig.defaultLanguage;
         if(this.serverConfig.mayChangeLaguage)
         {
            for each(_loc2_ in this.serverConfig.availableLanguages)
            {
               if(this.requestParams.language == _loc2_)
               {
                  this.language = this.requestParams.language;
               }
            }
         }
         this.loadingPage.load(this.language);
         this.loadLogin();
      }
      
      private function loadFilesVersion() : *
      {
         this.filesVersionLoader = new URLLoader();
         var _loc1_:URLRequest = new URLRequest("./conf/files_version.xml?r=" + Math.random());
         this.filesVersionLoader.addEventListener(Event.COMPLETE,this.onFilesVersionLoaded);
         this.filesVersionLoader.load(_loc1_);
      }
      
      private function onFilesVersionLoaded(param1:Event) : void
      {
         this.filesVersionLoader.removeEventListener(Event.COMPLETE,this.onFilesVersionLoaded);
         VERSION.setVersion(XML(this.filesVersionLoader.data));
         StaticDataLoader.AddEventListener(Event.COMPLETE,this.onStaticDataLoaded);
         StaticDataLoader.Load(this.serverConfig);
      }
      
      private function onStaticDataLoaded(param1:Event) : void
      {
         this.loadLogin();
      }
      
      private function loadLogin() : *
      {
         if(this.requestParams.isReg)
         {
            this.loadRegistration();
         }
         else if(this.getLocalData().data.directLoginNextTime != null && this.getLocalData().data.directLoginNextTime)
         {
            this.username = this.getLocalData().data.username;
            this.password = this.getLocalData().data.password;
            this.directServerSelection();
         }
         else
         {
            this.loadLoginSwf(null);
         }
         this.getLocalData().setProperty("directLoginNextTime",false);
         this.getLocalData().setProperty("username",null);
         this.getLocalData().setProperty("password",null);
      }
      
      public function setSFSData(param1:*) : *
      {
         Log.info("setSFSData");
         this.selectedChannelData = param1;
         this.loadingPage.showLoadingPage();
         removeChild(this.serverSelector);
         DisplayObjectContainerUtils.stopAndRemoveHierarchy(this.serverSelector);
         this.serverSelector = null;
         this.setSmartFoxClient();
      }
      
      public function get sfClient() : *
      {
         return this.smartFox;
      }
      
      private function loadLoginSwf(param1:Event) : *
      {
         Log.info("loadLoginSwf");
         this.serverConfig.removeEventListener(ServerConfig.DATA_LOADED,this.loadLoginSwf);
         this.loginSwfLoader = new Loader();
         this.loginSwfLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoginSwfLoaded);
         var _loc2_:URLRequest = new URLRequest("./website/" + this.language + "/login_" + this.language + ".swf?version=" + VERSION.LOGIN_VERSION);
         this.loginSwfLoader.load(_loc2_);
      }
      
      private function onLoginSwfLoaded(param1:Event) : void
      {
         Log.info("onLoginSwfLoaded");
         this.loginSwfLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoginSwfLoaded);
         this.loginSwf = param1.target.content;
         this.loginSwf.setCaller(this);
         this.loginSwf.setServerConfig(this.serverConfig);
         this.loginSwf.init(this.language,this.requestParams);
         this.loginSwfLoader = null;
         addChild(this.loginSwf);
      }
      
      public function loginOK(param1:String, param2:String, param3:*) : *
      {
         Log.info("loginOK");
         this.username = param1;
         this.password = param2;
         this.isMod = param3.type == LoginEvent.LOGIN_OK_MOD;
         this.isNewbie = param3.type == LoginEvent.LOGIN_OK_NEWBIE;
         this.isRanger = param3.type == LoginEvent.LOGIN_OK_RANGER;
         this.loadingPage.showLoadingPage();
         this.loginSwf.deactivate();
         removeChild(this.loginSwf);
         DisplayObjectContainerUtils.stopAndRemoveHierarchy(this.loginSwf);
         this.loginSwf = null;
         FacebookEventDispatcher.setConfig(this.serverConfig,param1);
         this.userSettings = new UserSettings(this.serverConfig,param1,param2);
         this.userSettings.addEventListener(Event.COMPLETE,this.userSettingsLoaded);
      }
      
      public function loadRegistration() : *
      {
         Log.info("loadRegistration");
         this.registrationLoader = new Loader();
         this.registrationLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onRegistrationLoaded,false,0,true);
         var _loc1_:URLRequest = new URLRequest("./website/common/register/registration.swf?language=" + this.language + "&refCode=" + this.requestParams.refCode + "&advisor=" + this.requestParams.advisor + "&friend=" + this.requestParams.friend + "&version=" + VERSION.version);
         this.registrationLoader.load(_loc1_);
      }
      
      private function onRegistrationLoaded(param1:Event) : void
      {
         Log.info("onRegistrationLoaded");
         this.registrationLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onRegistrationLoaded);
         this.registration = param1.target.content;
         this.registrationLoader = null;
         addChild(this.registration);
      }
      
      private function getLocalData() : SharedObject
      {
         if(!this.localData)
         {
            this.localData = SharedObject.getLocal("shellData");
         }
         return this.localData;
      }
      
      public function registrationOK(param1:String, param2:String, param3:* = null, param4:Map = null) : *
      {
         var _loc5_:* = undefined;
         Log.info("regCompleted");
         this.getLocalData().setProperty("directLoginNextTime",true);
         this.getLocalData().setProperty("username",param1);
         this.getLocalData().setProperty("password",param2);
         if(!param3)
         {
            param3 = this.serverConfig.getReloginUrl() + "?language=" + this.language + "&friend=" + this.requestParams.friend + "&refCode=" + this.requestParams.refCode + "&username=" + param1;
         }
         else
         {
            param3 = param3 + "?language=" + this.language + "&friend=" + this.requestParams.friend + "&refCode=" + this.requestParams.refCode + "&username=" + param1;
            if(param4)
            {
               for each(_loc5_ in param4.getKeys())
               {
                  param3 += "&" + _loc5_ + "=" + param4.get(_loc5_);
               }
            }
         }
         HtmlNavigation.replaceURL(param3);
      }
      
      public function directServerSelection() : *
      {
         Log.info("directServerSelection");
         this.isMod = false;
         this.isNewbie = true;
         this.isRanger = false;
         this.loadingPage.showLoadingPage();
         FacebookEventDispatcher.setConfig(this.serverConfig,this.username);
         this.userSettings = new UserSettings(this.serverConfig,this.username,this.password);
         this.userSettings.addEventListener(Event.COMPLETE,this.loadServerSelectorDirectly);
      }
      
      private function userSettingsLoaded(param1:Event) : void
      {
         this.loadServerSelector(false);
         this.adsController.setPremium(this.userSettings.isPremium);
         this.showHideAds(!this.userSettings.isPremium);
      }
      
      private function showHideAds(param1:Boolean) : *
      {
         HtmlNavigation.execJavascript("setAdds(" + (!!param1 ? 1 : 0) + ");");
      }
      
      private function loadServerSelectorDirectly(param1:Event) : void
      {
         this.loadServerSelector(true);
      }
      
      public function getLanguage() : *
      {
         return this.language;
      }
      
      public function loggedIn(param1:*) : *
      {
         Log.info("loggedIn");
         this.loginObject = param1;
         this.smartFox.removeEventListener(SFSEvent.onConnection,this.onConnection);
         this.smartFox.removeEventListener(SFSEvent.onExtensionResponse,this.onExtensionResponse);
         if(int(param1[COMMANDS.V_IS_IN_DOWNTIME]) > 0)
         {
            this.isInDowntime();
            return;
         }
         if(param1[COMMANDS.V_VERSION] != VERSION.SERVER_VERSION)
         {
            this.versionMismatch();
            return;
         }
         if(this.main != null)
         {
            this.initMain();
         }
      }
      
      private function loadMain() : *
      {
         Log.info("loadMain");
         this.mainLoader = new Loader();
         this.mainLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onMainLoaded,false,0,true);
         this.mainLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onMainLoadError,false,0,true);
         var _loc1_:URLRequest = new URLRequest("./main.swf?version=" + VERSION.version);
         this.mainLoader.load(_loc1_);
      }
      
      private function onMainLoadError(param1:*) : *
      {
         this.mainLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onMainLoaded);
         this.mainLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onMainLoadError);
      }
      
      private function onMainLoaded(param1:Event) : *
      {
         Log.info("onMainLoaded");
         this.mainLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onMainLoaded);
         this.mainLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onMainLoadError);
         this.main = param1.target.content;
         this.mainLoader = null;
         if(this.loginObject != null)
         {
            this.initMain();
         }
      }
      
      private function initMain() : *
      {
         Log.info("initMain");
         this.main.setSmartFoxClient(this.smartFox);
         this.main.loggedIn(this.loginObject,this.language,this.selectedChannelData.channelName,this.serverConfig,this.loadingPage,this.userSettings);
         addChild(this.main);
         if(this.loginSwf && this.loginSwf.parent)
         {
            this.loginSwf.parent(removeChild(this.loginSwfLoader));
         }
         if(this.serverSelector && this.serverSelector.parent)
         {
            this.serverSelector.parent(removeChild(this.serverSelector));
         }
         this.selectedChannelData = null;
         this.loginSwf = null;
         this.serverSelector = null;
         this.mainLoader = null;
         this.loginSwfLoader = null;
         this.serverSelectorLoader = null;
         this.filesVersionLoader = null;
      }
      
      public function versionMismatch() : *
      {
         var _loc1_:URLRequest = new URLRequest("./version_errors/version_error_" + this.language + ".html");
         navigateToURL(_loc1_,"_top");
      }
      
      public function isInDowntime() : *
      {
         var _loc1_:URLRequest = new URLRequest("./website/" + this.language + "/downtime.html");
         navigateToURL(_loc1_,"_top");
      }
      
      private function setSmartFoxClient() : *
      {
         Log.info("setSmartFoxClient");
         this.smartFox = new SmartFoxClient(Log.SFS_DEBUG);
         this.smartFox.blueBoxIpAddress = this.selectedChannelData.serverData.getBBIp();
         this.smartFox.blueBoxPort = this.selectedChannelData.serverData.getBBPort();
         this.smartFox.addEventListener(SFSEvent.onConnection,this.onConnection);
         this.smartFox.addEventListener(SFSEvent.onExtensionResponse,this.onExtensionResponse);
         this.smartFox.addEventListener(SFSEvent.onRandomKey,this.onRandomKey);
         this.connect(this.selectedChannelData.serverData.getIp(),this.selectedChannelData.serverData.getPort());
      }
      
      private function connect(param1:*, param2:*) : void
      {
         Log.info("Connecting to server ...");
         this.smartFox.connect(param1,param2);
         this.loadMain();
      }
      
      private function onConnection(param1:SFSEvent) : void
      {
         if(param1.params.success)
         {
            Log.info("Connected to server");
            this.smartFox.getRandomKey();
         }
         else
         {
            Log.info("Connection to server failed");
         }
      }
      
      private function onRandomKey(param1:SFSEvent) : *
      {
         Log.info("Got random key");
         this.smartFox.login(this.selectedChannelData.channelName,this.username,MD5.hash(param1.params.key + this.password));
         this.password = null;
      }
      
      private function onExtensionResponse(param1:SFSEvent) : void
      {
         var _loc2_:* = param1.params.dataObj;
         switch(_loc2_[COMMANDS.V_COMMAND])
         {
            case COMMANDS.S_LOGIN_ERROR:
               Log.info("loging error:" + _loc2_[COMMANDS.V_ERROR]);
               break;
            case COMMANDS.S_LOGIN_OK:
               Log.info("logged in");
               this.loggedIn(_loc2_);
         }
      }
      
      private function loadServerSelector(param1:Boolean = false) : *
      {
         Log.info("loadServerSelector");
         this.serverSelectorLoader = new Loader();
         this.serverSelectorLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onServerSelectorLoaded,false,0,true);
         var _loc2_:URLRequest = new URLRequest("./website/common/server_selector/serverSelector.swf?firstTime=" + (!!param1 ? 1 : 0) + "&version=" + VERSION.version);
         this.serverSelectorLoader.load(_loc2_);
      }
      
      private function onServerSelectorLoaded(param1:Event) : void
      {
         Log.info("onServerSelectorLoaded");
         this.serverSelectorLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onServerSelectorLoaded);
         this.serverSelector = param1.target.content;
         this.serverSelector.addEventListener("data_loaded",this.onServersDataLoaded);
         this.serverSelector.init(this,this.userSettings.username,this.userSettings.isPremium,this.isMod,this.isNewbie,this.isRanger);
         this.serverSelectorLoader = null;
      }
      
      private function onServersDataLoaded(param1:Event) : void
      {
         Log.info("onServersDataLoaded");
         this.serverSelector.removeEventListener("data_loaded",this.onServersDataLoaded);
         addChild(this.serverSelector);
         HtmlNavigation.execJavascript("hideFooter()");
      }
      
      function __setProp_videoAdsPlayer_Scene1_Layer2_0() : *
      {
         try
         {
            this.videoAdsPlayer["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.videoAdsPlayer.align = "center";
         this.videoAdsPlayer.autoPlay = true;
         this.videoAdsPlayer.isLive = false;
         this.videoAdsPlayer.scaleMode = "noScale";
         this.videoAdsPlayer.skin = "MinimaFlatCustomColorPlayBackSeekCounterVolMute.swf";
         this.videoAdsPlayer.skinAutoHide = false;
         this.videoAdsPlayer.skinBackgroundAlpha = 0.85;
         this.videoAdsPlayer.skinBackgroundColor = 6710886;
         this.videoAdsPlayer.source = "";
         this.videoAdsPlayer.volume = 2.5;
         try
         {
            this.videoAdsPlayer["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
