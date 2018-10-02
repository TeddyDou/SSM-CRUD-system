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

<!-- Modal for updating selected employee data -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="empUpdateModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="empUpdateModalLabel">Update Employee Info</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <%--form for updating new employee info--%>
                <form id="update_emp_form" novalidate>
                    <div class="form-group row">
                        <label class="col-sm-3 col-form-label">Last Name</label>
                        <div class="col-sm-9">
                            <input type="text" readonly class="form-control-plaintext" id="empName_update_input">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 col-form-label">Email</label>
                        <div class="col-sm-9">
                            <input type="email" class="form-control" name="email" id="email_update_input"
                                   placeholder="email@zxj.com" required>
                            <div class="invalid-feedback">
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 col-form-label form-inline">Gender</label>
                        <div class="col-sm-9 form-inline">
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" id="gender1_update_input"
                                       value="M" checked="checked">
                                <label class="form-check-label" for="gender1_update_input">Male</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" id="gender2_update_input"
                                       value="F">
                                <label class="form-check-label" for="gender2_update_input">Female</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 col-form-label">deptName</label>
                        <div class="col-sm-5">
                            <%--only need to submit department Id--%>
                            <select class="form-control" name="dId" required></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="update_emp_btn">Update changes</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal for adding new employee data -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="empAddModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="empAddModalLabel">Add Employee</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <%--form for adding new employee info--%>
                <form id="add_emp_form" novalidate>
                    <div class="form-group row">
                        <label class="col-sm-3 col-form-label">Last Name</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="empName" id="empName_add_input"
                                   placeholder="empName" required>
                            <div class="invalid-feedback">
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 col-form-label">Email</label>
                        <div class="col-sm-9">
                            <input type="email" class="form-control" name="email" id="email_add_input"
                                   placeholder="email@zxj.com" required>
                            <div class="invalid-feedback">
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 col-form-label form-inline">Gender</label>
                        <div class="col-sm-9 form-inline">
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" id="gender1_add_input"
                                       value="M" checked="checked">
                                <label class="form-check-label" for="gender1_add_input">Male</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" id="gender2_add_input"
                                       value="F">
                                <label class="form-check-label" for="gender2_add_input">Female</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 col-form-label">deptName</label>
                        <div class="col-sm-5">
                            <%--only need to submit department Id--%>
                            <select class="form-control" name="dId" required></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="save_emp_btn">Save changes</button>
            </div>
        </div>
    </div>
</div>

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
            <button class="btn btn-primary btn-sm" id="emp_add_modal_btn">Add</button>
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
        <div class="col-lg-8" id="page_info_area"></div>
        <%--分页条--%>
        <div class="col-lg-4" id="page_nav_area">

        </div>
    </div>
</div>

<%--引入js文件--%>
<script src="${APP_PATH}/static/js/jquery.min.js"></script>
<script src="${APP_PATH}/static/js/popper.min.js"></script>
<script src="${APP_PATH}/static/js/bootstrap.min.js"></script>

