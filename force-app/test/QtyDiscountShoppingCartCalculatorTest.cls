@isTest
public with sharing class QtyDiscountShoppingCartCalculatorTest {
    @testSetup
    public static void setupDatas() {
        List<CatalogProduct__c> productBulkInsert = new List<CatalogProduct__c>();
        productBulkInsert.add(new CatalogProduct__c(Name = 'Product test 1', Price__c = 100));
        productBulkInsert.add(new CatalogProduct__c(Name = 'Product test 2', Price__c = 200));
        insert productBulkInsert;

        List<ProductDiscount__c> discountBulkInsert = new List<ProductDiscount__c>();
        discountBulkInsert.add(new ProductDiscount__c(CatalogProduct__c = productBulkInsert.get(0).Id, DiscountPercent__c = 50, DiscountQuantity__c = 5));
        discountBulkInsert.add(new ProductDiscount__c(CatalogProduct__c = productBulkInsert.get(1).Id, DiscountPercent__c = 10, DiscountQuantity__c = 2));
        insert discountBulkInsert;
    }
    
    @isTest
    public static void test_calculateShoppingCartPrice_empty_cart_expect_0() {
        QtyDiscountShoppingCartCalculator priceCalculator = new QtyDiscountShoppingCartCalculator();
        ShoppingCart cart = new ShoppingCart();

        Double actual = priceCalculator.calculateShoppingCartPrice(cart);
        System.assertEquals(0, actual);
    }

    @isTest
    public static void test_calculateShoppingCartPrice_given_product1_expect_100() {
        QtyDiscountShoppingCartCalculator priceCalculator = new QtyDiscountShoppingCartCalculator();
        ShoppingCartManager cartManager = new ShoppingCartManager(priceCalculator);
        CatalogProduct__c product = [SELECT Id FROM CatalogProduct__c WHERE Name = 'Product test 1' LIMIT 1];
        cartManager.addProductById(product.Id);
        Double actual = priceCalculator.calculateShoppingCartPrice(cartManager.cart);

        System.assertEquals(100, actual);
    }

    @isTest
    public static void test_calculateShoppingCartPrice_given_products_1_100_1_200_different_products_expect_300() {
        QtyDiscountShoppingCartCalculator priceCalculator = new QtyDiscountShoppingCartCalculator();
        ShoppingCartManager cartManager = new ShoppingCartManager(priceCalculator);
        CatalogProduct__c product = [SELECT Id FROM CatalogProduct__c WHERE Name = 'Product test 1' LIMIT 1];
        cartManager.addProductById(product.Id);
        CatalogProduct__c product2 = [SELECT Id FROM CatalogProduct__c WHERE Name = 'Product test 2' LIMIT 1];
        cartManager.addProductById(product2.Id);

        Double actual = priceCalculator.calculateShoppingCartPrice(cartManager.cart);
        
        System.assertEquals(300, actual);
    }

    @isTest
    public static void test_calculateShoppingCartPrice_given_products_5_100_expect_50_percent_off_5_so_450() {
        QtyDiscountShoppingCartCalculator priceCalculator = new QtyDiscountShoppingCartCalculator();
        ShoppingCartManager cartManager = new ShoppingCartManager(priceCalculator);
        CatalogProduct__c product = [SELECT Id FROM CatalogProduct__c WHERE Name = 'Product test 1' LIMIT 1];
        for (Integer i = 0; i < 5; i++)
            cartManager.addProductById(product.Id);
        
        Double actual = priceCalculator.calculateShoppingCartPrice(cartManager.cart);
        
        System.assertEquals(450, actual);
    }

    @isTest
    public static void test_calculateShoppingCartPrice_given_products_3_100_5_200_different_products_expect_1260() {
        QtyDiscountShoppingCartCalculator priceCalculator = new QtyDiscountShoppingCartCalculator();
        ShoppingCartManager cartManager = new ShoppingCartManager(priceCalculator);
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

        Double actual = priceCalculator.calculateShoppingCartPrice(cartManager.cart);
        
        System.assertEquals(1260, actual);
    }

    @isTest
    public static void test_calculateShoppingCartPrice_given_products_22_100_13_200_different_products_expect_4480() {
        QtyDiscountShoppingCartCalculator priceCalculator = new QtyDiscountShoppingCartCalculator();
        ShoppingCartManager cartManager = new ShoppingCartManager(priceCalculator);
        CatalogProduct__c product = [SELECT Id FROM CatalogProduct__c WHERE Name = 'Product test 1' LIMIT 1];
        cartManager.addProductById(product.Id);
        for (Integer i = 0; i < 21; i++)
            cartManager.increaseQuantityOfProduct(product.Id);

        CatalogProduct__c product2 = [SELECT Id FROM CatalogProduct__c WHERE Name = 'Product test 2' LIMIT 1];
        cartManager.addProductById(product2.Id);
        for (Integer i = 0; i < 12; i++)
            cartManager.increaseQuantityOfProduct(product2.Id);
        
        Double actual = priceCalculator.calculateShoppingCartPrice(cartManager.cart);
        
        System.assertEquals(4480, actual);
    }
}
