@isTest
public with sharing class ShoppingCartManagerTest {
    @isTest
    public static void test_given_nothing_expect_emptycart() {
        ShoppingCartManager manager = new ShoppingCartManager();
        ShoppingCart actual = manager.cart;
        
        System.assertEquals(0, actual.products.size());
    }
}
