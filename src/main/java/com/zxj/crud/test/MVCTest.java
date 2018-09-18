package com.zxj.crud.test;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;
import com.zxj.crud.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml",
        "file:/Users/tedzhang/git/small-projects/ssm-crud/src/main/web/WEB-INF/dispatcherServlet-servlet.xml"})
public class MVCTest {

    //传入spring mvc的ioc容器
    @Autowired
    WebApplicationContext context;

    //虚拟的mvc
    MockMvc mockMvc;

    @Before
    public void initMvc() {
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        //perform方法模拟发送请求,那会返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "8")).andReturn();
        //请求成功以后，请求域中会有PageInfo，取出来进行验证
        MockHttpServletRequest request = result.getRequest();
        PageInfo info = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码" + info.getPageNum());
        System.out.println("总页码" + info.getPages());
        System.out.println("总计路数" + info.getTotal());
        int[] nums = info.getNavigatepageNums();
        for (int i : nums){
            System.out.println(" " + i);
        }

        //获取员工数据
        List<Employee> emps = info.getList();
        for (Employee e : emps){
            System.out.println("ID: " + e.getEmpId() + " ==> name: " +  e.getEmpName());
        }
    }
}
