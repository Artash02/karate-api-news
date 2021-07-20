Feature: Check Tournaments Functionality

  Background:
    Given def currentTimeStamp = function() { return java.lang.System.currentTimeMillis() + '' }
    Given def payload =
  """
  function(actionName) {
    var dbUtils = Java.type('utils.DbUtils');
    var payload = new dbUtils();
    return payload.getPayload(actionName);
  }
  """
    Given def createArticlePayload = call payload 'create-article'
    Given def addTournamentsPayload = call payload 'add-tournaments'
    Given def editTournamentsPayload = call payload 'edit-tournaments'
    Given def emptyGamesPayload = call payload 'empty-tags'

  Scenario: 1. Create Article, 2. Add Tournaments,

##  Create Article

    Given def userInfo = call read('file:src/test/java/helper/get-user-info.feature')
    Given url api_news_host + '/api/news'
    And header authorization = 'Bearer ' + access_token
    And def articleName = 'article_title_api_test' + currentTimeStamp()
    And set createArticlePayload.title = articleName
    Given request createArticlePayload
    When method post
    Then status 201
    And def articleId = response.newsId

#   Check Security Response Headers

    * json jsonHeaders = responseHeaders
    * def securityHeaders = call read('file:src/test/java/helper/security-headers.feature') { headers: '#(jsonHeaders)' }

##  Add Tournaments

    Given url api_news_host + '/api/news/' + articleId
    Given header authorization = 'Bearer ' + access_token
    Given request addTournamentsPayload
    When method put
    Then status 200

#   Check Security Response Headers

    * json jsonHeaders = responseHeaders
    * def securityHeaders = call read('file:src/test/java/helper/security-headers.feature') { headers: '#(jsonHeaders)' }

#   Assert Key Types

    Then match response.tags[0].gameId == '#number'
    Then match response.tags[0].images.default.filePath == '#string'
    Then match response.tags[0].resourceId == '#string'
    Then match response.tags[0].abiosId == '#number'
    Then match response.tags[0].channel == '#string'
    Then match response.tags[0].name == '#string'
    Then match response.tags[0].shortName == '#string'
    Then match response.tags[0].shortName == '#string'

    Then match response.tags[1].gameId == '#number'
    Then match response.tags[1].images.default.filePath == '#string'
    Then match response.tags[1].resourceId == '#string'
    Then match response.tags[1].abiosId == '#number'
    Then match response.tags[1].channel == '#string'
    Then match response.tags[1].name == '#string'
    Then match response.tags[1].shortName == '#string'
    Then match response.tags[1].shortName == '#string'

#   Assert Key Values

    Then match response.tags[0].gameId == 5
    Then match response.tags[0].images.default.filePath == 'external\/1\/tournament\/NDQ3MQ\/82c2ca19962ef594f7dc1015d32e70f2\/default\/original.jpg'
    Then match response.tags[0].resourceId == 'NDQ3MQ'
    Then match response.tags[0].abiosId == 4471
    Then match response.tags[0].channel == 'wingg'
    Then match response.tags[0].name == '2019 GIRLGAMER Esports Festival'
    Then match response.tags[0].shortName == 'GG'
    Then match response.tags[0].type == 'tournament'

    Then match response.tags[1].gameId == 5
    Then match response.tags[1].images.default.filePath == 'external\/1\/tournament\/MzQ1MA\/df61defeb43f0a840c58cf232ee98105\/default\/original.jpg'
    Then match response.tags[1].resourceId == 'MzQ1MA'
    Then match response.tags[1].abiosId == 3450
    Then match response.tags[1].channel == 'wingg'
    Then match response.tags[1].name == 'United Masters League'
    Then match response.tags[1].shortName == 'UML'
    Then match response.tags[1].type == 'tournament'

##  Edit Tournaments

    Given url api_news_host + '/api/news/' + articleId
    Given header authorization = 'Bearer ' + access_token
    Given request editTournamentsPayload
    When method put
    Then status 200

#   Check Security Response Headers

    * json jsonHeaders = responseHeaders
    * def securityHeaders = call read('file:src/test/java/helper/security-headers.feature') { headers: '#(jsonHeaders)' }

##  Assert Key Types

    Then match response.tags[0].gameId == '#number'
    Then match response.tags[0].images.default.filePath == '#string'
    Then match response.tags[0].resourceId == '#string'
    Then match response.tags[0].abiosId == '#number'
    Then match response.tags[0].channel == '#string'
    Then match response.tags[0].name == '#string'
    Then match response.tags[0].shortName == '#string'
    Then match response.tags[0].shortName == '#string'

##  Assert Key Values

    Then match response.tags[0].gameId == 1
    Then match response.tags[0].images.default.filePath == 'external/1/tournament/Mzk1OQ/9ab8b1d0eaa6025cfde8684c7969c209/default/original.jpg'
    Then match response.tags[0].resourceId == 'Mzk1OQ'
    Then match response.tags[0].abiosId == 3959
    Then match response.tags[0].channel == 'wingg'
    Then match response.tags[0].name == 'Jiabet Asian Master League'
    Then match response.tags[0].shortName == 'AML'
    Then match response.tags[0].type == 'tournament'

##  Delete Tournaments

    Given url api_news_host + '/api/news/' + articleId
    Given header authorization = 'Bearer ' + access_token
    Given request emptyGamesPayload
    When method put
    Then status 200

#   Check Security Response Headers

    * json jsonHeaders = responseHeaders
    * def securityHeaders = call read('file:src/test/java/helper/security-headers.feature') { headers: '#(jsonHeaders)' }

#   Assert Key Type

    Then match response.tags == '#[0]'

#   Assert Key Value
    Then match response.tags == []

 ##  Delete created Article

    Given def id = {id: '#(articleId)'}
    Given def deleteArticle = call read('file:src/test/java/helper/delete-news.feature') id
