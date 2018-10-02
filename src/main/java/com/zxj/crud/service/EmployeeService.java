package com.zxj.crud.service;

import com.zxj.crud.bean.Employee;
import com.zxj.crud.bean.EmployeeExample;
import com.zxj.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 查询所有员工与部门信息
     * @return
     */
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    /**
     * check if the input name already exists
     * @param empName
     * @return
     */
    public boolean checkUser(String empName) {
        EmployeeExample example = new EmployeeExample();
        example.createCriteria().andEmpNameEqualTo(empName);
        return employeeMapper.countByExample(example) == 0;
    }

    /**
     * select employee by empId(the primary key)
     * @param empId
     * @return
     */
    public Employee getEmp(Integer empId) {
        return employeeMapper.selectByPrimaryKey(empId);
    }

    /**
     * update employee info by input employee
     * @param employee
     */
    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }
}
