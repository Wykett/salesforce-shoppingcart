@isTest
public with sharing class ShoppingCartManagerTest {
    @testSetup
    public static void setupDatas() {
        CatalogProduct__c product = new CatalogProduct__c(Name = 'Product test 1', Price__c = 100);
        insert product;
    }

    @isTest
    public static void test_given_nothing_expect_emptycart() {
        ShoppingCartManager cartManager = new ShoppingCartManager();
        ShoppingCart actual = cartManager.cart;
        
        System.assertEquals(0, actual.products.size());
         
    }

    @isTest
    public static void test_given_one_product_expect_cart_with_one_product() {
        ShoppingCartManager cartManager = new ShoppingCartManager();
        CatalogProduct__c product = [SELECT Id FROM CatalogProduct__c WHERE Name = 'Product test 1' LIMIT 1];
        cartManager.addProductById(product.Id);
        ShoppingCart actual = cartManager.cart;

        System.assertEquals(1, actual.products.size());
    }

    @isTest
    public static void test_given_one_product_price_100_expect_cart_total_price_100() {
        ShoppingCartManager cartManager = new ShoppingCartManager();
        CatalogProduct__c product = [SELECT Id FROM CatalogProduct__c WHERE Name = 'Product test 1' LIMIT 1];
        cartManager.addProductById(product.Id);
        ShoppingCart actual = cartManager.cart;

        System.assertEquals(1, actual.products.size());
    }
}
