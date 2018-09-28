public with sharing class ShoppingCartManager {

    public ShoppingCart cart {get; set;}

    public ShoppingCartManager() {
        cart = new ShoppingCart();
    }

    public void addProductById(String productId) {
        CatalogProduct__c product = [SELECT Id, Name, Price__c 
                                    FROM CatalogProduct__c
                                    WHERE Id = :productId];
        cart.products.add(product);
        calculateCartTotalPrice();
    }

    private void calculateCartTotalPrice() {
        Double totalPrice = 0;
        for (CatalogProduct__c product : cart.products) {
            totalPrice += product.Price__c;
        }
        cart.totalPrice = totalPrice;
    }

}
