package org.jozijug.models

import org.javalite.activejdbc.Model
import org.javalite.activejdbc.annotations.BelongsTo
import org.javalite.activejdbc.annotations.Many2Many

class Member extends Model {
   def getName() {
      get("name") as String
   }
}