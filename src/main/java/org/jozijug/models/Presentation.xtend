package org.jozijug.models

import org.javalite.activejdbc.LazyList
import org.javalite.activejdbc.Model
import org.javalite.activejdbc.annotations.BelongsTo
import org.javalite.activejdbc.annotations.Many2Many

@BelongsTo(parent=Member, foreignKeyName = "presenter_id")
@Many2Many(other=Member, join="attendees", 
   sourceFKName="presentation_id", targetFKName="member_id"
)
class Presentation extends Model { 
   val static validations = {
      validatePresenceOf("title")
   }  

   def getTitle() {
      get("title") as String
   }
   
   def getPresenter() {
      (get("member") as Member)
   }
   
   def getAttendees() {
      (get("attendee") as LazyList<Member>).include(Member).toMaps
   }
}