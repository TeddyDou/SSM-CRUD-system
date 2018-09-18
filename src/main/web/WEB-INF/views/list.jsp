<%--
  Created by IntelliJ IDEA.
  User: tedzhang
  Date: 2018-09-16
  Time: 10:14 AM
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
                <table class="table table-hover">
                    <tr>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>option</th>
                    </tr>
                    <c:forEach items="${pageInfo.list}" var="emp">
                        <tr>
                            <th>${emp.empId}</th>
                            <th>${emp.empName }</th>
                            <th>${emp.gender == "M" ? "Male" : "Female"}</th>
                            <th>${emp.email}</th>
                            <th>${emp.department.deptName}</th>
                            <th>
                                <button class="btn btn-primary btn-sm">
                                    <span class="fas fa-pencil-alt"></span>
                                    add
                                </button>
                                <button class="btn btn-danger btn-sm">
                                    <span class="fas fa-trash-alt"></span>
                                    delete
                                </button>
                            </th>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
        <%--显示分页--%>
        <div class="row">
            <%--分页信息--%>
            <div class="col-lg-8">
                Current page: ${pageInfo.pageNum} | Total pages: ${pageInfo.pages} | Total records: ${pageInfo.total}
            </div>
            <%--分页条--%>
            <div class="col-lg-4">
                <nav aria-label="Page navigation example">
                    <ul class="pagination">
                        <li class="page-item"><a class="page-link" href="${APP_PATH}/emps?pn=1">First</a></li>
                        <c:if test="${!pageInfo.hasPreviousPage}">
                        <li class="page-item disabled">
                        </c:if>
                        <c:if test="${pageInfo.hasPreviousPage}">
                        <li class="page-item ">
                        </c:if>
                            <a class="page-link" href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                            <span class="sr-only">Previous</span>
                            </a>
                        </li>
                        <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                            <c:if test="${page_Num == pageInfo.pageNum}">
                                <li class="page-item active"><a class="page-link" href="#">${page_Num}</a></li>
                            </c:if>
                            <c:if test="${page_Num != pageInfo.pageNum}">
                                <li class="page-item">
                                    <a class="page-link" href="${APP_PATH}/emps?pn=${page_Num}">${page_Num}</a>
                                </li>
                            </c:if>
                        </c:forEach>

                        <c:if test="${!pageInfo.hasNextPage}">
                        <li class="page-item disabled">
                        </c:if>
                        <c:if test="${pageInfo.hasNextPage}">
                        <li class="page-item ">
                        </c:if>
                            <a class="page-link" href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                                <span class="sr-only">Next</span>
                            </a>
                        </li>

                        <li class="page-item">
                            <a class="page-link" href="${APP_PATH}/emps?pn=${pageInfo.pages}">End</a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
    <%--引入js文件--%>
    <script src="${APP_PATH}/static/js/jquery.min.js"></script>
    <script src="${APP_PATH}/static/js/popper.min.js"></script>
    <script src="${APP_PATH}/static/js/bootstrap.min.js"></script>
</body>
</html>
