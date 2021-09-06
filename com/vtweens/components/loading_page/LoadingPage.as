package com.vtweens.components.loading_page
{
   import com.vtweens.consts.VERSION;
   import com.vtweens.text.TextFormats;
   import com.vtweens.util.DisplayObjectContainerUtils;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.system.Security;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class LoadingPage extends MovieClip
   {
       
      
      private var language = "en";
      
      private var xmlLoader:URLLoader;
      
      private var groupsMaxDays:Array;
      
      private var textField:TextField;
      
      private var mc:LoadingPageImage;
      
      public function LoadingPage()
      {
         this.groupsMaxDays = [];
         this.textField = new TextField();
         super();
         Security.allowDomain("*");
         Security.allowInsecureDomain("*");
         var _loc1_:TextFormat = TextFormats.format(30,true,TextFormatAlign.CENTER);
         _loc1_.color = 4915351;
         this.textField.defaultTextFormat = _loc1_;
         this.textField.width = 960;
         this.textField.height = 100;
         this.textField.y = 600 - this.textField.height;
         this.textField.selectable = false;
         addChild(this.textField);
      }
      
      public function setLanguage(param1:*) : *
      {
         this.language = param1;
      }
      
      public function load(param1:String) : *
      {
         this.language = param1;
         this.loadData();
      }
      
      public function showLoadingPage(param1:* = 0, param2:* = 1, param3:int = 0, param4:int = 0) : Number
      {
         var _loc6_:LoadingPageMessage = null;
         var _loc5_:PagesData;
         if(_loc5_ = this.getMsgGroup(param1))
         {
            _loc6_ = _loc5_.getMsg(param2,param3,param4);
            this.displayPage(_loc6_.swf);
            return _loc6_.time;
         }
         return 2;
      }
      
      public function hideLoadingPage() : *
      {
         if(this.mc)
         {
            this.mc.hide();
            DisplayObjectContainerUtils.stopAndRemoveHierarchy(this.mc);
            if(contains(this.mc))
            {
               removeChild(this.mc);
            }
            this.mc = null;
         }
      }
      
      private function displayPage(param1:LoadingPageImage) : *
      {
         this.hideLoadingPage();
         if(param1)
         {
            this.mc = param1;
            addChild(this.mc);
            this.mc.show();
         }
      }
      
      private function loadData() : *
      {
         this.language = this.language;
         this.xmlLoader = new URLLoader();
         this.xmlLoader.load(new URLRequest("./loading_page/loading_page_" + this.language + ".xml?version=" + VERSION.PRELOADERS_VERSION));
         this.xmlLoader.addEventListener(Event.COMPLETE,this.xmlLoaded,false,0,true);
         this.xmlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.xmlLoadingError,false,0,true);
      }
      
      private function xmlLoaded(param1:Event) : void
      {
         param1.target.removeEventListener(Event.COMPLETE,this.xmlLoaded);
         param1.target.removeEventListener(Event.COMPLETE,this.xmlLoadingError);
         this.setData(param1.target.data);
      }
      
      private function xmlLoadingError(param1:IOErrorEvent) : void
      {
         param1.target.removeEventListener(Event.COMPLETE,this.xmlLoaded);
         param1.target.removeEventListener(Event.COMPLETE,this.xmlLoadingError);
      }
      
      private function setData(param1:String) : *
      {
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc2_:* = XML(param1);
         var _loc3_:* = _loc2_.children().length();
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_)
         {
            _loc6_ = (_loc5_ = _loc2_.child(_loc4_)).attribute("maxDaysPlayed");
            _loc7_ = new PagesData(_loc6_,_loc5_);
            this.groupsMaxDays.push(_loc7_);
            _loc4_++;
         }
         this.groupsMaxDays.sortOn("maxDaysPlayed");
         this.showLoadingPage(0,1,-999);
      }
      
      private function getMsgGroup(param1:*) : PagesData
      {
         var _loc2_:* = 0;
         while(_loc2_ < this.groupsMaxDays.length)
         {
            if((this.groupsMaxDays[_loc2_] as PagesData).maxDaysPlayed >= param1)
            {
               return this.groupsMaxDays[_loc2_] as PagesData;
            }
            _loc2_++;
         }
         return this.groupsMaxDays[this.groupsMaxDays.length - 1] as PagesData;
      }
   }
}
