public class ShoppingCart {
    public List<CatalogProduct__c> products {get; set;}
    public Double totalPrice {get; set;}

    public ShoppingCart() {
        products = new List<CatalogProduct__c>();
        totalPrice = 0;
    }
}