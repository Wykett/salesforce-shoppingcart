public with sharing class SimpleShoppingCartPriceCalculator implements ShoppingCartPriceCalculator {
    public Double calculateShoppingCartPrice(ShoppingCart cart) {
        Double totalPrice = 0;
        if (cart.cartItemMap == null)
            return 0;
        for (String keyProductId : cart.cartItemMap.keySet()) {
            totalPrice += cart.cartItemMap.get(keyProductId).product.Price__c * cart.cartItemMap.get(keyProductId).quantity;
        }
        return totalPrice;
    }
}
