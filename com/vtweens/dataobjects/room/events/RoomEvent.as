package com.vtweens.dataobjects.room.events
{
   import com.vtweens.util.DisplayObjectContainerUtils;
   import flash.display.MovieClip;
   import flash.errors.IllegalOperationError;
   import flash.events.Event;
   
   public class RoomEvent extends MovieClip
   {
       
      
      private var _username:String;
      
      public function RoomEvent()
      {
         super();
      }
      
      public function startEvent(param1:String = null) : void
      {
         throw new IllegalOperationError("Abstract function. Must be implemented by descendants");
      }
      
      protected function initUsernameClip(param1:String) : void
      {
      }
      
      protected function set username(param1:String) : void
      {
         this._username = this.username;
      }
      
      protected function get username() : String
      {
         return this._username;
      }
      
      protected function destroy() : void
      {
         DisplayObjectContainerUtils.stopAndRemoveHierarchy(this);
         dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}
