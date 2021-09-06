package com.vtweens.util
{
   import flash.errors.IllegalOperationError;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class XmlParser extends EventDispatcher
   {
       
      
      private var _isLoaded:Boolean = false;
      
      private var xmlLoaded:Boolean = false;
      
      private var xmlLoader:URLLoader;
      
      public function XmlParser()
      {
         super();
      }
      
      protected function loadData() : *
      {
         this.xmlLoader = new URLLoader();
         this.xmlLoader.load(new URLRequest(this.xmlUrl));
         this.xmlLoader.addEventListener(Event.COMPLETE,this.onXmlLoaded);
         this.xmlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.xmlLoadingError);
      }
      
      private function onXmlLoaded(param1:Event) : void
      {
         var e:Event = param1;
         e.target.removeEventListener(Event.COMPLETE,this.onXmlLoaded);
         e.target.removeEventListener(Event.COMPLETE,this.xmlLoadingError);
         try
         {
            this.parse(XML(e.target.data));
            this.xmlLoaded = true;
            if(this.isLoaded)
            {
               dispatchEvent(new Event(Event.COMPLETE));
            }
         }
         catch(e:*)
         {
            loadFailed();
         }
      }
      
      private function xmlLoadingError(param1:IOErrorEvent) : void
      {
         param1.target.removeEventListener(Event.COMPLETE,this.onXmlLoaded);
         param1.target.removeEventListener(Event.COMPLETE,this.xmlLoadingError);
         this.loadFailed();
      }
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         super.addEventListener(param1,param2,param3,param4,param5);
         if(param1 == Event.COMPLETE && this.isLoaded)
         {
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      protected function loadFailed() : *
      {
      }
      
      public function get isLoaded() : Boolean
      {
         return this._isLoaded;
      }
      
      public function set isLoaded(param1:Boolean) : void
      {
         this._isLoaded = param1;
         if(this.xmlLoaded && this._isLoaded)
         {
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      protected function get xmlUrl() : String
      {
         throw new IllegalOperationError("method must be implemented by subclass");
      }
      
      protected function parse(param1:XML) : *
      {
         throw new IllegalOperationError("method must be implemented by subclass");
      }
   }
}
