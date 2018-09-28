public with sharing class ShoppingCartManager {

    public ShoppingCart cart {get; set;}

    public ShoppingCartManager() {
        cart = new ShoppingCart();
    }

    public void addProductById(String productId) {
        CatalogProduct__c product = [SELECT Id, Name, Price__c 
                                    FROM CatalogProduct__c
                                    WHERE Id = :productId];
        if (cart.cartItemMap.containsKey(product.Id))
            cart.cartItemMap.get(product.Id).quantity++;
        else {
            ShoppingCartItem cartItem = new ShoppingCartItem(product);
            cart.cartItemMap.put(product.Id, cartItem);
        }
        calculateCartTotalPrice();
    }

    public void increaseQuantityOfProduct(String productId) {
        addProductById(productId);
    }

    private void calculateCartTotalPrice() {
        Double totalPrice = 0;
        for (String keyProductId : cart.cartItemMap.keySet()) {
            totalPrice += cart.cartItemMap.get(keyProductId).product.Price__c * cart.cartItemMap.get(keyProductId).quantity;
        }
        cart.totalPrice = totalPrice;
    }



}
