Feature: Create and Delete Article
Background: use token
Given url apiUrl

* def tokenResponse = callonce read('classpath:helpers/CreateToken.feature')
* def token = tokenResponse.authToken
* def articlerequest = read('classpath:json/CreateArticle.json')

Scenario: Create Article
Given header authorization = 'Token ' + token
Given path 'articles'
And request articlerequest
When method post
Then status 201
* def articleId = response.article.slug

Given header authorization = 'Token ' + token
Given path 'articles',articleId
When method Delete
Then status 204

