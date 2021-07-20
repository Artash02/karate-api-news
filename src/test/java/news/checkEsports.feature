Feature: Check Esports Functionality

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
    Given def addEsportsPayload = call payload 'add-esports'
    Given def editEsportsPayload = call payload 'edit-esports'
    Given def deleteEsportsPayload = call payload 'empty-tags'

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

##  Add Esports

    Given url api_news_host + '/api/news/' + articleId
    Given header authorization = 'Bearer ' + access_token
    Given request addEsportsPayload
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
    Then match response.tags[0].name == 'Dota 2'
    Then match response.tags[0].resourceId == '5ebd631a224ed80010a0faf8'
    Then match response.tags[0].type == 'esport'
    Then match response.tags[0].color == '#b91e10'

    Then match response.tags[1].channel == 'winnersnet'
    Then match response.tags[1].name == 'CS:GO'
    Then match response.tags[1].resourceId == '5ebd631a224ed80010a0faf9'
    Then match response.tags[1].type == 'esport'
    Then match response.tags[1].color == '#4e06ff'

##  Edit Esports

    Given url api_news_host + '/api/news/' + articleId
    Given header authorization = 'Bearer ' + access_token
    Given request editEsportsPayload
    When method put
    Then status 200

#   Check Security Response Headers

    * json jsonHeaders = responseHeaders
    * def securityHeaders = call read('file:src/test/java/helper/security-headers.feature') { headers: '#(jsonHeaders)' }

#   Assert Key Types

    Then match response.tags[0].images.default.filePath == '#string'
    Then match response.tags[0].channel == '#string'
    Then match response.tags[0].name == '#string'
    Then match response.tags[0].resourceId == '#string'
    Then match response.tags[0].type == '#string'
    Then match response.tags[0].color == '#string'

#   Assert Key Values

    Then match response.tags[0].images.default.filePath == 'tags/f8cc985f506301d5d46d1909b70e783d/0e7a8f63566145fc994bd0c379d33073/original.png'
    Then match response.tags[0].channel == 'winnersnet'
    Then match response.tags[0].name == 'LoL'
    Then match response.tags[0].resourceId == '5ebd631a224ed80010a0fafa'
    Then match response.tags[0].type == 'esport'


##  Delete Esports

    Given url api_news_host + '/api/news/' + articleId
    Given header authorization = 'Bearer ' + access_token
    Given request deleteEsportsPayload
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

#    Given def id = {id: '#(articleId)'}
#    Given def deleteArticle = call read('file:src/test/java/helper/delete-news.feature') id
