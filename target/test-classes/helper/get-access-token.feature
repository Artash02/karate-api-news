Feature: Get Access token

  Scenario: Get Access token

    * def auth_url = function() { return java.lang.System.getenv('API_AUTH_HOST') + '' }
    * print 'AUTH      ' + auth_url()
    Given url 'https://api-admins.priotix.xyz' + '/auth/login?rememberMe=true'
    And request __arg
    When method post
    Then status 200
    And def token = response.accessToken
    * print token

