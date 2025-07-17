/// Mutation to create a checkout
String createCheckoutMutation = r'''
mutation checkoutCreate($input: CheckoutCreateInput!) {
  checkoutCreate(input: $input) {
    checkoutUserErrors {
      code
      field
      message
    }
    checkout {
      id
      webUrl
      lineItems(first: 250) {
        edges {
          node {
            id
            quantity
            title
            variant {
              id
              priceV2 {
                amount
                currencyCode
              }
              title
              image {
                originalSrc
              }
            }
          }
        }
      }
      subtotalPriceV2 {
        amount
        currencyCode
      }
      totalTaxV2 {
        amount
        currencyCode
      }
      totalPriceV2 {
        amount
        currencyCode
      }
      completedAt
      createdAt
      currencyCode
      orderStatusUrl
    }
  }
}

''';
