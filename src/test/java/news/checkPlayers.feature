Feature: Check Players Functionality

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
    Given def addPlayersPayload = call payload 'add-players'
    Given def editPlayersPayload = call payload 'edit-players'
    Given def emptyPlayersPayload = call payload 'empty-tags'

  Scenario: 1. Create Article, 2. Add Players 3. Edit Players, 4. Delete Players, 5. Delete Created Article

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

##  Add Players

    Given url api_news_host + '/api/news/' + articleId
    Given header authorization = 'Bearer ' + access_token
    Given request addPlayersPayload
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
    Then match response.tags[0].type == '#string'

    Then match response.tags[1].gameId == '#number'
    Then match response.tags[1].resourceId == '#string'
    Then match response.tags[1].abiosId == '#number'
    Then match response.tags[1].channel == '#string'
    Then match response.tags[1].name == '#string'
    Then match response.tags[1].shortName == '#string'
    Then match response.tags[1].type == '#string'

#   Assert Key Values

    Then match response.tags[0].gameId == 1
    Then match response.tags[0].images.default.filePath == 'external\/1\/player\/ODY0Mg\/default\/original.png'
    Then match response.tags[0].resourceId == 'MTMyMzg'
    Then match response.tags[0].abiosId == 13238
    Then match response.tags[0].channel == 'wingg'
    Then match response.tags[0].name == 'Jabz'
    Then match response.tags[0].shortName == 'Jabz'
    Then match response.tags[0].type == 'player'

    Then match response.tags[1].gameId == 5
    Then match response.tags[1].resourceId == 'NzYxMzM'
    Then match response.tags[1].abiosId == 76133
    Then match response.tags[1].channel == 'wingg'
    Then match response.tags[1].name == 'ABM'
    Then match response.tags[1].shortName == 'ABM'
    Then match response.tags[1].type == 'player'

##  Edit Players

    Given url api_news_host + '/api/news/' + articleId
    Given header authorization = 'Bearer ' + access_token
    Given request editPlayersPayload
    When method put
    Then status 200

#   Check Security Response Headers

    * json jsonHeaders = responseHeaders
    * def securityHeaders = call read('file:src/test/java/helper/security-headers.feature') { headers: '#(jsonHeaders)' }

#   Assert Key Types

    Then match response.tags[0].gameId == '#number'
    Then match response.tags[0].resourceId == '#string'
    Then match response.tags[0].abiosId == '#number'
    Then match response.tags[0].channel == '#string'
    Then match response.tags[0].name == '#string'
    Then match response.tags[0].shortName == '#string'
    Then match response.tags[0].type == '#string'

#   Assert Key Values

    Then match response.tags[0].gameId == 1
    Then match response.tags[0].resourceId == 'NzUxMTQ'
    Then match response.tags[0].abiosId == 75114
    Then match response.tags[0].channel == 'wingg'
    Then match response.tags[0].name == 'Zaza'
    Then match response.tags[0].shortName == 'Zaza'
    Then match response.tags[0].type == 'player'

#   Delete Players

    Given url api_news_host + '/api/news/' + articleId
    Given header authorization = 'Bearer ' + access_token
    Given request emptyPlayersPayload
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