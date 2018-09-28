public class ShoppingCart {
    public List<CatalogProduct__c> products {get; set;}

    public ShoppingCart() {
        products = new List<CatalogProduct__c>();
    }
}