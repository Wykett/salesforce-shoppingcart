public with sharing class QtyDiscountShoppingCartCalculator implements ShoppingCartPriceCalculator {
    public Double calculateShoppingCartPrice(ShoppingCart cart) {
        Double totalPrice = 0;
        if (cart.cartItemMap == null)
            return 0;
        Set<Id> productIdSet = cart.cartItemMap.keySet();
        List<ProductDiscount__c> productDiscountList = [SELECT CatalogProduct__c, DiscountPercent__c, DiscountQuantity__c
                                                        FROM ProductDiscount__c];
        if (productDiscountList == null)
            productDiscountList = new List<ProductDiscount__c>();
        
        for (String keyProductId : cart.cartItemMap.keySet()) {
            List<ProductDiscount__c> currentDiscount = findProductDiscountWithProductId(productDiscountList, keyProductId);
            totalPrice += cart.cartItemMap.get(keyProductId).product.Price__c * cart.cartItemMap.get(keyProductId).quantity;
        }
        return totalPrice;
    }

public List<ProductDiscount__c> findProductDiscountWithProductId(List<ProductDiscount__c> productDiscountList, String productId) {
    List<ProductDiscount__c> newProductDiscountList = new List<ProductDiscount__c>();
    for (ProductDiscount__c productDiscountItem : productDiscountList)
        if (productDiscountItem.CatalogProduct__c == productId)
            newProductDiscountList.add(productDiscountItem);
    return newProductDiscountList;
}

}
