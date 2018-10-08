public class Utility {
    public static ProductDiscount__c findProductDiscountWithProductIdAndQuantity(List<ProductDiscount__c> productDiscountList, String productId, Integer currentQty) {
        if (productDiscountList == null)
            return null;
        ProductDiscount__c discountFound = null;
        for (ProductDiscount__c productDiscountItem : productDiscountList) {
            if (productDiscountItem.CatalogProduct__c == productId) {
                if (productDiscountItem.DiscountQuantity__c == currentQty)
                    return productDiscountItem;
                List<Integer> multipleList = findMultiples(currentQty);
                if (multipleList.contains(Integer.valueOf(productDiscountItem.DiscountQuantity__c)))
                    return productDiscountItem;
            }
        }
        return discountFound;
    }

    public static List<Integer> findMultiples(Integer numberToDecompose) {
        List<Integer> multipleList = new List<Integer>();
        for (Integer i = numberToDecompose; i > 0; i--)
            if (Math.mod(numberToDecompose, i) == 0)
                multipleList.add(i);
        return multipleList;
    }
}
