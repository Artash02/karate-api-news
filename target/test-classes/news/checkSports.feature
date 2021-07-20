Feature: Check Sports Functionality

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
    Given def addChannelPayload = call payload 'add-channel'
    Given def addSportsPayload = call payload 'add-sports'
    Given def editSportsPayload = call payload 'edit-sports'
    Given def deleteSportsPayload = call payload 'empty-tags'

  Scenario: 1. Create Article, 2. Add Sports 3. Edit Sports, 4. Delete Sports, 5. Delete Created Article

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

##  Add Winners.net Channel

    Given url api_news_host + '/api/news/' + articleId
    Given header authorization = 'Bearer ' + access_token
    Given request addChannelPayload
    When method put
    Then status 200

#   Check Security Response Headers

    * json jsonHeaders = responseHeaders
    * def securityHeaders = call read('file:src/test/java/helper/security-headers.feature') { headers: '#(jsonHeaders)' }

##  Add Sports

    Given url api_news_host + '/api/news/' + articleId
    Given header authorization = 'Bearer ' + access_token
    Given request addSportsPayload
    When method put
    Then status 200

#   Check Security Response Headers

    * json jsonHeaders = responseHeaders
    * def securityHeaders = call read('file:src/test/java/helper/security-headers.feature') { headers: '#(jsonHeaders)' }

#   Assert Key Types

    Then match response.tags[0].channel == '#string'
    Then match response.tags[0].name == '#string'
    Then match response.tags[0].resourceId == '#string'
    Then match response.tags[0].type == '#string'
    Then match response.tags[0].color == '#string'

    Then match response.tags[1].channel == '#string'
    Then match response.tags[1].name == '#string'
    Then match response.tags[1].resourceId == '#string'
    Then match response.tags[1].type == '#string'
    Then match response.tags[1].color == '#string'

#   Assert Key Values

    Then match response.tags[0].channel == 'winnersnet'
    Then match response.tags[0].name == 'Football'
    Then match response.tags[0].resourceId == '5ebd6382224ed80010a0fb02'
    Then match response.tags[0].type == 'sport'
    Then match response.tags[0].color == '#346926'

    Then match response.tags[1].channel == 'winnersnet'
    Then match response.tags[1].name == 'Tennis'
    Then match response.tags[1].resourceId == '5ebd6382224ed80010a0fb03'
    Then match response.tags[1].type == 'sport'
    Then match response.tags[1].color == '#811a1a'

##  Edit Sports

    Given url api_news_host + '/api/news/' + articleId
    Given header authorization = 'Bearer ' + access_token
    Given request editSportsPayload
    When method put
    Then status 200

#   Check Security Response Headers

    * json jsonHeaders = responseHeaders
    * def securityHeaders = call read('file:src/test/java/helper/security-headers.feature') { headers: '#(jsonHeaders)' }

#   Assert Key Types

    Then match response.tags[0].channel == '#string'
    Then match response.tags[0].name == '#string'
    Then match response.tags[0].resourceId == '#string'
    Then match response.tags[0].type == '#string'

#   Assert Key Values

    Then match response.tags[0].channel == 'winnersnet'
    Then match response.tags[0].name == 'Basketball'
    Then match response.tags[0].resourceId == '5ebd6382224ed80010a0fb07'
    Then match response.tags[0].type == 'sport'

##  Delete Sports

    Given url api_news_host + '/api/news/' + articleId
    Given header authorization = 'Bearer ' + access_token
    Given request deleteSportsPayload
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