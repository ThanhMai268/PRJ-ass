/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Objects;

/**
 *
 * @author dungdzpro
 */
public class CartItem {

    private int productId;
    private Integer sizeId;
    private Integer colorId;
    private int quantity;
    private String name;
    private String imageUrl;
    private double price;      // đơn giá
    private String colorName;
    private String sizeValue;

    public CartItem() {
    }

    public CartItem(int productId, Integer sizeId, Integer colorId, int quantity, String name, String imageUrl, long price, String colorName, String sizeValue) {
        this.productId = productId;
        this.sizeId = sizeId;
        this.colorId = colorId;
        this.quantity = quantity;
        this.name = name;
        this.imageUrl = imageUrl;
        this.price = price;
        this.colorName = colorName;
        this.sizeValue = sizeValue;
    }

    public String getColorName() {
        return colorName;
    }

    public void setColorName(String colorName) {
        this.colorName = colorName;
    }

    public String getSizeValue() {
        return sizeValue;
    }

    public void setSizeValue(String sizeValue) {
        this.sizeValue = sizeValue;
    }

    

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public Integer getSizeId() {
        return sizeId;
    }

    public void setSizeId(Integer sizeId) {
        this.sizeId = sizeId;
    }

    public Integer getColorId() {
        return colorId;
    }

    public void setColorId(Integer colorId) {
        this.colorId = colorId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double subtotal() {
        return price * quantity;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof CartItem)) {
            return false;
        }
        CartItem ci = (CartItem) o;
        return productId == ci.productId
                && Objects.equals(sizeId, ci.sizeId)
                && Objects.equals(colorId, ci.colorId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(productId, sizeId, colorId);
    }
}
