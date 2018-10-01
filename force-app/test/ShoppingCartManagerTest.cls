@isTest
public with sharing class ShoppingCartManagerTest {
    @testSetup
    public static void setupDatas() {
        List<CatalogProduct__c> productBulkInsert = new List<CatalogProduct__c>();
        productBulkInsert.add(new CatalogProduct__c(Name = 'Product test 1', Price__c = 100));
        productBulkInsert.add(new CatalogProduct__c(Name = 'Product test 2', Price__c = 200));
        insert productBulkInsert;
    }

    @isTest
    public static void test_given_nothing_expect_emptycart() {
        ShoppingCartManager cartManager = new ShoppingCartManager();
        ShoppingCart actual = cartManager.cart;
        
        System.assertEquals(0, actual.cartItemMap.size());
    }

    @isTest
    public static void test_given_one_product_expect_cart_with_one_product() {
        ShoppingCartManager cartManager = new ShoppingCartManager();
        CatalogProduct__c product = [SELECT Id FROM CatalogProduct__c WHERE Name = 'Product test 1' LIMIT 1];
        cartManager.addProductById(product.Id);
        ShoppingCart actual = cartManager.cart;

        System.assertEquals(1, actual.cartItemMap.size());
    }

    @isTest
    public static void test_given_one_product_price_100_expect_cart_total_price_100() {
        ShoppingCartManager cartManager = new ShoppingCartManager();
        CatalogProduct__c product = [SELECT Id FROM CatalogProduct__c WHERE Name = 'Product test 1' LIMIT 1];
        cartManager.addProductById(product.Id);
        ShoppingCart actual = cartManager.cart;

        System.assertEquals(1, actual.cartItemMap.size());
        System.assertEquals(100, actual.totalPrice);
    }

    @isTest
    public static void test_given_product_price_100_other_200_expect_cart_total_price_300() {
        ShoppingCartManager cartManager = new ShoppingCartManager();
        CatalogProduct__c product = [SELECT Id FROM CatalogProduct__c WHERE Name = 'Product test 1' LIMIT 1];
        cartManager.addProductById(product.Id);
        product = [SELECT Id FROM CatalogProduct__c WHERE Name = 'Product test 2' LIMIT 1];
        cartManager.addProductById(product.Id);
        ShoppingCart actual = cartManager.cart;

        System.assertEquals(2, actual.cartItemMap.size());
        System.assertEquals(300, actual.totalPrice);
    }

    @isTest
    public static void test_given_add_2_times_same_expect_cart_total_price_200() {
        ShoppingCartManager cartManager = new ShoppingCartManager();
        CatalogProduct__c product = [SELECT Id FROM CatalogProduct__c WHERE Name = 'Product test 1' LIMIT 1];
        cartManager.addProductById(product.Id);
        cartManager.addProductById(product.Id);
        ShoppingCart actual = cartManager.cart;

        System.assertEquals(1, actual.cartItemMap.size());
        System.assertEquals(2, actual.cartItemMap.get(product.Id).quantity);
        System.assertEquals(200, actual.totalPrice);
    }

    @isTest
    public static void test_given_add_1_add_2_quantity_expect_cart_total_price_300() {
        ShoppingCartManager cartManager = new ShoppingCartManager();
        CatalogProduct__c product = [SELECT Id FROM CatalogProduct__c WHERE Name = 'Product test 1' LIMIT 1];
        cartManager.addProductById(product.Id);
        cartManager.increaseQuantityOfProduct(product.Id);
        ShoppingCart actual = cartManager.cart;

        System.assertEquals(1, actual.cartItemMap.size());
        System.assertEquals(2, actual.cartItemMap.get(product.Id).quantity);
        System.assertEquals(200, actual.totalPrice);
    }

    @isTest
    public static void test_given_add_2_products_add_3_5_quantity_expect_cart_total_price_1300() {
        ShoppingCartManager cartManager = new ShoppingCartManager();
        CatalogProduct__c product = [SELECT Id FROM CatalogProduct__c WHERE Name = 'Product test 1' LIMIT 1];
        cartManager.addProductById(product.Id);
        cartManager.increaseQuantityOfProduct(product.Id);
        cartManager.increaseQuantityOfProduct(product.Id);
        CatalogProduct__c product2 = [SELECT Id FROM CatalogProduct__c WHERE Name = 'Product test 2' LIMIT 1];
        cartManager.addProductById(product2.Id);
        cartManager.increaseQuantityOfProduct(product2.Id);
        cartManager.increaseQuantityOfProduct(product2.Id);
        cartManager.increaseQuantityOfProduct(product2.Id);
        cartManager.increaseQuantityOfProduct(product2.Id);
        ShoppingCart actual = cartManager.cart;

        System.assertEquals(2, actual.cartItemMap.size());
        System.assertEquals(3, actual.cartItemMap.get(product.Id).quantity);
        System.assertEquals(5, actual.cartItemMap.get(product2.Id).quantity);
        System.assertEquals(1300, actual.totalPrice);
    }
}
