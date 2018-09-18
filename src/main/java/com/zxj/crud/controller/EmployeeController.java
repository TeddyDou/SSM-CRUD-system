package com.zxj.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zxj.crud.bean.Employee;
import com.zxj.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/**
 * 处理员工crud请求
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;
    /**
     * 查询员工数据（分页查询）
     * @return
     */
    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1")Integer pn, Model model) {
        //需要引入分页插件page helper
        PageHelper.startPage(pn, 5);
        //pagehelper后面紧跟的查询则为分页查询
        List<Employee> emps = employeeService.getAll();
        //PageInfo封装了查询出来的结果，只需将pageinfo返回给页面即可
        PageInfo page = new PageInfo(emps, 5);
        model.addAttribute("pageInfo", page);
        return "list";
    }
}