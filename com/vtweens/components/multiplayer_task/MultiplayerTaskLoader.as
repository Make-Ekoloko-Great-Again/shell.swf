package com.vtweens.components.multiplayer_task
{
   import com.vtweens.consts.VERSION;
   import com.vtweens.util.Map;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class MultiplayerTaskLoader extends EventDispatcher
   {
      
      public static const LOADME = 0;
       
      
      private var mcLoader:Loader;
      
      private var xmlLoader:URLLoader;
      
      private var taskMC = null;
      
      private var configXml = null;
      
      private var clipLoaded;
      
      private var configXMLLoaded;
      
      private var _chatVisible;
      
      private var _chatFadeTime;
      
      private var _chatMinLines;
      
      private var clip;
      
      private var taskData;
      
      private var resourcesMap:Map;
      
      private var loader2Id:Map;
      
      private var loadedResourcesCount = 0;
      
      public function MultiplayerTaskLoader(param1:*)
      {
         this.mcLoader = new Loader();
         this.xmlLoader = new URLLoader();
         this.clip = new MovieClip();
         this.resourcesMap = new Map();
         this.loader2Id = new Map();
         super();
         this.taskData = param1;
         this.loadData();
      }
      
      public function get xml() : *
      {
         return this.configXml;
      }
      
      public function get taskClip() : *
      {
         return this.taskMC;
      }
      
      public function terminate() : *
      {
         if(this.mcLoader)
         {
            this.mcLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onMCLoaded);
            this.mcLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onMCLoadError);
            this.mcLoader = null;
         }
         if(this.xmlLoader)
         {
            this.xmlLoader.removeEventListener(Event.COMPLETE,this.onXMLLoaded);
            this.xmlLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.onXMLLoadError);
            this.xmlLoader = null;
         }
         this.configXml = null;
         this.taskMC = null;
         this.taskData = null;
         this.loader2Id = null;
         this.resourcesMap = null;
         this.clip = null;
      }
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         super.addEventListener(param1,param2,param3,param4,param5);
         if(param1 == Event.COMPLETE)
         {
            this.checkLoadCompleted();
         }
      }
      
      private function getSwfURL() : String
      {
         return "./mp_tasks/swfs/" + this.taskData.swfUrl + ".swf" + "?r=" + VERSION.MULTI_PLAYER_TASKS;
      }
      
      private function getXmlURL() : String
      {
         return "./mp_tasks/xmls/" + this.taskData.id + ".xml" + "?r=" + VERSION.MULTI_PLAYER_TASKS;
      }
      
      public function get resources() : Map
      {
         return this.resourcesMap;
      }
      
      public function get chatVisible() : *
      {
         return this._chatVisible;
      }
      
      public function get chatFadeTime() : *
      {
         return this._chatFadeTime;
      }
      
      public function get chatMinLines() : *
      {
         return this._chatMinLines;
      }
      
      private function parseXMLLoadData() : *
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:URLRequest = null;
         var _loc1_:XML = XML(this.configXml);
         var _loc2_:* = _loc1_.loadData.children().length();
         var _loc3_:* = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = (_loc4_ = _loc1_.loadData.child(_loc3_)).attribute("type");
            _loc6_ = String(_loc4_.attribute("id"));
            _loc7_ = _loc4_.attribute("path");
            _loc9_ = new URLRequest(_loc7_);
            if(_loc5_ == "swf")
            {
               (_loc8_ = new Loader()).contentLoaderInfo.addEventListener(Event.COMPLETE,this.resourceSwfLoadCompleted);
               this.clip.addChild(_loc8_);
            }
            else
            {
               (_loc8_ = new URLLoader()).addEventListener(Event.COMPLETE,this.resourceOtherLoadCompleted);
            }
            this.loader2Id.put(_loc8_,_loc6_);
            _loc8_.load(_loc9_);
            _loc3_++;
         }
         if(int(_loc1_.chat.attribute("minLines")) > 0)
         {
            this._chatVisible = true;
            this._chatFadeTime = int(_loc1_.chat.attribute("fadeDelay"));
            this._chatMinLines = int(_loc1_.chat.attribute("minLines"));
         }
         else
         {
            this._chatVisible = false;
            this._chatFadeTime = 0;
            this._chatMinLines = 0;
         }
      }
      
      private function resourceOtherLoadCompleted(param1:Event) : void
      {
         var _loc2_:* = param1.target;
         _loc2_.removeEventListener(Event.COMPLETE,this.onMCLoaded);
         var _loc3_:* = this.loader2Id.get(_loc2_);
         this.resourcesMap.put(_loc3_,_loc2_.data);
         ++this.loadedResourcesCount;
         this.checkLoadCompleted();
      }
      
      private function resourceSwfLoadCompleted(param1:Event) : void
      {
         var _loc2_:* = param1.target.loader;
         _loc2_.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onMCLoaded);
         var _loc3_:* = this.loader2Id.get(_loc2_);
         this.resourcesMap.put(_loc3_,_loc2_.content);
         ++this.loadedResourcesCount;
         this.checkLoadCompleted();
      }
      
      private function loadData() : *
      {
         var _loc1_:URLRequest = new URLRequest(this.getSwfURL());
         this.mcLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onMCLoaded);
         this.mcLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onMCLoadError);
         this.mcLoader.load(_loc1_);
         _loc1_ = new URLRequest(this.getXmlURL());
         this.xmlLoader.addEventListener(Event.COMPLETE,this.onXMLLoaded);
         this.xmlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onXMLLoadError);
         this.xmlLoader.load(_loc1_);
      }
      
      private function onMCLoaded(param1:*) : *
      {
         this.taskMC = this.mcLoader.content;
         this.mcLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onMCLoaded);
         this.mcLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onMCLoadError);
         this.mcLoader = null;
         this.checkLoadCompleted();
      }
      
      private function onMCLoadError(param1:*) : *
      {
         this.mcLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onMCLoaded);
         this.mcLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onMCLoadError);
         this.mcLoader = null;
         throw new UninitializedError("Could not load task [" + this.taskData.id + "] clip");
      }
      
      private function onXMLLoaded(param1:*) : *
      {
         this.configXml = this.xmlLoader.data;
         this.xmlLoader.removeEventListener(Event.COMPLETE,this.onXMLLoaded);
         this.xmlLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.onXMLLoadError);
         this.xmlLoader = null;
         this.parseXMLLoadData();
      }
      
      private function checkLoadCompleted() : void
      {
         if(this.taskMC != null && this.loader2Id.size() == this.loadedResourcesCount)
         {
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      private function onXMLLoadError(param1:*) : *
      {
         this.xmlLoader.removeEventListener(Event.COMPLETE,this.onXMLLoaded);
         this.xmlLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.onXMLLoadError);
         this.xmlLoader = null;
         throw new UninitializedError("Could not load task [" + this.taskData.id + "] xml");
      }
   }
}
