package org.jozijug.models

import com.tobykurien.sparkler.db.DbField
import org.javalite.activejdbc.Model

class Member extends Model {
   @DbField String name
}