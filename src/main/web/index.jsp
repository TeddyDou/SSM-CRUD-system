<%--
  Created by IntelliJ IDEA.
  User: tedzhang
  Date: 2018-09-21
  Time: 3:13 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Employee list</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <%--引入bootstrap css样式--%>
    <link rel="stylesheet" href="${APP_PATH}/static/css/bootstrap.min.css">
    <%--引入font awesome样式，通过CDN--%>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"
          integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
</head>
<body>
<%--搭建显示页面--%>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-lg-12">
            <h1>SSM CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-lg-4 offset-lg-8">
            <button class="btn btn-primary btn-sm">Add</button>
            <button class="btn btn-danger btn-sm">Delete</button>
        </div>
    </div>
    <%--显示表格--%>
    <div class="row">
        <div class="col-lg-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>option</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <%--显示分页--%>
    <div class="row">
        <%--分页信息--%>
        <div class="col-lg-8" id="page-info-area"></div>
        <%--分页条--%>
        <div class="col-lg-4" id="page-nav-area">

        </div>
    </div>
</div>

<%--引入js文件--%>
<script src="${APP_PATH}/static/js/jquery.min.js"></script>
<script src="${APP_PATH}/static/js/popper.min.js"></script>
<script src="${APP_PATH}/static/js/bootstrap.min.js"></script>

<script type="text/javascript">
    //send ajax request for employee info after page loading
    $(function () {
        to_page(1);
    });
    
    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + pn,
            type: "GET",
            success:function (result) {
                // employee info
                build_emps_table(result);
                // pagination info
                build_page_info(result);
                // navigate page info
                build_page_nav(result);
            }
        });
    }

    function build_emps_table (result) {
        //remove previous table data
        $("#emps_table tbody").empty();

        //build new table data of current page
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == "M" ? "Male" : "Female");
            var emailTd = $("<td></td>").append(item.empId);
            var deptName = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm")
                .append($("<span></span>").addClass("fas fa-pencil-alt")).append("edit");
            var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm")
                .append($("<span></span>").addClass("fas fa-trash-alt")).append("delete");
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(deleteBtn);
            $("<tr></tr>").append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptName)
                .append(btnTd)
                .appendTo("#emps_table tbody");

        });
        
    }

    function build_page_info(result) {
        //remove previous pagination data
        $("#page-info-area").empty();
        //display current pagination data
        $("#page-info-area").append("Current page: " + result.extend.pageInfo.pageNum + " | Total pages: " +
            result.extend.pageInfo.pages + " | Total records: " + result.extend.pageInfo.total);
    }

    function build_page_nav(result) {
        //remove previous navigate page data
        $("#page-nav-area").empty();
        //display current navigate page data
        var nav = $("<nav></nav>").attr("aria-label", "navigation example");
        var ul = $("<ul></ul>").addClass("pagination");
        //create firstPage element and previousPage element
        var firstPageLi =
            $("<li></li>").addClass("page-item")
                .append($("<a></a>").addClass("page-link").append("First").attr("href", "#"));
        var prePageLi =
            $("<li></li>").addClass("page-item")
                .append($("<a></a>").addClass("page-link").append("&laquo;").attr("href", "#"));
        if (!result.extend.pageInfo.hasPreviousPage) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }
        //add click event to firstPage element and previousPage element
        firstPageLi.click(function () {
            to_page(1);
        });
        prePageLi.click(function () {
            to_page(result.extend.pageInfo.pageNum - 1);
        });
        //create endPage element and nextPage element
        var nextPageLi =
            $("<li></li>").addClass("page-item")
                .append($("<a></a>").addClass("page-link").append("&raquo;").attr("href", "#"));
        var endPageLi =  $("<li></li>").addClass("page-item")
            .append($("<a></a>").addClass("page-link").append("End").attr("href", "#"));
        if (!result.extend.pageInfo.hasNextPage) {
            nextPageLi.addClass("disabled");
            endPageLi.addClass("disabled");
        }
        //add click event to endPage element and nextPage element
        nextPageLi.click(function () {
            to_page(result.extend.pageInfo.pageNum + 1);
        });
        endPageLi.click(function () {
            to_page(result.extend.pageInfo.pages);
        });
        // add firstPage element and previousPage element
        ul.append(firstPageLi).append(prePageLi);
        // add navigate page numbers
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").addClass("page-item")
                .append($("<a></a>").addClass("page-link").append(item).attr("href", "#"));
            if (item == result.extend.pageInfo.pageNum) {
                numLi.addClass("active"); 
            }
            numLi.click(function () {
                to_page(item);
            })
            ul.append(numLi);
        });
        // add endPage element and nextPage element
        ul.append(nextPageLi).append(endPageLi);
        nav.append(ul);
        nav.appendTo("#page-nav-area")
    }
</script>
</body>
</html>
