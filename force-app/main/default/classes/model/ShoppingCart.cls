public class ShoppingCart {
    public Map<Id, ShoppingCartItem> cartItemMap {get; set;}
    public Double totalPrice {get; set;}

    public ShoppingCart() {
        cartItemMap = new Map<Id, ShoppingCartItem>();
        totalPrice = 0;
    }
}