/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package connectDB;
import java.sql.*;
/**
 *
 * @author Admin
 */
public class MyCon {
    
    public MyCon(){
        try {
           Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        } catch (Exception e){
            System.out.println(e);
        }
    }
    
    public Connection myConnect(){
         Connection my=null;
         try {
                my = DriverManager.getConnection("jdbc:mysql://localhost/projectweb2204?allowPublicKeyRetrieval=true&useSSL=false", "root", "mink20685");
               } catch (Exception e) {
                    System.out.println(e);
                }
         return my;
     }
}