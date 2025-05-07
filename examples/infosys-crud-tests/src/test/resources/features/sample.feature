Feature: Crud operation

  Scenario: Demonstrate POST, GET, UPDATE, DELETE methods
     # Step 1: Create a record in database
    Given url 'https://api.escuelajs.co/api/v1/products'
    * def randomProductId = Math.floor(Math.random() * 400) + 100
    * def title = 'New Karate Product - Debomita' + randomProductId
    * print 'Generated title:', title
    And request
    """
    {
      "title": "#(title)",
      "price": 150,
      "description": "Created via Karate POST",
      "categoryId": 1,
      "images": ["https://placeimg.com/640/480/any"]
    }
    """
    When method post
    Then status 201
    * def productId = response.id
    * print 'Created product is', productId

    # Step 2: Get the record created in database
    Given url 'https://api.escuelajs.co/api/v1/products/' + productId
    When method get
    Then status 200
    * print 'Retrieved product:', response

    # Step 3: Update the record created in database
    Given url 'https://api.escuelajs.co/api/v1/products/' + productId
    And request
    """
    {
      "title": "Change Title",
      "price": 249

    }
    """
    When method put
    Then status 200
    * match response.title == 'Change Title'

    # Step 4: Delete the record created in database
    Given url 'https://api.escuelajs.co/api/v1/products/' + productId
    When method delete
    Then status 200
    * match response contains 'true'

     # Step 5: Get product by ID after Delete
    Given url 'https://api.escuelajs.co/api/v1/products/' + productId
    When method get
    Then status 400




