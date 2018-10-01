@isTest
public class SimpleShoppingCartPriceCalculatorTest {
    @testSetup
    public static void setupDatas() {
        List<CatalogProduct__c> productBulkInsert = new List<CatalogProduct__c>();
        productBulkInsert.add(new CatalogProduct__c(Name = 'Product test 1', Price__c = 100));
        productBulkInsert.add(new CatalogProduct__c(Name = 'Product test 2', Price__c = 200));
        insert productBulkInsert;
    }

    @isTest
    public static void test_calculateShoppingCartPrice_empty_cart_expect_0() {
        SimpleShoppingCartPriceCalculator priceCalculator = new SimpleShoppingCartPriceCalculator();
        ShoppingCart cart = new ShoppingCart();

        Double actual = priceCalculator.calculateShoppingCartPrice(cart);
        System.assertEquals(0, actual);
    }

    @isTest
    public static void test_calculateShoppingCartPrice_given_product1_expect_100() {
        SimpleShoppingCartPriceCalculator priceCalculator = new SimpleShoppingCartPriceCalculator();
        ShoppingCartManager cartManager = new ShoppingCartManager(priceCalculator);
        CatalogProduct__c product = [SELECT Id FROM CatalogProduct__c WHERE Name = 'Product test 1' LIMIT 1];
        cartManager.addProductById(product.Id);
        Double actual = priceCalculator.calculateShoppingCartPrice(cartManager.cart);

        System.assertEquals(100, actual);
    }

    @isTest
    public static void test_calculateShoppingCartPrice_given_products_1_100_1_200_different_products_expect_300() {
        SimpleShoppingCartPriceCalculator priceCalculator = new SimpleShoppingCartPriceCalculator();
        ShoppingCartManager cartManager = new ShoppingCartManager(priceCalculator);
        CatalogProduct__c product = [SELECT Id FROM CatalogProduct__c WHERE Name = 'Product test 1' LIMIT 1];
        cartManager.addProductById(product.Id);
        CatalogProduct__c product2 = [SELECT Id FROM CatalogProduct__c WHERE Name = 'Product test 2' LIMIT 1];
        cartManager.addProductById(product2.Id);

        Double actual = priceCalculator.calculateShoppingCartPrice(cartManager.cart);
        
        System.assertEquals(300, actual);
    }

    @isTest
    public static void test_calculateShoppingCartPrice_given_products_3_100_5_200_different_products_expect_1300() {
        SimpleShoppingCartPriceCalculator priceCalculator = new SimpleShoppingCartPriceCalculator();
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
        
        System.assertEquals(1300, actual);
    }
}
