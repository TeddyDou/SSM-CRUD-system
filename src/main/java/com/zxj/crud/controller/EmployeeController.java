package com.zxj.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zxj.crud.bean.Employee;
import com.zxj.crud.bean.Msg;
import com.zxj.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 处理员工crud请求
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmp(Employee employee) {
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /**
     * select employee by empId
     * @param empId
     * @return
     */
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("empId") Integer empId) {
        Employee employee = employeeService.getEmp(empId);
        return Msg.success().add("emp", employee);
    }

    /**
     * insert new employee into database server
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(Employee employee) {
        employeeService.saveEmp(employee);
        return Msg.success();
    }

    /**
     * 需要导入jackson包，转化结果为json对象
     * @param pn
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        //需要引入分页插件page helper
        PageHelper.startPage(pn, 5);
        //pagehelper后面紧跟的查询则为分页查询
        List<Employee> emps = employeeService.getAll();
        //PageInfo封装了查询出来的结果，只需将pageinfo返回给页面即可
        PageInfo page = new PageInfo(emps, 5);
        return Msg.success().add("pageInfo", page);
    }

    /**
     * check if input name already exists
     * @param empName
     * @return
     */
    @RequestMapping("/checkuser")
    @ResponseBody
    public Msg checkDuplicatedName(@RequestParam(value = "empName") String empName) {
        if (employeeService.checkUser(empName))
            return Msg.success();
        else
            return Msg.fail();
    }

    /**
     * 查询员工数据（分页查询）
     * @return
     */
//    @RequestMapping("/emps")
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
