package org.jozijug

import com.tobykurien.sparkler.db.DatabaseManager
import com.tobykurien.sparkler.transformer.JsonTransformer
import com.tobykurien.sparkler.utils.DbConnection
import org.javalite.activejdbc.Model
import org.jozijug.models.Presentation
import spark.servlet.SparkApplication

import static com.tobykurien.sparkler.Sparkler.*

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
      
      // simple REST demo
      get(new JsonTransformer("/api/presentations") [req, res|         
         pres.all
      ])

      get(new JsonTransformer("/api/presentation/:id") [req, res|         
         pres.findById(req.params("id"))
      ])
   }
   
   def static void main(String[] args) {
      new JoziJug().init();
   }
}
