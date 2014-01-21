package org.jozijug

import com.tobykurien.sparkler.test.TestSupport
import org.javalite.activejdbc.Model
import org.jozijug.models.Member
import org.jozijug.models.Presentation
import org.junit.Test

class JoziJugTest extends TestSupport {
   val member = Model.with(Member)
   val presentation = Model.with(Presentation)
   
   override getModelPackageName() {
      // Where your database Model classes are
      Member.package.name 
   }
   
   @Test
   def void shouldSavePresenter() {
      val toby = member.createIt(
         "name", "Toby Kurien"         
      )
      
      val att1 = member.createIt(
         "name", "Attendee 1"         
      )
      
      val att2 = member.createIt(
         "name", "Attendee 2"         
      )

      val preso = presentation.createIt(
         "title", "Sparkler",
         "presenter_id", toby.id
      )

      preso.add(att1)
      preso.add(att2)
      
      the(preso.presenter.id).shouldBeEqual(toby.id)
      the(preso.attendees.length).shouldBeEqual(2)
   }
}
