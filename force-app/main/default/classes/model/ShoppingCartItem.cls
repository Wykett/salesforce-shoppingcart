public with sharing class ShoppingCartItem {    
    public CatalogProduct__c product {get; set;}
    public Integer quantity {get; set;}

    public ShoppingCartItem(CatalogProduct__c productParam) {
        this.product = productParam;
        this.quantity = 1;
    }
}
