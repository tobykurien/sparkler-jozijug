package org.jozijug

import com.tobykurien.sparkler.db.DatabaseManager
import org.javalite.activejdbc.Base

class DbConnection {
   def static run((Void)=>Object func) {
      Base.open(DatabaseManager.newDataSource)
      try {
         func.apply(null)
      } finally {
         Base.close
      }
   }
}