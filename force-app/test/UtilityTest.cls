@isTest
public with sharing class UtilityTest {
    @TestSetup
    static void setUp() {
      List<CatalogProduct__c> productBulkInsert = new List<CatalogProduct__c>();
        productBulkInsert.add(new CatalogProduct__c(Name = 'Product test 1', Price__c = 100));
        productBulkInsert.add(new CatalogProduct__c(Name = 'Product test 2', Price__c = 200));
        insert productBulkInsert;

        List<ProductDiscount__c> discountBulkInsert = new List<ProductDiscount__c>();
        discountBulkInsert.add(new ProductDiscount__c(CatalogProduct__c = productBulkInsert.get(0).Id, DiscountPercent__c = 50, DiscountQuantity__c = 1));
        discountBulkInsert.add(new ProductDiscount__c(CatalogProduct__c = productBulkInsert.get(0).Id, DiscountPercent__c = 50, DiscountQuantity__c = 5));
        discountBulkInsert.add(new ProductDiscount__c(CatalogProduct__c = productBulkInsert.get(1).Id, DiscountPercent__c = 50, DiscountQuantity__c = 50));
        insert discountBulkInsert;
    }

    @isTest
    public static void test_findMultiples_given_1_expect_1() {
        List<Integer> actual = Utility.findMultiples(1);
        System.assertEquals(new List<Integer>{1}, actual);
    }

    @isTest
    public static void test_findMultiples_given_2_expect_2_1() {
        List<Integer> actual = Utility.findMultiples(2);
        System.assertEquals(new List<Integer>{2,1}, actual);
    }

    @isTest
    public static void test_findMultiples_given_12_expect_12_6_4_3_2_1() {
        List<Integer> actual = Utility.findMultiples(12);
        System.assertEquals(new List<Integer>{12,6,4,3,2,1}, actual);
    }

    @isTest
    public static void test_findProductDiscountWithProductIdAndQuantity_given_null_expect_null() {
        ProductDiscount__c actual = Utility.findProductDiscountWithProductIdAndQuantity(null, '0', 0);
        ProductDiscount__c expected = null;
        System.assertEquals(expected, actual);
    }

    @isTest
    public static void test_findProductDiscountWithProductIdAndQuantity_given_empty_expect_null() {
        ProductDiscount__c actual = Utility.findProductDiscountWithProductIdAndQuantity(new List<ProductDiscount__c>(), '0', 0);
        ProductDiscount__c expected = null;
        System.assertEquals(expected, actual);
    }

    @isTest
    public static void test_findProductDiscountWithProductIdAndQuantity_given_productId1_qty_1_expect_discount_foundound() {
        CatalogProduct__c product = [SELECT Id FROM CatalogProduct__c WHERE Name = 'Product test 1' LIMIT 1];
        List<ProductDiscount__c> productDiscountList = [SELECT CatalogProduct__c, DiscountPercent__c, DiscountQuantity__c
                                                        FROM ProductDiscount__c];
        ProductDiscount__c actual = Utility.findProductDiscountWithProductIdAndQuantity(productDiscountList, product.Id, 1);
        ProductDiscount__c expected = null;
        System.assertNotEquals(expected, actual);
    }

    @isTest
    public static void test_findProductDiscountWithProductIdAndQuantity_given_productId1_qty_10_expect_null() {
        CatalogProduct__c product = [SELECT Id FROM CatalogProduct__c WHERE Name = 'Product test 2' LIMIT 1];
        List<ProductDiscount__c> productDiscountList = [SELECT CatalogProduct__c, DiscountPercent__c, DiscountQuantity__c
                                                        FROM ProductDiscount__c];
        ProductDiscount__c actual = Utility.findProductDiscountWithProductIdAndQuantity(productDiscountList, product.Id, 10);
        ProductDiscount__c expected = null;
        System.assertEquals(expected, actual);
    }

    @isTest
    public static void test_findProductDiscountWithProductIdAndQuantity_given_productId2_qty_50_expect_discount_found() {
        CatalogProduct__c product = [SELECT Id FROM CatalogProduct__c WHERE Name = 'Product test 2' LIMIT 1];
        List<ProductDiscount__c> productDiscountList = [SELECT CatalogProduct__c, DiscountPercent__c, DiscountQuantity__c
                                                        FROM ProductDiscount__c];
        ProductDiscount__c actual = Utility.findProductDiscountWithProductIdAndQuantity(productDiscountList, product.Id, 50);
        ProductDiscount__c expected = null;
        System.assertNotEquals(expected, actual);
    }
}