<script type="text/javascript">
    var totalRecord, currentPageNum;
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
            var emailTd = $("<td></td>").append(item.email);
            var deptName = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit-btn")
                .append($("<span></span>").addClass("fas fa-pencil-alt")).append("edit").attr("update-id",
                    item.empId);
            var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete-btn")
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
        $("#page_info_area").empty();
        //display current pagination data
        $("#page_info_area").append("Current page: " + result.extend.pageInfo.pageNum + " | Total pages: " +
            result.extend.pageInfo.pages + " | Total records: " + result.extend.pageInfo.total);
        totalRecord = result.extend.pageInfo.total;
    }

    function build_page_nav(result) {
        //remove previous navigate page data
        $("#page_nav_area").empty();
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
        // get the current page number
        currentPageNum = result.extend.pageInfo.pageNum;
        // add endPage element and nextPage element
        ul.append(nextPageLi).append(endPageLi);
        nav.append(ul);
        nav.appendTo("#page_nav_area")
    }

    function reset_add_modal(ele) {
        ele[0].reset();
        ele.removeClass("was-validated");
        ele.find("*").removeClass("is-valid is-invalid");
        ele.find(".invalid-feedback").text("");
    }

    // modal pop up when click on add button
    $("#emp_add_modal_btn").click(function () {
        // reset form content and styles
        reset_add_modal($("#empAddModal form"));
        // send ajax request to query department info, to display on pop-up modal
        get_depts("#empAddModal select");
        $("#empAddModal").modal({
            backdrop:"static"
        });
    });
    
    function get_depts(ele) {
        $.ajax({
            url:"${APP_PATH}/depts",
            type:"GET",
            success: function (result) {
                //show department info in the select form on pop-up modal
                $(ele).empty();
                $.each(result.extend.depts, function () {
                    var optionElement = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionElement.appendTo($(ele))
                 })
            }
        });
    }

    function client_side_validate_name(input) {
        input.attr("pattern", "^([A-Z])[a-z]{2,15}$");
        if (!input[0].checkValidity()){
            input.next().text("Name should be 3-16 chars with initial capitalization.");
            return false;
        } else
            return true;
    }


    //^[A-Za-z\d]+([-_\.][A-Za-z\d]+)*@[A-Za-z\d]+\.[a-zA-Z\d]{2,4}$
    // ^[A-Za-zd]+([-_.][A-Za-zd]+)*@[A-Za-zd]+.[a-zA-Zd]{2,4}$
    function client_side_validate_email(input) {
        input.attr("pattern", "^[A-Za-z\\d]+([-_\\.][A-Za-z\\d]+)*@[A-Za-z\\d]+\\.[a-zA-Z\\d]{2,4}$");
        if (!input[0].checkValidity()) {
            input.next().text("Email format is incorrect.");
            return false;
        } else{
            return true;
        }

    }

    function client_side_validate_employee_info(ele) {
        var isValid;
        ele.removeClass("was-validated");
        isValid = client_side_validate_name(ele.find($("input[name=empName]")))
            && client_side_validate_email(ele.find($("input[name=email]")));
        ele.addClass("was-validated");
        return isValid;
    }

    // function for server side validation for existence of input empName
    function server_side_validate_employee_name(ele) {
        // ele.closest("form").removeClass("was-validated");
        ele.removeClass("is-valid is-invalid");
        var inputName = ele.val();
        $.ajax({
            url: "${APP_PATH}/checkuser",
            type: "POST",
            data: "empName=" + inputName,
            success: function (result) {
                if (result.code == 100) {
                    //valid
                    ele.addClass("is-valid");
                    return true;

                } else {
                    //invalid
                    ele.addClass("is-invalid");
                    ele.next().text("Input name already exists");
                    return false;
                }
            }
        });
    }

    // server side validation for existence of input empName
    $("#empName_add_input").change(function () {
        server_side_validate_employee_name($(this));
    })

    // save button on click
    $("#save_emp_btn").click(function () {
        if (!client_side_validate_employee_info($("#empAddModal form"))){
            return false;
        }
        if (!server_side_validate_employee_name($("#empName_add_input"))){
            return false;
        }

        // save employee info to server
        $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data:$("#empAddModal form").serialize(),
            success:function () {
                // 1. close pop-up modal
                $("#empAddModal").modal('hide');
                // 2. go to the last page so that it shows the new employee
                to_page(totalRecord);
            }
        });
    })

    // modal pop up when click on edit button
    $(document).on("click", ".edit-btn", function () {
        // 1. obtain employee info
        get_employ($(this).attr("update-id"));

        //new********
        // var btn = $(this);
        // var promise = new Promise(function(resolve, reject) {
        //     get_employ(btn.attr("update-id"));
        //     get_depts("#empUpdateModal select");
        //     resolve();
        // })

        // pass this employee id to update button for sending ajax request
        $("#update_emp_btn").attr("update-id", $(this).attr("update-id"))
        // 2. obtain dept info
        get_depts("#empUpdateModal select");
        // 3. show update employee modal
        $("#update_emp_form").removeClass("was-validated");
        $("#empUpdateModal").modal({
            backdrop:"static"
        });

        //new********
        // promise.then(function () {
        //     $("#update_emp_form").removeClass("was-validated");
        //     $("#empUpdateModal").modal({
        //         backdrop:"static"
        //     });
        // })
    })

    function get_employ(empId) {
        $.ajax({
            url:"${APP_PATH}/emp/" + empId,
            type:"GET",
            success: function (result) {
                var emp = result.extend.emp;
                $("#empName_update_input").attr("value", emp.empName);
                $("#email_update_input").val(emp.email);
                $("#empUpdateModal input[name=gender]").val([emp.gender]);
                $("#empUpdateModal select").val([emp.dId]);
                // $.each($("#empUpdateModal select").find($("option")), function () {
                //     if ($(this).val() == emp.dId) {
                //         $(this).attr("selected", "selected");
                //     }
                //     else {
                //         $(this).attr("unselected", "unselected");
                //     }
                // });
            }
        });
    }



    $("#update_emp_btn").click(function () {
        var update_form = $("#update_emp_form");
        // validate email format
        update_form.addClass("was-validated");
        if (!client_side_validate_email(update_form.find($("input[name=email]")))){
            return false;
        };

        // send ajax request
        $.ajax({
            url: "${APP_PATH}/emp/" + $(this).attr("update-id"),
            type:"POST",
            data:update_form.serialize()+"&_method=PUT",
            success: function (result) {
                // console.log(result);
                // 1. close pop-up modal
                $("#empUpdateModal").modal('hide');
                // 2. go to the same page to show updated emp info
                to_page(currentPageNum);
            }
        });
    })
</script>
</body>
</html>
