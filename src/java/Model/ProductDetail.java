/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author dungdzpro
 */
public class ProductDetail {
    private int pdid;
    private int pid;
    private int cid;
    private int sid;
   
    private int quantity;
    private int status;
    public ProductDetail(int pdid, int pid, int cid, int sid, int quantity) {
        this.pdid = pdid;
        this.pid = pid;
        this.cid = cid;
        this.sid = sid;
        this.quantity = quantity;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
 
    public int getPdid() {
        return pdid;
    }

    public void setPdid(int pdid) {
        this.pdid = pdid;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public int getSid() {
        return sid;
    }

    public void setSid(int sid) {
        this.sid = sid;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "ProductDetail{" + "pdid=" + pdid + ", pid=" + pid + ", cid=" + cid + ", sid=" + sid + ", qid=" + quantity + '}';
    }
    
}
