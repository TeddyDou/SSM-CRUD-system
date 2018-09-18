package com.zxj.crud.test;

import com.zxj.crud.bean.Department;
import com.zxj.crud.bean.Employee;
import com.zxj.crud.bean.EmployeeExample;
import com.zxj.crud.dao.DepartmentMapper;
import com.zxj.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.LinkedList;
import java.util.List;
import java.util.UUID;

/**
 * 测试dao层的工作
 * Spring 项目可以使用spring自带的单元测试，可以自动注入需要的组件
 * 1 导入spring test模块
 * 2 @ContextConfiguration指定Spring配置文件的位置
 * 3 直接使用auto wire要使用的组件即可
 */

@RunWith(value=SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="classpath:applicationContext.xml")
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    /**
     * 测试DepartmentMapper
     */
    @Test
    public void testCRUD(){
        /*
        //可以自己配置，也可以用spring test 模块
        //1 创建ioc容器，
        ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
        //2 从容器中获取mapper
        ioc.getBean(DepartmentMapper.class);
        */
        System.out.println(departmentMapper);
        //1 插入几个部门
//        departmentMapper.insertSelective(new Department(null, "development"));
//        departmentMapper.insertSelective(new Department(null, "test"));

        //2 生成员工数据，测试员工插入
//        employeeMapper.insertSelective(new Employee(null, "Jerry", "M", "jerry@zxj.com", 1));

        //3 批量插入多个员工，用可以执行批量操作的sqlSession
//        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
//        for (int i = 0; i < 1000; i++) {
//            String uid = UUID.randomUUID().toString().substring(0, 5) + i;
//            mapper.insertSelective(new Employee(null, uid, "M", uid + "@zxj.com", 1));
//        }
//        System.out.println("批量完成");

        //4 测试select和update员工数据
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpNameGreaterThanOrEqualTo("a");
        List<Employee> emplyees = employeeMapper.selectByExample(employeeExample);
        System.out.println("数量为：+ " + emplyees.size());
        employeeMapper.updateByExampleSelective(new Employee(null,null,"F",null,null), employeeExample);
    }
}
