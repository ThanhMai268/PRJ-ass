/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author dungdzpro
 */
public class Size {
    private int SizeID;
    private int SizeValue;

    public Size(int SizeID, int SizeValue) {
        this.SizeID = SizeID;
        this.SizeValue = SizeValue;
    }

    public int getSizeID() {
        return SizeID;
    }

    public void setSizeID(int SizeID) {
        this.SizeID = SizeID;
    }

    public int getSizeValue() {
        return SizeValue;
    }

    public void setSizeValue(int SizeValue) {
        this.SizeValue = SizeValue;
    }
    
}
