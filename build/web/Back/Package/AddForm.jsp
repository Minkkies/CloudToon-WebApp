<%-- 
    Document   : AddForm
    Created on : Oct 9, 2025, 11:23:35 PM
    Author     : Admin
--%>

<%@page import="java.sql.*" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>เพิ่มแพ็คเกจ</title>
        <!-- Favicon -->
        <link rel="icon" type="image/svg+xml"
              href='data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" fill="lightblue"  viewBox="0 0 16 16"><path d="M4.406 3.342A5.53 5.53 0 0 1 8 2c2.69 0 4.923 2 5.166 4.579C14.758 6.804 16 8.137 16 9.773 16 11.569 14.502 13 12.687 13H3.781C1.708 13 0 11.366 0 9.318c0-1.763 1.266-3.223 2.942-3.593.143-.863.698-1.723 1.464-2.383"/></svg>'>
        <!-- Bootstrap Icons --> 
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="../../stylesheet.css">
        <!--bootstrap-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">

        <!-- css -->
        <style>
            .button-insert {
                background-color: gray;
                border: none;
            }

            .button-update {
                background: gray;
                border: none;
            }

            .button-delete {
                margin-bottom: 10px;
                background: gray;
                border: none;
            }

            .button{
                margin-top: 15px;
            }
        </style>
    </head>

    <body>
        <!--bootstrap-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous">
        </script>

        <div class="box">
            <h1 class="header-title">
                เพิ่มแพ็คเกจ
            </h1>
                <!--Form Add Cartoon-->
                <div class="box">
                    <div class="item-box">
                        <div class="frame-bg">

                            <!-- เพิ่มตอน -->
                            <h1>Add Episode</h1>
                             <form action="AddPackage.jsp" >

                                <label>Package ID:</label>
                                <input class="form-control" type="number" name="package_id" required placeholder="รหัสแพ็คเกจ">

                                <label>Package Name:</label>
                                <input class="form-control" type="text" name="package_name" required >

                                <label>Price:</label>
                                <input class="form-control" type="number" name="price" required >
                                
                                <label>Coins:</label>
                                <input class="form-control" type="number" name="coins" required >

                                <button class="button button-insert" type="submit" name="action" value="Upload">Upload</button>
                              
                            </form>
                        </div>
                    </div>
                </div>
            </div>
    </body>
</html>