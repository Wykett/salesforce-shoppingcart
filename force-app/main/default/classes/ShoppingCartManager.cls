public with sharing class ShoppingCartManager {

    public ShoppingCart cart {get; set;}

    public ShoppingCartManager() {
        cart = new ShoppingCart();
    }
}
