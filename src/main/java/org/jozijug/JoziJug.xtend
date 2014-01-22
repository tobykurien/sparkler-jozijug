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
      // these are optional initializers, must be set before routes
      //setPort(4567) // port to bind on startup, default is 4567
      DatabaseManager.init(Presentation.package.name)

      // Set up path to static files
      val workingDir = System.getProperty("user.dir")
      externalStaticFileLocation(workingDir + "/public")      
      
      // Homepage
      get("/") [req, res|
         DbConnection.run [
            render("views/list.html", #{
               "presos" -> pres.all.orderBy("title")
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
