package com.vtweens.dataobjects.life_level
{
   import com.greensock.TweenLite;
   import com.vtweens.text.TextFormats;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   
   public class LifeLevelGauge extends MovieClip
   {
       
      
      private var max = 0;
      
      private var life = 0;
      
      private var clip;
      
      private var typeId;
      
      private var mcLoader:Loader;
      
      public function LifeLevelGauge(param1:*)
      {
         this.mcLoader = new Loader();
         super();
         this.typeId = param1;
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
      
      private function loadData() : *
      {
         var _loc1_:URLRequest = new URLRequest(this.getUrl());
         this.mcLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onMCLoaded,false,0,true);
         this.mcLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onMCLoadError,false,0,true);
         this.mcLoader.load(_loc1_);
      }
      
      private function getUrl() : String
      {
         return "./life_levels/life_level_" + this.typeId + ".swf";
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
      
      public function setClip(param1:*) : *
      {
         this.clip = param1;
         param1.life.alert.visible = false;
         param1.life.empty.scaleX = 0;
         param1.txt.defaultTextFormat = TextFormats.CenterBold14;
         this.updateText();
         addChild(param1);
      }
      
      public function updateText() : *
      {
         if(this.clip)
         {
            this.clip.txt.text = this.life + "/" + this.max;
         }
      }
      
      public function updateScore(param1:*, param2:*) : *
      {
         var _loc3_:* = param1 - this.life;
         this.life = Math.max(0,param1);
         this.max = param2;
         this.updateText();
         if(_loc3_ > 0)
         {
            this.addLifeEffect();
         }
         else if(_loc3_ < 0)
         {
            this.takeLifeEffect();
         }
      }
      
      private function takeLifeEffect() : void
      {
         if(this.clip)
         {
            this.clip.icon.gotoAndPlay("hit");
         }
         if(this.clip)
         {
            this.clip.bg.gotoAndPlay("hit");
         }
         this.tweenLife();
      }
      
      private function addLifeEffect() : void
      {
         if(this.clip)
         {
            this.clip.icon.gotoAndPlay("bonus");
         }
         if(this.clip)
         {
            this.clip.bg.gotoAndPlay("bonus");
         }
         this.tweenLife();
      }
      
      private function tweenLife() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         if(this.clip)
         {
            _loc1_ = this.life / this.max;
            _loc2_ = Math.min((1 - _loc1_) / 0.9,1);
            if(_loc1_ > 0.1)
            {
               this.clip.life.alert.visible = false;
               TweenLite.to(this.clip.life.empty,1,{"scaleX":_loc2_});
            }
            else
            {
               TweenLite.to(this.clip.life.empty,1,{
                  "scaleX":_loc2_,
                  "onComplete":this.setAlert
               });
            }
         }
      }
      
      private function setAlert() : void
      {
         this.clip.life.alert.visible = true;
      }
   }
}
