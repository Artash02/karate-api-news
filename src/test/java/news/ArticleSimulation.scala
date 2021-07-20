package news

import com.intuit.karate.gatling.PreDef.karateFeature
import io.gatling.core.Predef._
import io.gatling.http.Predef.http

import scala.concurrent.duration._
import scala.language.postfixOps

class ArticleSimulation extends Simulation {

  val getUser = scenario("get Access Token")
    .exec(karateFeature("classpath:news/getUsers.feature"))





  setUp(
    getUser.inject(rampUsers(2) during(5 seconds))
  )
}