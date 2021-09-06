package com.vtweens.dataobjects.life_level
{
   import com.vtweens.text.TextFormats;
   import com.vtweens.util.LayerOrganizer;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   
   public class LifeLevelGaugePlayer extends MovieClip
   {
      
      public static const LOADME:int = 0;
       
      
      private var max = 1;
      
      private var life = 1;
      
      private var clip;
      
      private var typeId;
      
      private var displayMax;
      
      private var displayLife;
      
      private var displayAnimation;
      
      private var mcLoader:Loader;
      
      public function LifeLevelGaugePlayer(param1:*, param2:* = true, param3:* = false, param4:* = true)
      {
         this.mcLoader = new Loader();
         super();
         this.typeId = param1;
         this.displayMax = param2;
         this.displayLife = param3;
         this.displayAnimation = param4;
         this.loadData();
      }
      
      public function getLife() : *
      {
         return this.life;
      }
      
      public function getMax() : *
      {
         return this.max;
      }
      
      public function getType() : *
      {
         return this.typeId;
      }
      
      public function updateScore(param1:*, param2:*) : *
      {
         var newPosition:* = undefined;
         var curr:* = param1;
         var max:* = param2;
         var lifeDiff:* = curr - this.life;
         this.life = Math.max(0,curr);
         this.max = max;
         if(this.clip)
         {
            this.updateText();
            if(lifeDiff > 0 && this.displayAnimation)
            {
               try
               {
                  this.clip.good.txt.txt.text = "+" + lifeDiff;
                  this.clip.good.gotoAndPlay(2);
               }
               catch(e:*)
               {
               }
            }
            if(lifeDiff < 0 && this.displayAnimation)
            {
               try
               {
                  this.clip.bad.txt.txt.text = "" + lifeDiff;
                  this.clip.bad.gotoAndPlay(2);
               }
               catch(e:*)
               {
               }
            }
            newPosition = this.life / max;
            this.clip.life.empty.scaleX = Math.min((1 - newPosition) / 0.9,1);
            this.clip.life.alert.visible = newPosition <= 0.1;
            LayerOrganizer.MoveToTop(this);
         }
      }
      
      private function loadData() : *
      {
         var _loc1_:URLRequest = new URLRequest(this.getUrl());
         this.mcLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onMCLoaded,false,0,true);
         this.mcLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onMCLoadError,false,0,true);
         this.mcLoader.load(_loc1_);
      }
      
      private function getUrl() : String
      {
         return "./life_levels/life_level_player_" + this.typeId + ".swf";
      }
      
      private function onMCLoaded(param1:*) : *
      {
         this.clip = this.mcLoader.content;
         this.mcLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onMCLoaded);
         this.mcLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onMCLoadError);
         this.mcLoader = null;
         this.setClip(this.clip);
      }
      
      private function onMCLoadError(param1:*) : *
      {
         this.mcLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onMCLoaded);
         this.mcLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onMCLoadError);
         this.mcLoader = null;
         throw new UninitializedError("Could not load life level [" + this.typeId + "] clip");
      }
      
      private function setClip(param1:*) : *
      {
         this.clip = param1;
         param1.life.alert.visible = false;
         param1.life.empty.scaleX = 0;
         param1.txt.defaultTextFormat = TextFormats.CenterBold11;
         this.updateScore(this.life,this.max);
         addChild(param1);
      }
      
      private function updateText() : *
      {
         if(this.clip)
         {
            this.clip.txt.text = "" + (!!this.displayLife ? this.life : "") + (this.displayLife && this.displayMax ? "/" : "") + (!!this.displayMax ? this.max : "");
         }
      }
   }
}
