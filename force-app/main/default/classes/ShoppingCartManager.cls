public with sharing class ShoppingCartManager {

    public ShoppingCart cart {get; set;}
    public ShoppingCartPriceCalculator priceCalculator {get; set;}

    public ShoppingCartManager(ShoppingCartPriceCalculator priceCalculatorParam) {
        cart = new ShoppingCart();
        this.priceCalculator = priceCalculatorParam;

    }
    
    public ShoppingCartManager() {
        cart = new ShoppingCart();
        this.priceCalculator = new SimpleShoppingCartPriceCalculator();

    }

    public void addProductById(String productId) {
        CatalogProduct__c product = [SELECT Id, Name, Price__c 
                                    FROM CatalogProduct__c
                                    WHERE Id = :productId];
        if (cart.cartItemMap.containsKey(product.Id)) {
            cart.cartItemMap.get(product.Id).quantity++;
        }
        else {
            ShoppingCartItem cartItem = new ShoppingCartItem(product);
            cart.cartItemMap.put(product.Id, cartItem);
        }
        cart.totalPrice = priceCalculator.calculateShoppingCartPrice(cart);
    }

    public void increaseQuantityOfProduct(String productId) {
        addProductById(productId);
    }
}
