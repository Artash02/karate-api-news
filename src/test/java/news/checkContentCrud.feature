Feature: Check Content Functionality

  Background: Generate Current Time Stamp and payload.

    Given def currentTimeStamp = function() { return java.lang.System.currentTimeMillis() + '' }
    Given def payload =
"""
  function(actionName) {
    var dbUtils = Java.type('utils.DbUtils');
    var payload = new dbUtils();
    return payload.getPayload(actionName);
  }
  """

    Given def addBasicContentPayload = call payload 'add-basic-content'

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

#   Add Basic Content

    Given url api_news_host + '/api/news/' + articleId
    Given header authorization = 'Bearer ' + access_token
    Given request addBasicContentPayload
    When method put
    Then status 200

#   Check Security Response Headers

    * json jsonHeaders = responseHeaders
    * def securityHeaders = call read('file:src/test/java/helper/security-headers.feature') { headers: '#(jsonHeaders)' }
