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
   
    private int qid;

    public ProductDetail(int pdid, int pid, int cid, int sid, int qid) {
        this.pdid = pdid;
        this.pid = pid;
        this.cid = cid;
        this.sid = sid;
        this.qid = qid;
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

    public int getQid() {
        return qid;
    }

    public void setQid(int qid) {
        this.qid = qid;
    }

    @Override
    public String toString() {
        return "ProductDetail{" + "pdid=" + pdid + ", pid=" + pid + ", cid=" + cid + ", sid=" + sid + ", qid=" + qid + '}';
    }
    
}
