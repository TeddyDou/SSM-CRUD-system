package com.zxj.crud.controller;

import com.zxj.crud.bean.Department;
import com.zxj.crud.bean.Msg;
import com.zxj.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * process requests related to department
 */
@Controller
public class DepartmentController {

    @Autowired
    DepartmentService departmentService;

    //return all the department info
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts() {
        List<Department> list = departmentService.getDepts();
        return Msg.success().add("depts", list);
    }
}
