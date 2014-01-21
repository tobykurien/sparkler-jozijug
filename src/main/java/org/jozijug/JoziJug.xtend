package org.jozijug

import com.tobykurien.sparkler.db.DatabaseManager
import com.tobykurien.sparkler.transformer.JsonTransformer
import org.javalite.activejdbc.Model
import org.jozijug.models.Member
import org.jozijug.models.Presentation
import spark.servlet.SparkApplication

import static com.tobykurien.sparkler.Sparkler.*
import com.tobykurien.sparkler.utils.Log

class JoziJug implements SparkApplication {
   val pres = Model.with(Presentation)
   
   override init() {
      DatabaseManager.init(Presentation.package.name)
      // these are optional initializers, must be set before routes
      //setPort(4567) // port to bind on startup, default is 4567

      // Set up path to static files
      val workingDir = System.getProperty("user.dir")
      externalStaticFileLocation(workingDir + "/public")      
      
      // Homepage
      get("/") [req, res|
         DbConnection.run [
            var presos = pres.all.orderBy("title")
            render("views/list.html", #{
               "presos" -> presos
            })
         ]
      ]
      
      get(new JsonTransformer("/api/presentation") [req, res|
         pres.all
      ])
   }
   
   def static void main(String[] args) {
      new JoziJug().init();
   }
}
