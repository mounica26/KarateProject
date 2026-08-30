Feature: Get the list of articles

Background: Define url

* url apiUrl
#* def loop = karate.repeat(2,()=>karate.call("classpath:helpers/CreateToken.feature"))

Scenario: Article list and schema validation
Given params {limit:10, offset:0}
Given path 'articles'
When method Get
Then status 200
And match response.articles[0] ==
"""
{
            "slug": "#string",
            "title": "#string",
            "description": "#string",
            "body": "#string",
            "tagList": 
                "#array"
            ,
            "createdAt": "#regex ^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\.\\d{3}Z$",
            "updatedAt": "#regex ^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\.\\d{3}Z$",
            "favorited": #boolean,
            "favoritesCount": #number,
            "author": {
                "username": "#string",
                "bio": ##string,
                "image": "#string",
                "following": #boolean
            }
        }
"""
@ignore


Scenario: Conditional logic
Given params {limit:10, offset:0}
Given path 'articles'
When method Get
Then status 200

* def favCount = response.articles[0].favoritesCount
* print favCount
* def article1 = response.articles[0]

* if(favCount == 0) karate.call('classpath:helpers/AddLikes.feature',article1)

Given params {limit:10, offset:0}
Given path 'articles'
When method Get
Then status 200
And match response.articles[0].favoritesCount == 2217

@ignore

Scenario: Retry

* configure retry = {count:5,interval:5000}

Given params {limit:10, offset:0}
Given path 'articles'
And retry until response.articles[0].favoritesCount == 2218
When method Get
Then status 200