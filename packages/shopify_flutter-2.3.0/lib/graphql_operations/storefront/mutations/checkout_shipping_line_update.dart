/// Mutation to update the shipping line of a checkout
const String checkoutShippingLineUpdateMutation = r'''
mutation checkoutShippingLineUpdate($checkoutId: ID!, $shippingRateHandle: String!) {
  checkoutShippingLineUpdate(checkoutId: $checkoutId, shippingRateHandle: $shippingRateHandle) {
    checkout {
      id
      ready
      email
      appliedGiftCards {
        amountUsedV2 {
          amount
          currencyCode
        }
        balanceV2 {
          amount
          currencyCode
        }
        id
      }
      requiresShipping
      shippingLine {
        handle
        priceV2 {
          amount
          currencyCode
        }
        title
      }
      availableShippingRates {
        ready
        shippingRates {
          handle
          title
          priceV2 {
            amount
            currencyCode
          }
        }
      }
      shippingAddress {
        address1
        address2
        city
        company
        country
        countryCodeV2
        firstName
        formattedArea
        id
        lastName
        latitude
        longitude
        name
        phone
        province
        provinceCode
        zip
      }
      completedAt
      createdAt
      currencyCode
      lineItems(first: 250) {
        edges {
          node {
            id
            quantity
            title
            customAttributes {
                key
                value
            }
            discountAllocations {
              allocatedAmount {
                amount
                currencyCode
              }
            }
            variant {
              id
              priceV2 {
                amount
                currencyCode
              }
              title
              image {
                altText
                originalSrc
                id
              }
              compareAtPriceV2 {
                amount
                currencyCode
              }
              weight
              weightUnit
              availableForSale
              quantityAvailable
              sku
              requiresShipping
              product {
                options(first: 5) {
                    id
                    name
                    values
                    } 
                variants(first: 250) {
                  edges {
                    node {
                      id
                      title
                      image {
                        altText
                        id
                        originalSrc
                      }
                      priceV2 {
                        amount
                        currencyCode
                      }
                      compareAtPriceV2 {
                        amount
                        currencyCode
                      }
                      weight
                      weightUnit
                      availableForSale
                      sku
                      requiresShipping
                      quantityAvailable
                      selectedOptions {
                        name
                        value
                      }
                    }
                  }
                  pageInfo {
                    hasNextPage
                  }
                }
                availableForSale
                collections(first: 5) {
                  edges {
                    node {
                      description
                      descriptionHtml
                      id
                      handle
                      updatedAt
                      title
                    }
                  }
                }
                createdAt
                description
                descriptionHtml
                handle
                id
                onlineStoreUrl
                productType
                publishedAt
                tags
                title
                updatedAt
                vendor
                images(first: 5) {
                  edges {
                    node {
                      altText
                      id
                      originalSrc
                    }
                  }
                }
                media(first: 250) {
                  edges {
                    node {
                      alt
                      id
                      mediaContentType
                      previewImage {
                        altText
                        id
                        originalSrc
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
      note
      webUrl
      updatedAt
      totalTaxV2 {
        amount
        currencyCode
      }
      totalPriceV2 {
        amount
        currencyCode
      }
      taxesIncluded
      taxExempt
      subtotalPriceV2 {
        amount
        currencyCode
      }
      orderStatusUrl
      order {
        id
      }
    }
    checkoutUserErrors {
      code
      field
      message
    }
  }
}
''';
