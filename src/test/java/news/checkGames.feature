Feature: Check Games Functionality

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
    Given def addGamesPayload = call payload 'add-games'
    Given def editGamesPayload = call payload 'edit-games'
    Given def emptyGamesPayload = call payload 'empty-tags'


  Scenario: 1. Create Article, 2. Add Games, 3. Edit Games, 4. Delete Games, 5. Delete Created Article

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

## Add Games

    Given url api_news_host + '/api/news/' + articleId
    Given header authorization = 'Bearer ' + access_token
    Given request addGamesPayload
    When method put
    Then status 200

#   Check Security Response Headers

    * json jsonHeaders = responseHeaders
    * def securityHeaders = call read('file:src/test/java/helper/security-headers.feature') { headers: '#(jsonHeaders)' }

## Assert Key Types

    Then match response.tags[0].images.default.filePath == '#string'
    Then match response.tags[0].channel == '#string'
    Then match response.tags[0].name == '#string'
    Then match response.tags[0].shortName == '#string'
    Then match response.tags[0].resourceId == '#string'
    Then match response.tags[0].gameId == '#number'
    Then match response.tags[0].type == '#string'

    Then match response.tags[1].images.default.filePath == '#string'
    Then match response.tags[1].channel == '#string'
    Then match response.tags[1].name == '#string'
    Then match response.tags[1].shortName == '#string'
    Then match response.tags[1].resourceId == '#string'
    Then match response.tags[1].gameId == '#number'
    Then match response.tags[1].type == '#string'

    ## Assert Key Values

    Then match response.tags[0].images.default.filePath == 'static/imgs/games/dota2/dota2-40px.jpg'
    Then match response.tags[0].channel == 'wingg'
    Then match response.tags[0].name == 'Dota 2'
    Then match response.tags[0].shortName == 'Dota 2'
    Then match response.tags[0].resourceId == '1'
    Then match response.tags[0].gameId == 1
    Then match response.tags[0].type == 'game'

    Then match response.tags[1].images.default.filePath == 'static/imgs/games/cs/csgo-40px.jpg'
    Then match response.tags[1].channel == 'wingg'
    Then match response.tags[1].name == 'CS:GO'
    Then match response.tags[1].shortName == 'CS:GO'
    Then match response.tags[1].resourceId == '5'
    Then match response.tags[1].gameId == 5
    Then match response.tags[1].type == 'game'

    ## Edit Games

    Given url api_news_host + '/api/news/' + articleId
    Given header authorization = 'Bearer ' + access_token
    Given request editGamesPayload
    When method put
    Then status 200

#   Check Security Response Headers

    * json jsonHeaders = responseHeaders
    * def securityHeaders = call read('file:src/test/java/helper/security-headers.feature') { headers: '#(jsonHeaders)' }

    ## Assert Key Types

    Then match response.tags[0].images.default.filePath == '#string'
    Then match response.tags[0].channel == '#string'
    Then match response.tags[0].name == '#string'
    Then match response.tags[0].shortName == '#string'
    Then match response.tags[0].resourceId == '#string'
    Then match response.tags[0].gameId == '#number'
    Then match response.tags[0].type == '#string'

    Then match response.tags[1].images.default.filePath == '#string'
    Then match response.tags[1].channel == '#string'
    Then match response.tags[1].name == '#string'
    Then match response.tags[1].shortName == '#string'
    Then match response.tags[1].resourceId == '#string'
    Then match response.tags[1].gameId == '#number'
    Then match response.tags[1].type == '#string'

    ## Assert Key Values

    Then match response.tags[0].images.default.filePath == 'static/imgs/games/valorant/valorant-40px.jpg'
    Then match response.tags[0].channel == 'wingg'
    Then match response.tags[0].name == 'Valorant'
    Then match response.tags[0].shortName == 'Valorant'
    Then match response.tags[0].resourceId == '103'
    Then match response.tags[0].gameId == 103
    Then match response.tags[0].type == 'game'

    Then match response.tags[1].images.default.filePath == 'static/imgs/games/lol/lol-40px.jpg'
    Then match response.tags[1].channel == 'wingg'
    Then match response.tags[1].name == 'LoL'
    Then match response.tags[1].shortName == 'LoL'
    Then match response.tags[1].resourceId == '2'
    Then match response.tags[1].gameId == 2.0
    Then match response.tags[1].type == 'game'

##  Delete Games

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


##  Delete Created Article

    Given def id = {id: '#(articleId)'}
    Given def deleteArticle = call read('file:src/test/java/helper/delete-news.feature') id