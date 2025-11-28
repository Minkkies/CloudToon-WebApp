<%-- 
    Document   : formsave
    Created on : Sep 4, 2025, 2:36:35 PM
    Author     : Admin
--%>

<%@page import="java.sql.*" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>จัดการข้อมูลการ์ตูน</title>
        <!-- Favicon -->
        <link rel="icon" type="image/svg+xml"
              href='data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" fill="lightblue"  viewBox="0 0 16 16"><path d="M4.406 3.342A5.53 5.53 0 0 1 8 2c2.69 0 4.923 2 5.166 4.579C14.758 6.804 16 8.137 16 9.773 16 11.569 14.502 13 12.687 13H3.781C1.708 13 0 11.366 0 9.318c0-1.763 1.266-3.223 2.942-3.593.143-.863.698-1.723 1.464-2.383"/></svg>'>
        <!-- Bootstrap Icons --> 
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="../stylesheet.css">
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
                จัดการข้อมูลการ์ตูน
            </h1>

        </div>

        <div class="box">

            <!--Form Add Cartoon-->
            <div class="box">
                <div class="item-box">
                    <div id="Add" class="frame-bg">
                        <h1>Add</h1>
                        <form action="/JraBraWeb/UploadCartoon" method="post" enctype="multipart/form-data">
                            <!--
                     Title: <input type="text" name="title"><br>
                    Status: <input type="text" name="status"><br>
                    Short Story: <input type="text" name="short_story"><br>
                    Cover: <input type="file" name="cover"><br>
                    <input type="submit" value="Add">
                            -->

                            Title:
                            <input class="form-control" type="text" name="title" placeholder="Default input"
                                   aria-label="default input example">

                            Status
                            <input class="form-control" type="text" name="status" placeholder="Default input"
                                   aria-label="default input example">

                            Short Story:
                            <input class="form-control" type="text" name="short_story" placeholder="Default input"
                                   aria-label="default input example">

                            <!<!-- Cover -->
                            <div class="mb-3">
                                <label for="formFile" class="form-label"></label>
                                <input class="form-control" type="file" id="formFile" name="cover">
                            </div>
                            <!<!-- button -->
                            <div class="box-button">
                                <button type="submit" class="button button-insert">
                                    <span>Submit</span>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- delete -->
            <div class="box">
                <div class="item-box">
                    <div id="Delete" class="frame-bg">
                        <h1>Delete</h1>
                        <form action="/JraBraWeb/DeleteCartoon" method="POST" onsubmit="return confirmDelete()" >
                            id:
                            <input class="form-control" type="number" name="id_cartoon" placeholder="Default input" min="1"
                                   aria-label="default input example">

                            <div class="box-button">
                                <button type="submit" class="button button-delete">
                                    <span>Delete</span>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!------------->

        <script>
            function confirmDelete() {
                return confirm('คุณแน่ใจหรือไม่ที่จะลบข้อมูลนี้?'); //เด้งเป็น alert
            }
        </script>
    </body>
</html>
