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
            for (Integer currentQty = 1; currentQty <= cart.cartItemMap.get(keyProductId).quantity; currentQty++) {
                ProductDiscount__c currentDiscount = Utility.findProductDiscountWithProductIdAndQuantity(productDiscountList, keyProductId, currentQty);
                if (currentDiscount == null)
                    totalPrice += cart.cartItemMap.get(keyProductId).product.Price__c;
                else
                    totalPrice += cart.cartItemMap.get(keyProductId).product.Price__c * (100 - currentDiscount.DiscountPercent__c) / 100;
            }
        }
        return totalPrice;
    }

}
