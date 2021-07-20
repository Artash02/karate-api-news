Feature: Check Teams Functionality

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
    Given def addTeamsPayload = call payload 'add-teams'
    Given def editTeamsPayload = call payload 'edit-teams'
    Given def emptyTeamsPayload = call payload 'empty-tags'


  Scenario: 1. Create Article, 2. Add Teams 3. Edit Teams, 4. Delete Teams, 5. Delete Created Article

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

##  Add Teams

    Given url api_news_host + '/api/news/' + articleId
    Given header authorization = 'Bearer ' + access_token
    Given request addTeamsPayload
    When method put
    Then status 200

#   Check Security Response Headers

    * json jsonHeaders = responseHeaders
    * def securityHeaders = call read('file:src/test/java/helper/security-headers.feature') { headers: '#(jsonHeaders)' }

#   Assert Key Types

    Then match response.tags[0].channel == '#string'
    Then match response.tags[0].name == '#string'
    Then match response.tags[0].shortName == '#string'
    Then match response.tags[0].abiosId == '#number'
    Then match response.tags[0].resourceId == '#string'
    Then match response.tags[0].gameId == '#number'
    Then match response.tags[0].type == '#string'
    Then match response.tags[0].images.default.filePath == '#notpresent'

    Then match response.tags[1].channel == '#string'
    Then match response.tags[1].name == '#string'
    Then match response.tags[1].shortName == '#string'
    Then match response.tags[1].abiosId == '#number'
    Then match response.tags[1].resourceId == '#string'
    Then match response.tags[1].gameId == '#number'
    Then match response.tags[1].type == '#string'
    Then match response.tags[1].images.default.filePath == '#string'

#   Assert Key Values

    Then match response.tags[0].channel == 'wingg'
    Then match response.tags[0].name == 'Babos'
    Then match response.tags[0].shortName == 'Babos'
    Then match response.tags[0].abiosId == 78220
    Then match response.tags[0].resourceId == 'NzgyMjA'
    Then match response.tags[0].gameId == 5
    Then match response.tags[0].type == 'team'

    Then match response.tags[1].channel == 'wingg'
    Then match response.tags[1].name == 'KaBuM! e-Sports'
    Then match response.tags[1].shortName == 'KaBuM!'
    Then match response.tags[1].abiosId == 499
    Then match response.tags[1].resourceId == 'NDk5'
    Then match response.tags[1].gameId == 2
    Then match response.tags[1].type == 'team'
    Then match response.tags[1].images.default.filePath == 'external/1/team/NDk5/0f5d4382f91880a76c7de926c0fa9590/default/original.png'

##  Edit Teams

    Given url api_news_host + '/api/news/' + articleId
    Given header authorization = 'Bearer ' + access_token
    Given request editTeamsPayload
    When method put
    Then status 200

#   Check Security Response Headers

    * json jsonHeaders = responseHeaders
    * def securityHeaders = call read('file:src/test/java/helper/security-headers.feature') { headers: '#(jsonHeaders)' }

#   Assert Key Types

    Then match response.tags[0].channel == '#string'
    Then match response.tags[0].name == '#string'
    Then match response.tags[0].shortName == '#string'
    Then match response.tags[0].abiosId == '#number'
    Then match response.tags[0].resourceId == '#string'
    Then match response.tags[0].gameId == '#number'
    Then match response.tags[0].type == '#string'
    Then match response.tags[0].images.default.filePath == '#notpresent'

#   Assert Key Values

    Then match response.tags[0].channel == 'wingg'
    Then match response.tags[0].name == 'Able'
    Then match response.tags[0].shortName == 'Able'
    Then match response.tags[0].abiosId == 76009
    Then match response.tags[0].resourceId == 'NzYwMDk'
    Then match response.tags[0].gameId == 5
    Then match response.tags[0].type == 'team'
    Then match response.tags[0].images.default.filePath == '#notpresent'
#    "images" : {
#                    "default" : {
#
#                    }
#                }   have question

##  Delete Teams

    Given url api_news_host + '/api/news/' + articleId
    Given header authorization = 'Bearer ' + access_token
    Given request emptyTeamsPayload
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
