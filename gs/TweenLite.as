package gs
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.ColorTransform;
   import flash.media.SoundChannel;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class TweenLite
   {
      
      public static var version:Number = 6.22;
      
      public static var defaultEase:Function = TweenLite.easeOut;
      
      protected static var _all:Dictionary = new Dictionary();
      
      protected static var _curTime:uint;
      
      private static var _classInitted:Boolean;
      
      private static var _sprite:Sprite = new Sprite();
      
      private static var _listening:Boolean;
      
      private static var _timer:Timer = new Timer(2000);
      
      public static var killDelayedCallsTo:Function = killTweensOf;
       
      
      public var duration:Number;
      
      public var vars:Object;
      
      public var delay:Number;
      
      public var startTime:int;
      
      public var initTime:int;
      
      public var tweens:Array;
      
      public var target:Object;
      
      protected var _active:Boolean;
      
      protected var _subTweens:Array;
      
      protected var _hst:Boolean;
      
      protected var _initted:Boolean;
      
      public function TweenLite(param1:Object, param2:Number, param3:Object)
      {
         super();
         if(param1 == null)
         {
            return;
         }
         if(param3.overwrite != false && param1 != null || _all[param1] == undefined)
         {
            delete _all[param1];
            _all[param1] = new Dictionary();
         }
         _all[param1][this] = this;
         this.vars = param3;
         this.duration = Number(param2) || Number(0.001);
         this.delay = Number(param3.delay) || Number(0);
         this.target = param1;
         if(!(this.vars.ease is Function))
         {
            this.vars.ease = defaultEase;
         }
         if(this.vars.easeParams != null)
         {
            this.vars.proxiedEase = this.vars.ease;
            this.vars.ease = this.easeProxy;
         }
         if(!isNaN(Number(this.vars.autoAlpha)))
         {
            this.vars.alpha = Number(this.vars.autoAlpha);
         }
         this.tweens = [];
         this._subTweens = [];
         this._hst = this._initted = false;
         this._active = param2 == 0 && this.delay == 0;
         if(!_classInitted)
         {
            _curTime = getTimer();
            _sprite.addEventListener(Event.ENTER_FRAME,executeAll);
            _classInitted = true;
         }
         this.initTime = _curTime;
         if(this.vars.runBackwards == true && this.vars.renderOnStart != true || this._active)
         {
            this.initTweenVals();
            this.startTime = _curTime;
            if(this._active)
            {
               this.render(this.startTime + 1);
            }
            else
            {
               this.render(this.startTime);
            }
         }
         if(!_listening && !this._active)
         {
            _timer.addEventListener("timer",killGarbage);
            _timer.start();
            _listening = true;
         }
      }
      
      public static function to(param1:Object, param2:Number, param3:Object) : TweenLite
      {
         return new TweenLite(param1,param2,param3);
      }
      
      public static function from(param1:Object, param2:Number, param3:Object) : TweenLite
      {
         param3.runBackwards = true;
         return new TweenLite(param1,param2,param3);
      }
      
      public static function delayedCall(param1:Number, param2:Function, param3:Array = null, param4:* = null) : TweenLite
      {
         return new TweenLite(param2,0,{
            "delay":param1,
            "onComplete":param2,
            "onCompleteParams":param3,
            "onCompleteScope":param4,
            "overwrite":false
         });
      }
      
      public static function executeAll(param1:Event = null) : void
      {
         var _loc3_:Dictionary = null;
         var _loc4_:Object = null;
         var _loc5_:* = null;
         var _loc2_:uint = _curTime = getTimer();
         if(_listening)
         {
            _loc3_ = _all;
            for each(_loc4_ in _loc3_)
            {
               for(_loc5_ in _loc4_)
               {
                  if(_loc4_[_loc5_] != undefined && _loc4_[_loc5_].active)
                  {
                     _loc4_[_loc5_].render(_loc2_);
                  }
               }
            }
         }
      }
      
      public static function removeTween(param1:TweenLite = null) : void
      {
         if(param1 != null && _all[param1.target] != undefined)
         {
            delete _all[param1.target][param1];
         }
      }
      
      public static function killTweensOf(param1:Object = null, param2:Boolean = false) : void
      {
         var _loc3_:Object = null;
         var _loc4_:* = undefined;
         if(param1 != null && _all[param1] != undefined)
         {
            if(param2)
            {
               _loc3_ = _all[param1];
               for(_loc4_ in _loc3_)
               {
                  _loc3_[_loc4_].complete(false);
               }
            }
            delete _all[param1];
         }
      }
      
      public static function killGarbage(param1:TimerEvent) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:Object = null;
         var _loc2_:uint = 0;
         for(_loc4_ in _all)
         {
            _loc3_ = false;
            var _loc9_:int = 0;
            var _loc10_:* = _all[_loc4_];
            for(_loc5_ in _loc10_)
            {
               _loc3_ = true;
            }
            if(!_loc3_)
            {
               delete _all[_loc4_];
            }
            else
            {
               _loc2_++;
            }
         }
         if(_loc2_ == 0)
         {
            _timer.removeEventListener("timer",killGarbage);
            _timer.stop();
            _listening = false;
         }
      }
      
      public static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return -param3 * (param1 = param1 / param4) * (param1 - 2) + param2;
      }
      
      public static function tintProxy(param1:Object) : void
      {
         var _loc2_:Number = param1.target.progress;
         var _loc3_:Number = 1 - _loc2_;
         var _loc4_:Object = param1.info.color;
         var _loc5_:Object = param1.info.endColor;
         param1.info.target.transform.colorTransform = new ColorTransform(_loc4_.redMultiplier * _loc3_ + _loc5_.redMultiplier * _loc2_,_loc4_.greenMultiplier * _loc3_ + _loc5_.greenMultiplier * _loc2_,_loc4_.blueMultiplier * _loc3_ + _loc5_.blueMultiplier * _loc2_,_loc4_.alphaMultiplier * _loc3_ + _loc5_.alphaMultiplier * _loc2_,_loc4_.redOffset * _loc3_ + _loc5_.redOffset * _loc2_,_loc4_.greenOffset * _loc3_ + _loc5_.greenOffset * _loc2_,_loc4_.blueOffset * _loc3_ + _loc5_.blueOffset * _loc2_,_loc4_.alphaOffset * _loc3_ + _loc5_.alphaOffset * _loc2_);
      }
      
      public static function frameProxy(param1:Object) : void
      {
         param1.info.target.gotoAndStop(Math.round(param1.target.frame));
      }
      
      public static function volumeProxy(param1:Object) : void
      {
         param1.info.target.soundTransform = param1.target;
      }
      
      public function initTweenVals(param1:Boolean = false, param2:String = "") : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         var _loc7_:ColorTransform = null;
         var _loc8_:ColorTransform = null;
         var _loc9_:Object = null;
         var _loc3_:* = this.target is DisplayObject;
         if(this.target is Array)
         {
            _loc6_ = this.vars.endArray || [];
            _loc5_ = 0;
            while(_loc5_ < _loc6_.length)
            {
               if(this.target[_loc5_] != _loc6_[_loc5_] && this.target[_loc5_] != undefined)
               {
                  this.tweens.push({
                     "o":this.target,
                     "p":_loc5_.toString(),
                     "s":this.target[_loc5_],
                     "c":_loc6_[_loc5_] - this.target[_loc5_]
                  });
               }
               _loc5_++;
            }
         }
         else
         {
            for(_loc4_ in this.vars)
            {
               if(!(_loc4_ == "ease" || _loc4_ == "delay" || _loc4_ == "overwrite" || _loc4_ == "onComplete" || _loc4_ == "onCompleteParams" || _loc4_ == "onCompleteScope" || _loc4_ == "runBackwards" || _loc4_ == "onUpdate" || _loc4_ == "onUpdateParams" || _loc4_ == "onUpdateScope" || _loc4_ == "autoAlpha" || _loc4_ == "onStart" || _loc4_ == "onStartParams" || _loc4_ == "onStartScope" || _loc4_ == "renderOnStart" || _loc4_ == "proxiedEase" || _loc4_ == "easeParams" || param1 && param2.indexOf(" " + _loc4_ + " ") != -1))
               {
                  if(_loc4_ == "tint" && _loc3_)
                  {
                     _loc7_ = this.target.transform.colorTransform;
                     _loc8_ = new ColorTransform();
                     if(this.vars.alpha != undefined)
                     {
                        _loc8_.alphaMultiplier = this.vars.alpha;
                        delete this.vars.alpha;
                        _loc5_ = this.tweens.length - 1;
                        while(_loc5_ > -1)
                        {
                           if(this.tweens[_loc5_].p == "alpha")
                           {
                              this.tweens.splice(_loc5_,1);
                              break;
                           }
                           _loc5_--;
                        }
                     }
                     else
                     {
                        _loc8_.alphaMultiplier = this.target.alpha;
                     }
                     if(this.vars[_loc4_] != null && this.vars[_loc4_] != "" || this.vars[_loc4_] == 0)
                     {
                        _loc8_.color = this.vars[_loc4_];
                     }
                     this.addSubTween(tintProxy,{"progress":0},{"progress":1},{
                        "target":this.target,
                        "color":_loc7_,
                        "endColor":_loc8_
                     });
                  }
                  else if(_loc4_ == "frame" && _loc3_)
                  {
                     this.addSubTween(frameProxy,{"frame":this.target.currentFrame},{"frame":this.vars[_loc4_]},{"target":this.target});
                  }
                  else if(_loc4_ == "volume" && (_loc3_ || this.target is SoundChannel))
                  {
                     this.addSubTween(volumeProxy,this.target.soundTransform,{"volume":this.vars[_loc4_]},{"target":this.target});
                  }
                  else if(typeof this.vars[_loc4_] == "number")
                  {
                     this.tweens.push({
                        "o":this.target,
                        "p":_loc4_,
                        "s":this.target[_loc4_],
                        "c":this.vars[_loc4_] - this.target[_loc4_]
                     });
                  }
                  else
                  {
                     this.tweens.push({
                        "o":this.target,
                        "p":_loc4_,
                        "s":this.target[_loc4_],
                        "c":Number(this.vars[_loc4_])
                     });
                  }
               }
            }
         }
         if(this.vars.runBackwards == true)
         {
            _loc5_ = this.tweens.length - 1;
            while(_loc5_ > -1)
            {
               _loc9_ = this.tweens[_loc5_];
               _loc9_.s += _loc9_.c;
               _loc9_.c *= -1;
               _loc5_--;
            }
         }
         if(typeof this.vars.autoAlpha == "number")
         {
            this.target.visible = !(this.vars.runBackwards == true && this.target.alpha == 0);
         }
         this._initted = true;
      }
      
      protected function addSubTween(param1:Function, param2:Object, param3:Object, param4:Object = null) : void
      {
         var _loc6_:* = null;
         var _loc5_:Object = {
            "proxy":param1,
            "target":param2,
            "info":param4
         };
         this._subTweens.push(_loc5_);
         for(_loc6_ in param3)
         {
            if(param2.hasOwnProperty(_loc6_))
            {
               if(typeof param3[_loc6_] == "number")
               {
                  this.tweens.push({
                     "o":param2,
                     "p":_loc6_,
                     "s":param2[_loc6_],
                     "c":param3[_loc6_] - param2[_loc6_],
                     "sub":_loc5_
                  });
               }
               else
               {
                  this.tweens.push({
                     "o":param2,
                     "p":_loc6_,
                     "s":param2[_loc6_],
                     "c":Number(param3[_loc6_]),
                     "sub":_loc5_
                  });
               }
            }
         }
         this._hst = true;
      }
      
      public function render(param1:uint) : void
      {
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc2_:Number = (param1 - this.startTime) / 1000;
         if(_loc2_ > this.duration)
         {
            _loc2_ = this.duration;
         }
         var _loc3_:Number = this.vars.ease(_loc2_,0,1,this.duration);
         _loc5_ = this.tweens.length - 1;
         while(_loc5_ > -1)
         {
            (_loc4_ = this.tweens[_loc5_]).o[_loc4_.p] = _loc4_.s + _loc3_ * _loc4_.c;
            _loc5_--;
         }
         if(this._hst)
         {
            _loc5_ = this._subTweens.length - 1;
            while(_loc5_ > -1)
            {
               this._subTweens[_loc5_].proxy(this._subTweens[_loc5_]);
               _loc5_--;
            }
         }
         if(this.vars.onUpdate != null)
         {
            this.vars.onUpdate.apply(this.vars.onUpdateScope,this.vars.onUpdateParams);
         }
         if(_loc2_ == this.duration)
         {
            this.complete(true);
         }
      }
      
      public function complete(param1:Boolean = false) : void
      {
         if(!param1)
         {
            if(!this._initted)
            {
               this.initTweenVals();
            }
            this.startTime = _curTime - this.duration * 1000;
            this.render(_curTime);
            return;
         }
         if(typeof this.vars.autoAlpha == "number" && this.target.alpha == 0)
         {
            this.target.visible = false;
         }
         if(this.vars.onComplete != null)
         {
            this.vars.onComplete.apply(this.vars.onCompleteScope,this.vars.onCompleteParams);
         }
         removeTween(this);
      }
      
      protected function easeProxy(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return this.vars.proxiedEase.apply(null,arguments.concat(this.vars.easeParams));
      }
      
      public function get active() : Boolean
      {
         if(this._active)
         {
            return true;
         }
         if((_curTime - this.initTime) / 1000 > this.delay)
         {
            this._active = true;
            this.startTime = this.initTime + this.delay * 1000;
            if(!this._initted)
            {
               this.initTweenVals();
            }
            else if(typeof this.vars.autoAlpha == "number")
            {
               this.target.visible = true;
            }
            if(this.vars.onStart != null)
            {
               this.vars.onStart.apply(this.vars.onStartScope,this.vars.onStartParams);
            }
            if(this.duration == 0.001)
            {
               --this.startTime;
            }
            return true;
         }
         return false;
      }
   }
}
