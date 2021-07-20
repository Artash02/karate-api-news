Feature: Verify the JSON Schema validation, Verify the Field Type

  Background: Generate Current Time Stamp and payload.

    Given def currentTimeStamp = function() { return java.lang.System.currentTimeMillis() + '' }
#    Given def payload =
#  """
#  function(actionName) {
#    var dbUtils = Java.type('utils.DbUtils');
#    var payload = new dbUtils();
#    return payload.getPayload(actionName);
#  }
#  """
#
#  Scenario: CRUD model for Article
#
##   Create Article
#
#    Given def userInfo = call read('file:src/test/java/helper/get-user-info.feature')
#    Given def createArticlePayload = call payload 'create-article'
#    * print 'API_NEWSSS' + api_news_host
#    Given url api_news_host + '/api/news'
#    And header authorization = 'Bearer ' + access_token
#    And def articleName = 'article_title_api_test' + currentTimeStamp()
#    * print 'ARTICLE NAME ' + articleName
#    And set createArticlePayload.title = articleName
#    Given request createArticlePayload
#    When method post
#    * print 'CREATE' + createArticlePayload.title == ''
#    * print 'RESPONSE' + response
#    Then status 201
#
##   Assert Key types
#    Then match response.newsId == '#number'
#    Then match response.deleted == '#boolean'
#    Then match response.subtext == '#string'
#    Then match response.author.firstName == '#string'
#    Then match response.author.lastName == '#string'
#    Then match response.author.id == '#string'
#    Then match response.author.email == '#string'
#    Then match response.created == '#string'
#    Then match response.title == '#string'
#    Then match response.updated == '#string'
#    Then match response.content == ''
#    Then match response.products == '#array'
#
###   Assert key values
#    Then match response.deleted == false
#    Then match response.title == articleName
#    Then match response.subtext == createArticlePayload.subtext
#    Then match response.content == ''
#    Then match response.author.id == userInfo.authorId[0]
#    Then match response.author.lastName == userInfo.authorLastName[0]
#    Then match response.author.email == userInfo.authorEmail[0]
##    Then match response.ampContent == '60af7edd6ce2cf0010afc6f6'
#    Then match response.tags == '#[0]'
##    Then match response.updated == ''
##    Then match response.created == ''
##
#    And def articleId = response.newsId
##
###   Get created Article (Check Create Article option)
#
#    Given url api_news_host + '/api/news/' + articleId
#    Given header authorization = 'Bearer ' + access_token
#    When method get
#    Then status 200
#
###   Assert Key types
#    Then match response.id == '#string'
#    Then match response.author.id =='#string'
#    Then match response.author.firstName =='#string'
#    Then match response.author.lastName =='#string'
#    Then match response.author.email =='#string'
#    Then match response.products =='#array'
#    Then match response.title =='#string'
#    Then match response.subtext =='#string'
#    Then match response.content =='#string'
#    Then match response.newsId =='#number'
#    Then match response.ampContent =='#string'
#    Then match response.tags =='#array'
#    Then match response.updated =='#string'
#    Then match response.created =='#string'
##
###   Assertion key values
##
#    Then match response.deleted == false
#    Then match response.title == articleName
#    Then match response.subtext == createArticlePayload.subtext
#    Then match response.content == ''
#    Then match response.author.id == userInfo.authorId[0]
#    Then match response.author.lastName == userInfo.authorLastName[0]
#    Then match response.author.email == userInfo.authorEmail[0]
#    Then match response.newsId == articleId
##    Then match response.ampContent == '6098f6a87d3dc00010eaa19c'
#    Then match response.tags == '#[0]'
##    Then match response.updated == ''
##    Then match response.created == ''
##
##
###   Update Created Article
##
#    Given def updateArticlePayload = call payload 'add-content'
#    And def articleNameEdit = 'article_title_api_test_edit' + currentTimeStamp()
#    * print 'ARTICLE NAME EDIT' + articleNameEdit
#    And set updateArticlePayload.title = articleNameEdit
#    Given url api_news_host + '/api/news/' + articleId
#    Given header authorization = 'Bearer ' + access_token
#    Given request updateArticlePayload
#    When method put
#    Then status 200
##
###   Assert Key types
#    Then match response.subtext == '#string'
#    Then match response.title == '#string'
#    Then match response.content == '#string'
##
###   Assert Key values
#    Then match response.subtext == createArticlePayload.subtext
#    Then match response.title == articleNameEdit
#    Then match response.content == updateArticlePayload.content
##
###  Check Update Article Action
##
###   Assert Key Types
#    Given url api_news_host + '/api/news/' + articleId
#    Given header authorization = 'Bearer ' + access_token
#    When method get
#    Then status 200
#    Then match articleNameEdit == response.title
#    Then response.newsId == '#number'
#    Then response.deleted == '#boolean'
#    Then response.subtext == '#string'
#    Then response.author.firstName == '#string'
#    Then response.author.lastName == '#string'
#    Then response.author.id == '#string'
#    Then response.author.email == '#string'
#    Then response.created == '#string'
#    Then response.id == '#string'
#    Then response.title == '#string'
#    Then response.updated == '#string'
#    Then response.content == '#string'
#    Then response.products == '#string'
#    Then response.ampContent == '#string'
#    Then response.tags == '#array'
##
###   Assert key values
#    Then match response.deleted == false
#    Then match response.title == articleNameEdit
#    Then match response.subtext == updateArticlePayload.subtext
#    Then match response.content == '<p>content-api-test-edit</p>'
#    Then match response.author.id == userInfo.authorId[0]
#    Then match response.author.lastName == userInfo.authorLastName[0]
#    Then match response.author.email == userInfo.authorEmail[0]
#    Then match response.newsId == articleId
##    Then match response.ampContent == '6098f6a87d3dc00010eaa19c'
#    Then match response.tags == '#[0]'
##    Then match response.updated == ''
##    Then match response.created == ''
#
##   Upload Image
#
#    Given url api_news_host + '/api/news/' + articleId
#    Given def setImagePayload = call payload 'set-image'
#    Given request setImagePayload
#    Given header authorization = 'Bearer ' + access_token
#    When method put
#    Then status 200
#    * print 'UPLOAD IMAGE' + response
#
###   Assert Key types
#
#    Then match response.images.default.filePath == '#string'
#    Then match response.images.cropDesktop.filePath == '#string'
#    Then match response.images.cropMobile.filePath == '#string'
#    Then match response.images.caption == '#string'
#    Then match response.images.credit == '#string'
#
###   Assert Key values
#
#    Then match response.images.default.filePath == 'news/d0379e4d73faa565d3e7f22b307c80f7/1063973d10add18c8225806f32cde76e/original.png'
#    Then match response.images.cropDesktop.filePath == 'news/d0379e4d73faa565d3e7f22b307c80f7/1063973d10add18c8225806f32cde76e/original.png'
#    Then match response.images.cropMobile.filePath == 'news/d0379e4d73faa565d3e7f22b307c80f7/1063973d10add18c8225806f32cde76e/original.png'
#    Then match response.images.caption == ''
#    Then match response.images.credit == ''
#
###  Get Article For Checking Upload Image functionality
#
#    Given url api_news_host + '/api/news/' + articleId
#    Given header authorization = 'Bearer ' + access_token
#    When method get
#    Then status 200
#
###  Assert Key types
#
#    Then match response.images.default.filePath == '#string'
#    Then match response.images.cropDesktop.filePath == '#string'
#    Then match response.images.cropMobile.filePath == '#string'
#    Then match response.images.caption == '#string'
#    Then match response.images.credit == '#string'
#
###  Assert Key values
#
#    Then match response.images.default.filePath == 'news/d0379e4d73faa565d3e7f22b307c80f7/1063973d10add18c8225806f32cde76e/original.png'
#    Then match response.images.cropDesktop.filePath == 'news/d0379e4d73faa565d3e7f22b307c80f7/1063973d10add18c8225806f32cde76e/original.png'
#    Then match response.images.cropMobile.filePath == 'news/d0379e4d73faa565d3e7f22b307c80f7/1063973d10add18c8225806f32cde76e/original.png'
#    Then match response.images.caption == ''
#    Then match response.images.credit == ''
#
###  Edit Image
#
#    Given url api_news_host + '/api/news/' + articleId
#    Given def editImagePayload = call payload 'set-image'
#    Given request editImagePayload
#    Given header authorization = 'Bearer ' + access_token
#    When method put
#    Then status 200
#
###   Assert Key types
#
#    Then match response.images.default.filePath == '#string'
#    Then match response.images.cropDesktop.filePath == '#string'
#    Then match response.images.cropMobile.filePath == '#string'
#    Then match response.images.caption == '#string'
#    Then match response.images.credit == '#string'
#
###   Assert Key values
#
#    Then match response.images.default.filePath == 'news/d0379e4d73faa565d3e7f22b307c80f7/1063973d10add18c8225806f32cde76e/original.png'
#    Then match response.images.cropDesktop.filePath == 'news/d0379e4d73faa565d3e7f22b307c80f7/1063973d10add18c8225806f32cde76e/original.png'
#    Then match response.images.cropMobile.filePath == 'news/d0379e4d73faa565d3e7f22b307c80f7/1063973d10add18c8225806f32cde76e/original.png'
#    Then match response.images.caption == ''
#    Then match response.images.credit == ''
#
###  Get Article For Checking Edit Image functionality
#
#    Given url api_news_host + '/api/news/' + articleId
#    Given header authorization = 'Bearer ' + access_token
#    When method get
#    Then status 200
#
###   Assert Key types
#
#    Then match response.images.default.filePath == '#string'
#    Then match response.images.cropDesktop.filePath == '#string'
#    Then match response.images.cropMobile.filePath == '#string'
#    Then match response.images.caption == '#string'
#    Then match response.images.credit == '#string'
#
###   Assert Key values
#
#    Then match response.images.default.filePath == 'news/d0379e4d73faa565d3e7f22b307c80f7/1063973d10add18c8225806f32cde76e/original.png'
#    Then match response.images.cropDesktop.filePath == 'news/d0379e4d73faa565d3e7f22b307c80f7/1063973d10add18c8225806f32cde76e/original.png'
#    Then match response.images.cropMobile.filePath == 'news/d0379e4d73faa565d3e7f22b307c80f7/1063973d10add18c8225806f32cde76e/original.png'
#    Then match response.images.caption == ''
#    Then match response.images.credit == ''
#
##   Add Channel
#
#    Given url api_news_host + '/api/news/' + articleId
#    Given def setChannelPayload = call payload 'add-channel'
#    Given header authorization = 'Bearer ' + access_token
#    Given request setChannelPayload
#    When method put
#    Then status 200
#    * print 'ADD CHANNEL' + response
#
###   Assert Key Types
#
#    Then match response.products == '#array'
#
### Assert Key Types
#
#    Then match response.products == [6]
#
###  Get Article For Checking Add Channel functionality
#
#    Given url api_news_host + '/api/news/' + articleId
#    Given header authorization = 'Bearer ' + access_token
#    When method get
#    Then status 200
#
#    ##   Assert Key Types
#
#    Then match response.products == '#array'
#
### Assert Key Types
#
#    Then match response.products == [6]
#
##   Publish Article
#
#    Given url api_news_host + '/api/news/status/' + articleId
#    Given def publishArticlePayload = call payload 'publish-article'
#    Given header authorization = 'Bearer ' + access_token
#    Given request publishArticlePayload
#    When method put
#    Then status 200
#
###  Assert Key Types
#
#    Then match response.status == '#string'
#
###  Assert Key value
#
#    Then match response.status == 'published'
#
#
###  Get Article For Checking Publish Article functionality
#
#    Given url api_news_host + '/api/news/' + articleId
#    Given def setChannelPayload = call payload 'add-channel'
#    Given header authorization = 'Bearer ' + access_token
#    When method get
#
###  Assert Key Types
#
#    Then match response.status == '#string'
#
###  Assert Key value
#
#    Then match response.status == 'published'