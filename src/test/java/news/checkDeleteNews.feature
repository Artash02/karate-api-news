Feature: Verify the JSON Schema validation, Verify the Field Type

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

  Scenario: CRUD model for Article

#   Create Article

    Given def userInfo = call read('file:src/test/java/helper/get-user-info.feature')
    Given def createArticlePayload = call payload 'create-article'
    * print 'API_NEWSSS' + api_news_host
    Given url api_news_host + '/api/news'
    And header authorization = 'Bearer ' + access_token
    And def articleName = 'article_title_api_test' + currentTimeStamp()
    * print 'ARTICLE NAME ' + articleName
    And set createArticlePayload.title = articleName
    Given request createArticlePayload
    When method post
    * print 'CREATE' + createArticlePayload.title == ''
    * print 'RESPONSE' + response
    Then status 201

#   Assert Key types
    Then match response.newsId == '#number'
    Then match response.deleted == '#boolean'
    Then match response.subtext == '#string'
    Then match response.author.firstName == '#string'
    Then match response.author.lastName == '#string'
    Then match response.author.id == '#string'
    Then match response.author.email == '#string'
    Then match response.created == '#string'
    Then match response.title == '#string'
    Then match response.updated == '#string'
    Then match response.content == ''
    Then match response.products == '#array'

##   Assert key values
    Then match response.deleted == false
    Then match response.title == articleName
    Then match response.subtext == createArticlePayload.subtext
    Then match response.content == ''
    Then match response.author.id == userInfo.authorId[0]
    Then match response.author.lastName == userInfo.authorLastName[0]
    Then match response.author.email == userInfo.authorEmail[0]
#    Then match response.ampContent == '60af7edd6ce2cf0010afc6f6'
    Then match response.tags == '#[0]'
#    Then match response.updated == ''
#    Then match response.created == ''
#
    And def articleId = response.newsId
#
##   Get created Article (Check Create Article option)

    Given url api_news_host + '/api/news/' + articleId
    Given header authorization = 'Bearer ' + access_token
    When method get
    Then status 200

##   Assert Key types
    Then match response.id == '#string'
    Then match response.author.id =='#string'
    Then match response.author.firstName =='#string'
    Then match response.author.lastName =='#string'
    Then match response.author.email =='#string'
    Then match response.products =='#array'
    Then match response.title =='#string'
    Then match response.subtext =='#string'
    Then match response.content =='#string'
    Then match response.newsId =='#number'
    Then match response.ampContent =='#string'
    Then match response.tags =='#array'
    Then match response.updated =='#string'
    Then match response.created =='#string'
#
##   Assertion key values
#
    Then match response.deleted == false
    Then match response.title == articleName
    Then match response.subtext == createArticlePayload.subtext
    Then match response.content == ''
    Then match response.author.id == userInfo.authorId[0]
    Then match response.author.lastName == userInfo.authorLastName[0]
    Then match response.author.email == userInfo.authorEmail[0]
    Then match response.newsId == articleId
#    Then match response.ampContent == '6098f6a87d3dc00010eaa19c'
    Then match response.tags == '#[0]'
#    Then match response.updated == ''
#    Then match response.created == ''

  ##  Delete Article Action
#
    Given url api_news_host + '/api/news/' + articleId
    Given header authorization = 'Bearer ' + access_token
    When method delete
    Then status 204
#
##  Check Delete Article Action
#
    Given url api_news_host + '/api/news/' + articleId
    Given header authorization = 'Bearer ' + access_token
    When method get
    Then status 404
    Then match response.message == 'News with id ' + articleId + ' is not found.'
    Then match response.errors[0].slug == '#string'
    Then match response.errors[0].message == '#string'
    Then match response.errors[0].details.path == '#string'
