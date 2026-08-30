Feature: Create Token

Background: Define url
    Given url apiUrl

Scenario: Login to the application
    Given path 'users/login'    
    And request {"user":{"email":"admin@test1.com","password":"admin@123"}}
    When method post
    Then status 200
    * def authToken = response.user.token
    * print authToken