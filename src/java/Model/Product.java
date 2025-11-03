/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

/**
 *
 * @author trinh
 */
public class Product {
    private int id;
    private String name;
    private String image;
    private double price;
    private int status;
    private String brand;
    private String category;

    

    public Product() {
    }

    public Product(int id, String name, String image, double price, String category,String brand,int status) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.price = price;
        this.status = status;
        this.brand = brand;
        this.category = category;
    }

    
    public Product(int id, String name, String image, double price) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.price = price;
        
        
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }
    
    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
   
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "Product{" + "id=" + id + ", name=" + name + ", image=" + image + ", price=" + price + ", status=" + status + ", brand=" + brand + ", category=" + category + '}';
    }

    

    

    

   
    
    
}
