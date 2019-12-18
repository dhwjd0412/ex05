package com.example.web;



import javax.inject.Inject;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.example.persistence.AddressDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class DBTest {
	@Inject
	AddressDAO dao;
	
	@Test
	public void list(){
		dao.list(0);
	}
	@Test
	public void total(){
		dao.total();
	}
	
}
